"""Firebase Functions for Haiku Image Generation.

Gemini APIを使用して俳句から画像を生成し、Firebase Storageに保存する。
"""

from typing import Any

from firebase_admin import firestore, initialize_app, storage
from firebase_functions import https_fn, options
from firebase_functions.params import SecretParam

# Firebase Admin SDK初期化
initialize_app()

# Secret Managerからgemini API keyを取得
GEMINI_API_KEY = SecretParam("GEMINI_API_KEY")


@https_fn.on_call(
    secrets=[GEMINI_API_KEY],
    timeout_sec=120,
    memory=options.MemoryOption.MB_512,
    cors=options.CorsOptions(
        cors_origins="*",
        cors_methods="GET,POST,OPTIONS",
    ),
)
def generate_and_save_image(req: https_fn.CallableRequest) -> dict[str, Any]:
    """俳句から画像を生成してFirebase Storageに保存する。

    Args:
        req: CallableRequest containing:
            - prompt: 画像生成用プロンプト
            - haikuId: 俳句ID (optional)
            - firstLine: 上の句 (optional)
            - secondLine: 中の句 (optional)
            - thirdLine: 下の句 (optional)

    Returns:
        dict: {"success": True, "imageUrl": "..."}

    Raises:
        HttpsError: 認証エラーまたは生成エラー
    """
    print("=== generate_and_save_image START ===", flush=True)
    print(f"req.auth: {req.auth}", flush=True)
    print(f"req.data: {req.data}", flush=True)

    # 認証チェック
    if req.auth is None:
        print("Authentication failed: req.auth is None", flush=True)
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="認証が必要です",
        )

    print(f"User authenticated: uid={req.auth.uid}", flush=True)

    # パラメータ取得
    data = req.data
    prompt = data.get("prompt")
    haiku_id = data.get("haikuId")
    first_line = data.get("firstLine", "")
    second_line = data.get("secondLine", "")
    third_line = data.get("thirdLine", "")

    print(f"Parameters: prompt length={len(prompt) if prompt else 0}, haiku_id={haiku_id}", flush=True)

    if not prompt:
        print("Prompt is empty or None", flush=True)
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="プロンプトが必要です",
        )

    try:
        # Gemini API (REST API直接呼び出し - gemini-3-pro-image-preview モデル使用)
        print("Calling Gemini API via REST...", flush=True)
        import base64
        import requests

        # 元のコードと同じモデルを使用
        api_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-image-preview:streamGenerateContent?key={GEMINI_API_KEY.value}"

        payload = {
            "contents": [
                {
                    "role": "user",
                    "parts": [
                        {"text": prompt}
                    ]
                }
            ],
            "generationConfig": {
                "responseModalities": ["IMAGE", "TEXT"],
                "imageConfig": {"aspectRatio": "4:5"}
            }
        }

        response = requests.post(
            api_url,
            json=payload,
            headers={"Content-Type": "application/json"},
            timeout=90
        )
        print(f"Gemini API response status: {response.status_code}", flush=True)

        if response.status_code != 200:
            print(f"Gemini API error: {response.text}", flush=True)
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INTERNAL,
                message=f"Gemini API error: {response.status_code}",
            )

        # streamGenerateContent は配列形式で返される
        result = response.json()
        print(f"Gemini response received, type={type(result)}", flush=True)

        # 画像データ抽出
        print("Extracting image data...", flush=True)
        image_data = None

        # 配列形式の場合
        if isinstance(result, list):
            if result:
                candidates = result[0].get("candidates", [])
            else:
                candidates = []
        else:
            candidates = result.get("candidates", [])

        if candidates:
            print(f"Number of candidates: {len(candidates)}", flush=True)
            parts = candidates[0].get("content", {}).get("parts", [])
            for i, part in enumerate(parts):
                print(f"Part {i}: keys={list(part.keys())}", flush=True)
                if "inlineData" in part:
                    inline_data = part["inlineData"]
                    image_base64 = inline_data.get("data")
                    if image_base64:
                        image_data = base64.b64decode(image_base64)
                        print(f"Found image data, size={len(image_data)} bytes", flush=True)
                        break
        else:
            print("No candidates in response", flush=True)

        if image_data is None:
            print("No image data extracted from response", flush=True)
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INTERNAL,
                message="画像の生成に失敗しました",
            )

        # ファイル名生成
        import uuid
        from datetime import datetime

        if haiku_id:
            file_name = f"haiku-images/{haiku_id}.png"
        else:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            unique_id = str(uuid.uuid4())[:8]
            file_name = f"haiku-images/{timestamp}_{unique_id}.png"

        print(f"Uploading to Storage: {file_name}", flush=True)

        # Firebase Storageに保存
        bucket = storage.bucket()
        blob = bucket.blob(file_name)
        blob.upload_from_string(image_data, content_type="image/png")

        # 公開URLを取得
        blob.make_public()
        image_url = blob.public_url
        print(f"Image uploaded, URL: {image_url}", flush=True)

        # Firestoreにメタデータを保存（オプション）
        if haiku_id:
            print(f"Saving metadata to Firestore for haiku_id={haiku_id}", flush=True)
            db = firestore.client()
            db.collection("haiku_images").document(haiku_id).set(
                {
                    "imageUrl": image_url,
                    "firstLine": first_line,
                    "secondLine": second_line,
                    "thirdLine": third_line,
                    "createdAt": firestore.SERVER_TIMESTAMP,
                    "userId": req.auth.uid,
                },
                merge=True,
            )

        print("=== generate_and_save_image SUCCESS ===", flush=True)
        return {"success": True, "imageUrl": image_url}

    except https_fn.HttpsError:
        raise
    except Exception as e:
        import traceback
        print(f"Unexpected error: {e}", flush=True)
        print(traceback.format_exc(), flush=True)
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message=f"画像生成エラー: {str(e)}",
        ) from e
