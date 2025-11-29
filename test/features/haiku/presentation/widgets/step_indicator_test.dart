import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/step_indicator.dart';

void main() {
  group('StepIndicator', () {
    testWidgets('currentStep=0の場合、最初のステップのみアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 0))),
      );

      // StepIndicatorが表示されることを確認
      expect(find.byType(StepIndicator), findsOneWidget);

      final containers = tester.widgetList<Container>(find.byType(Container));

      // アクティブステップ（20x20）が存在することを確認
      final activeSteps = containers.where(
        (c) => c.constraints?.maxWidth == 20 && c.constraints?.maxHeight == 20,
      );
      expect(activeSteps.length, equals(1));

      // 非アクティブステップ（16x16）が3つ存在することを確認
      final inactiveSteps = containers.where(
        (c) => c.constraints?.maxWidth == 16 && c.constraints?.maxHeight == 16,
      );
      expect(inactiveSteps.length, equals(3));
    });

    testWidgets('currentStep=1の場合、2番目のステップがアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 1))),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));

      // アクティブなステップ（20x20）が1つ存在することを確認
      final activeSteps = containers.where(
        (c) => c.constraints?.maxWidth == 20 && c.constraints?.maxHeight == 20,
      );
      expect(activeSteps.length, equals(1));

      // 非アクティブステップ（16x16）が3つ存在することを確認
      final inactiveSteps = containers.where(
        (c) => c.constraints?.maxWidth == 16 && c.constraints?.maxHeight == 16,
      );
      expect(inactiveSteps.length, equals(3));
    });

    testWidgets('currentStep=2の場合、3番目のステップがアクティブ', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 2))),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));

      // アクティブなステップ（20x20）が1つ存在することを確認
      final activeSteps = containers.where(
        (c) => c.constraints?.maxWidth == 20 && c.constraints?.maxHeight == 20,
      );
      expect(activeSteps.length, equals(1));
    });

    testWidgets('デフォルトでtotalStepsは4である', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: StepIndicator(currentStep: 0))),
      );

      final indicator = tester.widget<StepIndicator>(
        find.byType(StepIndicator),
      );

      expect(indicator.totalSteps, equals(4));
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
