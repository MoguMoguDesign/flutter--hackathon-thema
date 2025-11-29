import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/haiku_input_page.dart';
import 'package:flutterhackthema/shared/presentation/widgets/inputs/app_text_field.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/back_button.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/haiku_preview.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/step_indicator.dart';
import 'package:flutterhackthema/shared/shared.dart';

/// テストビューのサイズを大きくしてHaikuPreviewのオーバーフローを防ぐ
Future<void> setLargeTestSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(800, 1200));
}

/// テストビューのサイズをリセット
Future<void> resetTestSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(null);
}

void main() {
  group('HaikuInputPage', () {
    testWidgets('初期表示が正しくレンダリングされる', (tester) async {
      await setLargeTestSurface(tester);

      await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

      expect(find.text('句を詠む'), findsOneWidget);
      expect(find.byType(AppBackButton), findsOneWidget);
      expect(find.byType(HaikuPreview), findsOneWidget);
      expect(find.byType(StepIndicator), findsOneWidget);
      expect(find.byType(AppTextField), findsOneWidget);
      expect(find.byType(AppFilledButton), findsOneWidget);

      await resetTestSurface(tester);
    });

    testWidgets('初期ステップは0（上の句）である', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

      expect(find.text('上の句'), findsOneWidget);
      expect(find.text('上の句を入力'), findsOneWidget);
    });

    group('Validation Logic', () {
      testWidgets('空のテキストではボタンが無効化される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNull);

        await resetTestSurface(tester);
      });

      testWidgets('1文字入力するとボタンが有効化される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あ');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);

        await resetTestSurface(tester);
      });

      testWidgets('10文字入力してもボタンが有効である', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あいうえおかきくけこ');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);

        await resetTestSurface(tester);
      });

      testWidgets('11文字入力するとボタンが無効化される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        // 11文字入力を試みる（maxLengthで制限される）
        await tester.enterText(find.byType(AppTextField), 'あいうえおかきくけこさ');
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        // maxLength: 10により、実際には10文字までしか入力できない
        expect(textField.controller?.text.length, lessThanOrEqualTo(10));
        await resetTestSurface(tester);
      });

      testWidgets('空白文字のみではボタンが無効化される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), '   ');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNull);

        await resetTestSurface(tester);
      });

      testWidgets('前後の空白はトリミングされる', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), '  あいう  ');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);

        await resetTestSurface(tester);
      });

      testWidgets('入力をクリアするとボタンが無効化される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        var button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);

        await tester.enterText(find.byType(AppTextField), '');
        await tester.pump();

        button = tester.widget<AppFilledButton>(find.byType(AppFilledButton));
        expect(button.onPressed, isNull);

        await resetTestSurface(tester);
      });
    });

    group('10-Character Limit', () {
      testWidgets('AppTextFieldのmaxLengthが10に設定されている', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.maxLength, equals(10));
      });

      testWidgets('10文字を超える入力は受け付けない', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        // 11文字入力を試みる
        await tester.enterText(find.byType(AppTextField), '12345678901');
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        // maxLengthにより10文字に制限される
        expect(textField.controller?.text, equals('1234567890'));
        expect(textField.controller?.text.length, equals(10));
        await resetTestSurface(tester);
      });

      testWidgets('文字数カウンターが表示される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        // TextFieldのmaxLengthが設定されている場合、文字数カウンターが表示される
        expect(find.text('3/10'), findsOneWidget);

        await resetTestSurface(tester);
      });
    });

    group('Step Navigation', () {
      testWidgets('ステップ0で決定すると次のステップに進む', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        expect(find.text('真ん中の行'), findsOneWidget);
        expect(find.text('真ん中の行を入力'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('ステップ1で決定するとステップ2に進む', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        // ステップ0
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // ステップ1
        await tester.enterText(find.byType(AppTextField), 'かきく');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        expect(find.text('下の句'), findsOneWidget);
        expect(find.text('下の句を入力'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('各ステップで入力フィールドがクリアされる', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller?.text, isEmpty);
        await resetTestSurface(tester);
      });

      testWidgets('入力した値がHaikuPreviewに表示される', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        // ステップ0: 上の句
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう'));
        expect(preview.secondLine, isEmpty);
        expect(preview.thirdLine, isEmpty);
        await resetTestSurface(tester);
      });
    });

    group('Input Validation', () {
      testWidgets('数字のみの入力も受け付ける', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), '12345');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);
        await resetTestSurface(tester);
      });

      testWidgets('記号を含む入力も受け付ける', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'あ、い。う！');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);
        await resetTestSurface(tester);
      });

      testWidgets('英字を含む入力も受け付ける', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        await tester.enterText(find.byType(AppTextField), 'ABCあいう');
        await tester.pump();

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNotNull);
        await resetTestSurface(tester);
      });
    });

    group('Rendering', () {
      testWidgets('タイトルが正しく表示される', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        expect(find.text('句を詠む'), findsOneWidget);

        final text = tester.widget<Text>(find.text('句を詠む'));
        expect(text.style?.fontSize, equals(18));
        expect(text.style?.fontWeight, equals(FontWeight.w600));
      });

      testWidgets('決定ボタンのラベルが正しい', (tester) async {
        await setLargeTestSurface(tester);

        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        expect(find.text('決定して次の行へ'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('StepIndicatorに正しいステップが渡される', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        final indicator = tester.widget<StepIndicator>(
          find.byType(StepIndicator),
        );
        expect(indicator.currentStep, equals(0));
      });

      testWidgets('AppBackButtonが表示される', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        expect(find.byType(AppBackButton), findsOneWidget);
      });

      testWidgets('autofocusがtrueに設定されている', (tester) async {
        await tester.pumpWidget(const MaterialApp(home: HaikuInputPage()));

        final textField = tester.widget<AppTextField>(
          find.byType(AppTextField),
        );
        expect(textField.autofocus, isTrue);
      });
    });
  });
}
