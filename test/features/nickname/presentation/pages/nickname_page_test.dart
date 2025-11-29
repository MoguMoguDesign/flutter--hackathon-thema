import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterhackthema/features/nickname/presentation/pages/nickname_page.dart';
import 'package:flutterhackthema/shared/widgets/buttons/app_filled_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/inputs/app_text_field.dart';

void main() {
  group('NicknamePage Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('displays nickname input field', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppTextField), findsOneWidget);
    });

    testWidgets('displays label text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('ニックネーム'), findsOneWidget);
    });

    testWidgets('displays hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('ニックネームを入力'), findsOneWidget);
    });

    testWidgets('displays start button with correct text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('はじめる'), findsOneWidget);
      expect(find.byType(AppFilledButton), findsOneWidget);
    });

    testWidgets('button is disabled when input is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('button is enabled when valid input is entered', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'TestUser');
      await tester.pump();

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('button remains disabled for whitespace-only input', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), '   ');
      await tester.pump();

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('displays service name logo area', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('サービス名'), findsOneWidget);
    });

    testWidgets('allows Japanese character input', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'テストユーザー');
      await tester.pump();

      expect(find.text('テストユーザー'), findsOneWidget);

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('enforces max length of 20 characters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      // Enter 25 characters - should be truncated to 20
      await tester.enterText(
        find.byType(TextField),
        '1234567890123456789012345',
      );
      await tester.pump();

      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );
      expect(textField.controller?.text.length, lessThanOrEqualTo(20));
    });

    testWidgets('button enabled at exactly 20 characters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      // Enter exactly 20 characters
      await tester.enterText(find.byType(TextField), '12345678901234567890');
      await tester.pump();

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('button enabled with single character', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: NicknamePage())),
      );
      await tester.pumpAndSettle();

      // Enter single character (minimum valid)
      await tester.enterText(find.byType(TextField), 'A');
      await tester.pump();

      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNotNull);
    });
  });
}
