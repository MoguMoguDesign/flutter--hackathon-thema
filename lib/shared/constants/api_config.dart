/// API 設定
///
/// API キーを管理する設定クラス。
///
/// TODO: 本番環境では環境変数から取得するように変更する
class ApiConfig {
  ApiConfig._();

  /// Gemini API キー
  // ignore: do_not_hardcode_secrets
  static const String geminiApiKey = 'AIzaSyATSjXts7-jC-6KQTHmo7uDv_taJZmsokM';

  /// Gemini API キーが設定されているかをチェック
  ///
  /// Returns: API キーが設定されている場合は true
  static bool get hasGeminiApiKey => geminiApiKey.isNotEmpty;

  /// Gemini API のベース URL
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta';

  /// Gemini 画像生成モデル ID
  static const String geminiImageModel = 'gemini-3-pro-image-preview';

  /// API リクエストのタイムアウト時間（秒）
  static const int requestTimeoutSeconds = 60;
}
