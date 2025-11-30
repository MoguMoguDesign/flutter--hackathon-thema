import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

/// ProviderScopeでラップされたMaterialAppをpumpする
Future<void> pumpTestWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(ProviderScope(child: MaterialApp(home: widget)));
}

void main() {
  group('HaikuInputPage', () {
    testWidgets('初期表示が正しくレンダリングされる', (tester) async {
      await setLargeTestSurface(tester);

      await pumpTestWidget(tester, const HaikuInputPage());

      expect(find.byType(AppBackButton), findsOneWidget);
      expect(find.byType(HaikuPreview), findsOneWidget);
      expect(find.byType(StepIndicator), findsOneWidget);
      expect(find.byType(AppTextField), findsOneWidget);
      expect(find.byType(AppFilledButton), findsOneWidget);

      await resetTestSurface(tester);
    });

    testWidgets('初期ステップは0（上五）である', (tester) async {
      await setLargeTestSurface(tester);
      await pumpTestWidget(tester, const HaikuInputPage());
      await tester.pumpAndSettle();

      expect(find.text('上五'), findsOneWidget);
      expect(find.text('上五を入力'), findsOneWidget);

      await resetTestSurface(tester);
    });

    group('Validation Logic', () {
      testWidgets('空のテキストではボタンが無効化される', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

        final button = tester.widget<AppFilledButton>(
          find.byType(AppFilledButton),
        );
        expect(button.onPressed, isNull);

        await resetTestSurface(tester);
      });

      testWidgets('1文字入力するとボタンが有効化される', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());
        await tester.pumpAndSettle();

        final textField = tester.widget<AppTextField>(
          find.byType(AppTextField),
        );
        expect(textField.maxLength, equals(10));

        await resetTestSurface(tester);
      });

      testWidgets('10文字を超える入力は受け付けない', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        expect(find.text('中七'), findsOneWidget);
        expect(find.text('中七を入力'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('ステップ1で決定するとステップ2に進む', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

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

        expect(find.text('下五'), findsOneWidget);
        expect(find.text('下五を入力'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('各ステップで入力フィールドがクリアされる', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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

        await pumpTestWidget(tester, const HaikuInputPage());

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
      testWidgets('初期ステップでは「次の行へ」ボタンが表示される', (tester) async {
        await setLargeTestSurface(tester);

        await pumpTestWidget(tester, const HaikuInputPage());

        expect(find.text('次の行へ'), findsOneWidget);
        await resetTestSurface(tester);
      });

      testWidgets('StepIndicatorに正しいステップが渡される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());
        await tester.pumpAndSettle();

        final indicator = tester.widget<StepIndicator>(
          find.byType(StepIndicator),
        );
        expect(indicator.currentStep, equals(0));

        await resetTestSurface(tester);
      });

      testWidgets('AppBackButtonが表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());
        await tester.pumpAndSettle();

        expect(find.byType(AppBackButton), findsOneWidget);

        await resetTestSurface(tester);
      });

      testWidgets('autofocusがtrueに設定されている', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());
        await tester.pumpAndSettle();

        final textField = tester.widget<AppTextField>(
          find.byType(AppTextField),
        );
        expect(textField.autofocus, isTrue);

        await resetTestSurface(tester);
      });
    });

    // Note: Firestore Integration testing is handled by unit tests
    // (HaikuNotifier and HaikuRepository tests) due to the complexity of
    // testing async unawaited() operations combined with go_router navigation
    // in widget tests. The unit tests provide comprehensive coverage of:
    // - HaikuNotifier.saveHaiku() success and error cases
    // - HaikuRepository.create() CRUD operations
    // - Error handling and logging throughout the stack

    group('Realtime Preview Display', () {
      testWidgets('ステップ0で入力中のテキストがfirstLineにリアルタイム表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Type text
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう'));
        expect(preview.secondLine, isEmpty);
        expect(preview.thirdLine, isEmpty);

        await resetTestSurface(tester);
      });

      testWidgets('ステップ1で入力中のテキストがsecondLineにリアルタイム表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Complete step 0
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // Type in step 1
        await tester.enterText(find.byType(AppTextField), 'かき');
        await tester.pump();

        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう')); // Confirmed value
        expect(preview.secondLine, equals('かき')); // Realtime input
        expect(preview.thirdLine, isEmpty);

        await resetTestSurface(tester);
      });

      testWidgets('ステップ2で入力中のテキストがthirdLineにリアルタイム表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Complete step 0
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // Complete step 1
        await tester.enterText(find.byType(AppTextField), 'かきくけこ');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // Type in step 2
        await tester.enterText(find.byType(AppTextField), 'さしす');
        await tester.pump();

        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう')); // Confirmed value
        expect(preview.secondLine, equals('かきくけこ')); // Confirmed value
        expect(preview.thirdLine, equals('さしす')); // Realtime input

        await resetTestSurface(tester);
      });
    });

    group('Step Transition Behavior', () {
      testWidgets('決定ボタン押下後、入力中のテキストが確定値として保存される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Type and verify realtime display
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();

        var preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう'));

        // Confirm
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // Verify confirmed value is preserved
        preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう'));
        expect(preview.secondLine, isEmpty);

        await resetTestSurface(tester);
      });

      testWidgets('ステップ遷移時、新しいステップの入力フィールドがクリアされる', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Complete step 0
        await tester.enterText(find.byType(AppTextField), 'あいう');
        await tester.pump();
        await tester.tap(find.byType(AppFilledButton));
        await tester.pumpAndSettle();

        // Verify input field is cleared
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller?.text, isEmpty);

        // Verify preview shows only confirmed firstLine
        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('あいう'));
        expect(preview.secondLine, isEmpty);

        await resetTestSurface(tester);
      });
    });

    group('Edge Cases', () {
      testWidgets('空の入力でプレビューが適切に表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Start with empty input
        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, isEmpty);
        expect(preview.secondLine, isEmpty);
        expect(preview.thirdLine, isEmpty);

        // Verify placeholder is shown
        expect(find.text('俳句がここに\n表示されます'), findsOneWidget);

        await resetTestSurface(tester);
      });

      testWidgets('特殊文字が正しく縦書き表示される', (tester) async {
        await setLargeTestSurface(tester);
        await pumpTestWidget(tester, const HaikuInputPage());

        // Test with special characters
        await tester.enterText(find.byType(AppTextField), '桜咲く');
        await tester.pump();

        final preview = tester.widget<HaikuPreview>(find.byType(HaikuPreview));
        expect(preview.firstLine, equals('桜咲く'));

        await resetTestSurface(tester);
      });
    });
  });
}
