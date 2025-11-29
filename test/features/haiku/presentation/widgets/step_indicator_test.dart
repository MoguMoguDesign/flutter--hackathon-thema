import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/step_indicator.dart';

void main() {
  group('StepIndicator', () {
    testWidgets('currentStep=0の場合、最初のステップのみアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 0))),
      );

      expect(find.text('手順'), findsOneWidget);

      final containers = tester.widgetList<Container>(find.byType(Container));

      // 最初のステップ（アクティブ）: 16x16, 黒色
      final firstStep = containers.firstWhere(
        (c) => c.constraints?.maxWidth == 16 && c.constraints?.maxHeight == 16,
      );
      final firstDecoration = firstStep.decoration as BoxDecoration;
      expect(firstDecoration.color, equals(Colors.black));

      // 他のステップ（非アクティブ）: 12x12, グレー
      final inactiveSteps = containers.where(
        (c) => c.constraints?.maxWidth == 12 && c.constraints?.maxHeight == 12,
      );
      expect(inactiveSteps.length, equals(2));
    });

    testWidgets('currentStep=1の場合、2番目のステップがアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 1))),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));

      // アクティブなステップ（2番目）: 16x16
      final activeSteps = containers.where(
        (c) => c.constraints?.maxWidth == 16 && c.constraints?.maxHeight == 16,
      );
      expect(activeSteps.length, equals(1));

      // 完了したステップ（1番目）: 12x12, 黒色
      final completedSteps = containers.where((c) {
        if (c.constraints?.maxWidth != 12 || c.constraints?.maxHeight != 12) {
          return false;
        }
        final decoration = c.decoration as BoxDecoration?;
        return decoration?.color == Colors.black;
      });
      expect(completedSteps.length, greaterThanOrEqualTo(1));
    });

    testWidgets('currentStep=2の場合、3番目のステップがアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 2))),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));

      // アクティブなステップ（3番目）: 16x16
      final activeSteps = containers.where(
        (c) => c.constraints?.maxWidth == 16 && c.constraints?.maxHeight == 16,
      );
      expect(activeSteps.length, equals(1));
    });

    testWidgets('デフォルトでtotalStepsは3である', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 0))),
      );

      final indicator = tester.widget<StepIndicator>(
        find.byType(StepIndicator),
      );

      expect(indicator.totalSteps, equals(3));
    });

    testWidgets('ステップインジケーターが中央揃えで表示される', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 0))),
      );

      final row = tester.widget<Row>(find.byType(Row).first);

      expect(row.mainAxisAlignment, equals(MainAxisAlignment.center));
    });
  });
}
