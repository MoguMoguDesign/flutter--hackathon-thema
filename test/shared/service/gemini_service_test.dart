import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:flutterhackthema/shared/service/gemini_api_exception.dart';
import 'package:flutterhackthema/shared/service/gemini_service.dart';

void main() {
  group('GeminiService', () {
    group('generateImage', () {
      test('正常なレスポンスで画像データを返す', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          final responseBody = json.encode([
            {
              'candidates': [
                {
                  'content': {
                    'parts': [
                      {
                        'inlineData': {
                          'mimeType': 'image/png',
                          'data': 'dGVzdGRhdGE=', // "testdata" in base64
                        },
                      },
                    ],
                  },
                },
              ],
            },
          ]);
          return http.Response(responseBody, 200);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act
        final result = await service.generateImage(prompt: 'テストプロンプト');

        // Assert
        expect(result.base64Data, equals('dGVzdGRhdGE='));
        expect(result.mimeType, equals('image/png'));

        service.dispose();
      });

      test('通常形式のレスポンスでも画像データを返す', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          final responseBody = json.encode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {
                      'inlineData': {
                        'mimeType': 'image/jpeg',
                        'data': 'aW1hZ2VkYXRh', // "imagedata" in base64
                      },
                    },
                  ],
                },
              },
            ],
          });
          return http.Response(responseBody, 200);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act
        final result = await service.generateImage(prompt: 'テスト');

        // Assert
        expect(result.base64Data, equals('aW1hZ2VkYXRh'));
        expect(result.mimeType, equals('image/jpeg'));

        service.dispose();
      });

      test('APIエラー時にApiErrorExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          return http.Response('{"error": "quota exceeded"}', 429);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'テスト'),
          throwsA(isA<ApiErrorException>()),
        );

        service.dispose();
      });

      test('空のレスポンス配列でInvalidResponseExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          return http.Response('[]', 200);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'テスト'),
          throwsA(isA<InvalidResponseException>()),
        );

        service.dispose();
      });

      test('candidatesが空の場合にInvalidResponseExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          final responseBody = json.encode([
            {'candidates': []},
          ]);
          return http.Response(responseBody, 200);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'テスト'),
          throwsA(isA<InvalidResponseException>()),
        );

        service.dispose();
      });

      test('画像データがない場合にInvalidResponseExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          final responseBody = json.encode([
            {
              'candidates': [
                {
                  'content': {
                    'parts': [
                      {'text': 'text only response'},
                    ],
                  },
                },
              ],
            },
          ]);
          return http.Response(responseBody, 200, headers: {
            'content-type': 'application/json; charset=utf-8',
          });
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'test'),
          throwsA(isA<InvalidResponseException>()),
        );

        service.dispose();
      });

      test('ネットワークエラー時にNetworkExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          throw http.ClientException('Connection failed');
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'テスト'),
          throwsA(isA<NetworkException>()),
        );

        service.dispose();
      });

      test('不正なJSONでInvalidResponseExceptionをスロー', () async {
        // Arrange
        final mockClient = MockClient((request) async {
          return http.Response('invalid json{', 200);
        });

        final service = GeminiService(httpClient: mockClient);

        // Act & Assert
        expect(
          () => service.generateImage(prompt: 'テスト'),
          throwsA(isA<InvalidResponseException>()),
        );

        service.dispose();
      });
    });
  });
}
