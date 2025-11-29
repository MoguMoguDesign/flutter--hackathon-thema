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
