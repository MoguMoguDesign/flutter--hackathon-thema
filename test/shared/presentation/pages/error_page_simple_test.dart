import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/shared/presentation/pages/error_page.dart';

void main() {
  group('ErrorPage basic tests', () {
    testWidgets('Displays error icon', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ErrorPage(error: null)));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('Displays error title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ErrorPage(error: null)));

      expect(find.text('ページが見つかりません'), findsOneWidget);
    });

    testWidgets('Displays home button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ErrorPage(error: null)));

      expect(find.text('ホームに戻る'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('Displays error message when Exception is provided', (
      WidgetTester tester,
    ) async {
      final exception = Exception('Test error message');

      await tester.pumpWidget(MaterialApp(home: ErrorPage(error: exception)));

      expect(
        find.textContaining('Exception: Test error message'),
        findsOneWidget,
      );
    });

    testWidgets('AppBar title is エラー', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ErrorPage(error: null)));

      expect(find.widgetWithText(AppBar, 'エラー'), findsOneWidget);
    });
  });
}
