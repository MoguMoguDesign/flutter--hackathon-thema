import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/haiku_card.dart';

void main() {
  group('HaikuCard', () {
    // テスト用のモックデータ
    final DateTime testDateTime = DateTime(2025, 1, 1);

    final HaikuModel testHaiku = HaikuModel(
      id: 'test-id',
      firstLine: '古池や',
      secondLine: '蛙飛び込む',
      thirdLine: '水の音',
      createdAt: testDateTime,
      imageUrl: null,
    );

    final HaikuModel testHaikuWithImage = HaikuModel(
      id: 'test-id-2',
      firstLine: '古池や',
      secondLine: '蛙飛び込む',
      thirdLine: '水の音',
      createdAt: testDateTime,
      imageUrl: 'https://example.com/test-image.jpg',
    );

    testWidgets('imageUrlがnullの場合、フォールバックカードが表示される', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () {}),
          ),
        ),
      );

      // フォールバックカードの俳句テキストが表示される
      expect(find.text('古池や'), findsOneWidget);
      expect(find.text('蛙飛び込む'), findsOneWidget);
      expect(find.text('水の音'), findsOneWidget);
    });

    testWidgets('カードタップでonTapコールバックが呼ばれる', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('カードのスタイルが正しく適用される', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () {}),
          ),
        ),
      );

      // ClipRRectが存在する
      expect(find.byType(ClipRRect), findsOneWidget);

      // AspectRatioが4:5で設定されている
      final AspectRatio aspectRatio = tester.widget<AspectRatio>(
        find.byType(AspectRatio),
      );
      expect(aspectRatio.aspectRatio, equals(4 / 5));
    });

    testWidgets('フォールバックカードの背景色が正しい', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () {}),
          ),
        ),
      );

      // フォールバックカードのContainerを検索
      final Iterable<Container> containers = tester.widgetList<Container>(
        find.byType(Container),
      );
      bool foundFallbackColor = false;
      for (final Container container in containers) {
        if (container.color == Colors.grey.shade300) {
          foundFallbackColor = true;
          break;
        }
      }
      expect(foundFallbackColor, isTrue);
    });

    testWidgets('imageUrlがある場合、Image.networkが使用される', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaikuWithImage, onTap: () {}),
          ),
        ),
      );

      // Image.network が存在する
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('GestureDetectorが正しく配置されている', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () {}),
          ),
        ),
      );

      // GestureDetectorが存在する
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('フォールバックカードのテキストスタイルが正しい', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HaikuCard(haiku: testHaiku, onTap: () {}),
          ),
        ),
      );

      // テキストウィジェットを検索
      final Finder textFinder = find.text('古池や');
      expect(textFinder, findsOneWidget);

      final Text textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, equals(14));
      expect(textWidget.style?.fontWeight, equals(FontWeight.w500));
      expect(textWidget.style?.color, equals(Colors.black87));
    });
  });
}
