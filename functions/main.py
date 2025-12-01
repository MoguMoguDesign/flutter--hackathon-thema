"""Firebase Functions for Haiku Image Generation.

Gemini APIを使用して俳句から画像を生成し、Firebase Storageに保存する。
"""

from typing import Any

import google.generativeai as genai
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
    # 認証チェック
    if req.auth is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="認証が必要です",
        )

    # パラメータ取得
    data = req.data
    prompt = data.get("prompt")
    haiku_id = data.get("haikuId")
    first_line = data.get("firstLine", "")
    second_line = data.get("secondLine", "")
    third_line = data.get("thirdLine", "")

    if not prompt:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="プロンプトが必要です",
        )

    try:
        # Gemini API設定
        genai.configure(api_key=GEMINI_API_KEY.value)

        # 画像生成モデル
        model = genai.GenerativeModel("gemini-2.0-flash-exp")

        # 画像生成リクエスト
        response = model.generate_content(
            contents=prompt,
            generation_config=genai.GenerationConfig(
                response_modalities=["IMAGE", "TEXT"],
            ),
        )

        # 画像データ抽出
        image_data = None
        for part in response.candidates[0].content.parts:
            if hasattr(part, "inline_data") and part.inline_data is not None:
                image_data = part.inline_data.data
                break

        if image_data is None:
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

        # Firebase Storageに保存
        bucket = storage.bucket()
        blob = bucket.blob(file_name)
        blob.upload_from_string(image_data, content_type="image/png")

        # 公開URLを取得
        blob.make_public()
        image_url = blob.public_url

        # Firestoreにメタデータを保存（オプション）
        if haiku_id:
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

        return {"success": True, "imageUrl": image_url}

    except https_fn.HttpsError:
        raise
    except Exception as e:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message=f"画像生成エラー: {str(e)}",
        ) from e
