// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App -> Feature -> Shared)
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

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/shared/constants/api_config.dart';

void main() {
  group('ApiConfig', () {
    group('geminiApiKey', () {
      test('should be a String', () {
        expect(ApiConfig.geminiApiKey, isA<String>());
      });

      test('hasGeminiApiKey should return false when key is empty', () {
        // String.fromEnvironment returns empty string when not set in tests
        // This validates the logic of hasGeminiApiKey
        if (ApiConfig.geminiApiKey.isEmpty) {
          expect(ApiConfig.hasGeminiApiKey, isFalse);
        } else {
          expect(ApiConfig.hasGeminiApiKey, isTrue);
        }
      });
    });

    group('geminiBaseUrl', () {
      test('should be correctly configured', () {
        expect(
          ApiConfig.geminiBaseUrl,
          equals('https://generativelanguage.googleapis.com/v1beta'),
        );
      });

      test('should be a valid URL', () {
        expect(Uri.tryParse(ApiConfig.geminiBaseUrl), isNotNull);
      });
    });

    group('geminiImageModel', () {
      test('should be correctly configured', () {
        expect(
          ApiConfig.geminiImageModel,
          equals('gemini-3-pro-image-preview'),
        );
      });

      test('should not be empty', () {
        expect(ApiConfig.geminiImageModel.isNotEmpty, isTrue);
      });
    });

    group('requestTimeoutSeconds', () {
      test('should be correctly configured', () {
        expect(ApiConfig.requestTimeoutSeconds, equals(60));
      });

      test('should be positive', () {
        expect(ApiConfig.requestTimeoutSeconds, greaterThan(0));
      });
    });
  });
}
