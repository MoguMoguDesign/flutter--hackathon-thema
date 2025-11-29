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

/// Gemini API 例外クラス
///
/// Gemini API 呼び出し時のエラーを表現する。
/// ネットワークエラー、タイムアウト、APIエラー、不正なレスポンス形式を
/// それぞれ別の型として区別する。
sealed class GeminiApiException implements Exception {
  /// 例外を作成する
  const GeminiApiException(this.message);

  /// エラーメッセージ
  final String message;

  @override
  String toString() => 'GeminiApiException: $message';
}

/// ネットワークエラー
///
/// インターネット接続がない、またはサーバーに到達できない場合に発生する。
final class NetworkException extends GeminiApiException {
  /// ネットワークエラーを作成する
  const NetworkException([super.message = 'Network error occurred']);
}

/// タイムアウトエラー
///
/// API リクエストが指定時間内に完了しなかった場合に発生する。
final class TimeoutException extends GeminiApiException {
  /// タイムアウトエラーを作成する
  const TimeoutException([super.message = 'Request timed out']);
}

/// API エラー
///
/// Gemini API がエラーレスポンスを返した場合に発生する。
final class ApiErrorException extends GeminiApiException {
  /// API エラーを作成する
  const ApiErrorException([super.message = 'API error occurred']);
}

/// 不正なレスポンス形式エラー
///
/// API レスポンスが期待した形式と異なる場合に発生する。
final class InvalidResponseException extends GeminiApiException {
  /// 不正なレスポンス形式エラーを作成する
  const InvalidResponseException([super.message = 'Invalid response format']);
}
