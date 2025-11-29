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
/// 環境変数から API キーを読み込む設定クラス。
/// ビルド時に --dart-define=GEMINI_API_KEY=xxx で注入する。
class ApiConfig {
  ApiConfig._();

  /// Gemini API キー
  ///
  /// ビルド時に --dart-define=GEMINI_API_KEY=xxx で注入する。
  /// 環境変数が設定されていない場合は空文字列を返す。
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

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
