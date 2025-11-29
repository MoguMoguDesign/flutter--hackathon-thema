import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/shared/service/gemini_api_exception.dart';

void main() {
  group('GeminiApiException', () {
    group('NetworkException', () {
      test('デフォルトメッセージを持つ', () {
        const exception = NetworkException();
        expect(exception.message, equals('Network error occurred'));
      });

      test('カスタムメッセージを持つ', () {
        const exception = NetworkException('カスタムエラー');
        expect(exception.message, equals('カスタムエラー'));
      });

      test('toStringが正しくフォーマットされる', () {
        const exception = NetworkException('テスト');
        expect(exception.toString(), equals('GeminiApiException: テスト'));
      });
    });

    group('TimeoutException', () {
      test('デフォルトメッセージを持つ', () {
        const exception = TimeoutException();
        expect(exception.message, equals('Request timed out'));
      });

      test('カスタムメッセージを持つ', () {
        const exception = TimeoutException('60秒でタイムアウト');
        expect(exception.message, equals('60秒でタイムアウト'));
      });
    });

    group('ApiErrorException', () {
      test('デフォルトメッセージを持つ', () {
        const exception = ApiErrorException();
        expect(exception.message, equals('API error occurred'));
      });

      test('カスタムメッセージを持つ', () {
        const exception = ApiErrorException('Rate limit exceeded');
        expect(exception.message, equals('Rate limit exceeded'));
      });
    });

    group('InvalidResponseException', () {
      test('デフォルトメッセージを持つ', () {
        const exception = InvalidResponseException();
        expect(exception.message, equals('Invalid response format'));
      });

      test('カスタムメッセージを持つ', () {
        const exception = InvalidResponseException('No image data');
        expect(exception.message, equals('No image data'));
      });
    });

    group('ApiKeyMissingException', () {
      test('デフォルトメッセージを持つ', () {
        const exception = ApiKeyMissingException();
        expect(exception.message, contains('GEMINI_API_KEY is not configured'));
      });

      test('カスタムメッセージを持つ', () {
        const exception = ApiKeyMissingException('API key required');
        expect(exception.message, equals('API key required'));
      });

      test('toStringが正しくフォーマットされる', () {
        const exception = ApiKeyMissingException('テスト');
        expect(exception.toString(), equals('GeminiApiException: テスト'));
      });
    });

    group('型チェック', () {
      test('すべての例外がGeminiApiExceptionを実装する', () {
        expect(const NetworkException(), isA<GeminiApiException>());
        expect(const TimeoutException(), isA<GeminiApiException>());
        expect(const ApiErrorException(), isA<GeminiApiException>());
        expect(const InvalidResponseException(), isA<GeminiApiException>());
        expect(const ApiKeyMissingException(), isA<GeminiApiException>());
      });

      test('すべての例外がExceptionを実装する', () {
        expect(const NetworkException(), isA<Exception>());
        expect(const TimeoutException(), isA<Exception>());
        expect(const ApiErrorException(), isA<Exception>());
        expect(const InvalidResponseException(), isA<Exception>());
        expect(const ApiKeyMissingException(), isA<Exception>());
      });
    });

    group('switch式でのパターンマッチング', () {
      test('すべての例外タイプをマッチできる', () {
        String getMessage(GeminiApiException e) {
          return switch (e) {
            NetworkException() => 'network',
            TimeoutException() => 'timeout',
            ApiErrorException() => 'api',
            InvalidResponseException() => 'invalid',
            ApiKeyMissingException() => 'api_key_missing',
          };
        }

        expect(getMessage(const NetworkException()), equals('network'));
        expect(getMessage(const TimeoutException()), equals('timeout'));
        expect(getMessage(const ApiErrorException()), equals('api'));
        expect(getMessage(const InvalidResponseException()), equals('invalid'));
        expect(
          getMessage(const ApiKeyMissingException()),
          equals('api_key_missing'),
        );
      });
    });
  });
}
