import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/features/haiku/service/haiku_prompt_service.dart';

void main() {
  group('HaikuPromptService', () {
    late HaikuPromptService service;

    setUp(() {
      service = const HaikuPromptService();
    });

    group('generatePrompt', () {
      test('俳句の3行を含むプロンプトを生成する', () {
        // Arrange
        const firstLine = '古池や';
        const secondLine = '蛙飛び込む';
        const thirdLine = '水の音';

        // Act
        final result = service.generatePrompt(
          firstLine: firstLine,
          secondLine: secondLine,
          thirdLine: thirdLine,
        );

        // Assert
        expect(result, contains(firstLine));
        expect(result, contains(secondLine));
        expect(result, contains(thirdLine));
      });

      test('プロンプトに浮世絵スタイルの指示が含まれる', () {
        // Arrange & Act
        final result = service.generatePrompt(
          firstLine: '上の句',
          secondLine: '中の句',
          thirdLine: '下の句',
        );

        // Assert
        expect(result, contains('浮世絵'));
      });

      test('プロンプトにテキスト排除の指示が含まれる', () {
        // Arrange & Act
        final result = service.generatePrompt(
          firstLine: '上の句',
          secondLine: '中の句',
          thirdLine: '下の句',
        );

        // Assert
        expect(result.contains('文字') || result.contains('テキスト'), isTrue);
      });

      test('空の行でも正常にプロンプトを生成する', () {
        // Arrange & Act
        final result = service.generatePrompt(
          firstLine: '',
          secondLine: '',
          thirdLine: '',
        );

        // Assert
        expect(result, isNotEmpty);
        expect(result, contains('浮世絵'));
      });

      test('特殊文字を含む俳句でも正常に動作する', () {
        // Arrange
        const firstLine = '春の夜の';
        const secondLine = '夢ばかりなる';
        const thirdLine = '枕もと';

        // Act
        final result = service.generatePrompt(
          firstLine: firstLine,
          secondLine: secondLine,
          thirdLine: thirdLine,
        );

        // Assert
        expect(result, contains(firstLine));
        expect(result, contains(secondLine));
        expect(result, contains(thirdLine));
      });
    });
  });
}
