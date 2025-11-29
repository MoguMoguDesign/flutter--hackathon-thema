// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

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
