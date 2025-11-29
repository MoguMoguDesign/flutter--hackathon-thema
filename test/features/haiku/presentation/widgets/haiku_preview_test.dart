import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/haiku_preview.dart';

void main() {
  group('HaikuPreview', () {
    testWidgets('全ての句が空の場合、プレースホルダーが表示される', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: HaikuPreview())),
      );

      expect(find.text('俳句がここに\n表示されます'), findsOneWidget);
    });

    testWidgets('firstLineのみが設定されている場合、1列のみ表示される', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HaikuPreview(firstLine: 'あいう')),
        ),
      );

      expect(find.text('あいう'), findsNothing); // 縦書きのため個別文字として表示
      expect(find.text('あ'), findsOneWidget);
      expect(find.text('い'), findsOneWidget);
      expect(find.text('う'), findsOneWidget);
      expect(find.text('俳句がここに\n表示されます'), findsNothing);
    });

    testWidgets('全ての句が設定されている場合、3列全て表示される', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HaikuPreview(
              firstLine: 'あいう',
              secondLine: 'かきく',
              thirdLine: 'さしす',
            ),
          ),
        ),
      );

      // 全ての文字が表示される
      expect(find.text('あ'), findsOneWidget);
      expect(find.text('い'), findsOneWidget);
      expect(find.text('う'), findsOneWidget);
      expect(find.text('か'), findsOneWidget);
      expect(find.text('き'), findsOneWidget);
      expect(find.text('く'), findsOneWidget);
      expect(find.text('さ'), findsOneWidget);
      expect(find.text('し'), findsOneWidget);
      expect(find.text('す'), findsOneWidget);
      expect(find.text('俳句がここに\n表示されます'), findsNothing);
    });

    testWidgets('10文字の句が正しく縦書き表示される', (tester) async {
      // テストビューのサイズを大きくして、HaikuPreviewのオーバーフローを防ぐ
      await tester.binding.setSurfaceSize(const Size(800, 1200));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: HaikuPreview(firstLine: 'あいうえおかきくけこ')),
        ),
      );

      // 10文字全てが個別に表示される
      expect(find.text('あ'), findsOneWidget);
      expect(find.text('い'), findsOneWidget);
      expect(find.text('う'), findsOneWidget);
      expect(find.text('え'), findsOneWidget);
      expect(find.text('お'), findsOneWidget);
      expect(find.text('か'), findsOneWidget);
      expect(find.text('き'), findsOneWidget);
      expect(find.text('く'), findsOneWidget);
      expect(find.text('け'), findsOneWidget);
      expect(find.text('こ'), findsOneWidget);

      // テストビューのサイズをリセット
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('Containerのスタイルが正しく設定されている', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: HaikuPreview())),
      );

      final container = tester.widget<Container>(find.byType(Container).first);

      expect(container.constraints?.maxWidth, isNull); // width: double.infinity
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.grey.shade200));
      expect(decoration.borderRadius, equals(BorderRadius.circular(24)));
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow?.length, equals(1));
    });
  });
}
