"""Firebase Functions for Haiku Image Generation.

Gemini APIを使用して俳句画像を生成し、
Firebase StorageとFirestoreに保存する。
"""

import base64
import time
from typing import Any

import google.generativeai as genai
from firebase_admin import firestore, initialize_app, storage
from firebase_functions import https_fn, options
from firebase_functions.params import SecretParam

# Firebase Admin SDKを初期化
initialize_app()

# Secret Managerから取得するAPIキー
GEMINI_API_KEY = SecretParam("GEMINI_API_KEY")


@https_fn.on_call(
    secrets=[GEMINI_API_KEY],
    timeout_sec=120,
    memory=options.MemoryOption.MB_512,
)
def generate_and_save_image(req: https_fn.CallableRequest) -> dict[str, Any]:
    """画像を生成してFirebase Storageに保存する。

    Args:
        req: Firebase Functionsのリクエストオブジェクト

    Returns:
        生成された画像のURLを含む辞書

    Raises:
        HttpsError: 認証エラー、入力エラー、または内部エラー
    """
    # 認証チェック
    if req.auth is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="認証が必要です",
        )

    user_id = req.auth.uid
    data = req.data

    # 入力バリデーション
    prompt = data.get("prompt")
    if not prompt:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="プロンプトが必要です",
        )

    haiku_id = data.get("haikuId")
    first_line = data.get("firstLine", "")
    second_line = data.get("secondLine", "")
    third_line = data.get("thirdLine", "")

    try:
        # 1. Gemini APIで画像生成
        genai.configure(api_key=GEMINI_API_KEY.value)
        model = genai.GenerativeModel("gemini-2.0-flash-exp-image-generation")

        response = model.generate_content(
            contents=prompt,
            generation_config=genai.GenerationConfig(
                response_modalities=["IMAGE", "TEXT"],
            ),
        )

        # 2. 画像データを取得
        image_data = None
        mime_type = "image/jpeg"

        for part in response.candidates[0].content.parts:
            if hasattr(part, "inline_data") and part.inline_data:
                image_data = base64.b64decode(part.inline_data.data)
                mime_type = part.inline_data.mime_type or mime_type
                break

        if image_data is None:
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INTERNAL,
                message="画像生成に失敗しました",
            )

        # 3. Firebase Storageに保存
        bucket = storage.bucket()
        timestamp = int(time.time() * 1000)
        effective_haiku_id = haiku_id or f"haiku_{timestamp}"
        file_name = f"haiku_images/{user_id}/{effective_haiku_id}_{timestamp}.jpg"

        blob = bucket.blob(file_name)
        blob.upload_from_string(
            image_data,
            content_type=mime_type,
        )
        blob.metadata = {
            "firstLine": first_line,
            "secondLine": second_line,
            "thirdLine": third_line,
        }
        blob.patch()
        blob.make_public()

        image_url = blob.public_url

        # 4. Firestoreにメタデータ保存
        db = firestore.client()
        db.collection("generated_images").add({
            "userId": user_id,
            "haikuId": effective_haiku_id,
            "imageUrl": image_url,
            "prompt": prompt,
            "firstLine": first_line,
            "secondLine": second_line,
            "thirdLine": third_line,
            "createdAt": firestore.SERVER_TIMESTAMP,
        })

        # 5. URLを返却
        return {
            "imageUrl": image_url,
            "success": True,
        }

    except https_fn.HttpsError:
        raise
    except Exception as e:
        print(f"Image generation error: {e}")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message="画像生成に失敗しました",
        ) from e
