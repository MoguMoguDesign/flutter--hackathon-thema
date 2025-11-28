import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// テスト用のProviderScopeでウィジェットをラップ
///
/// 使用例:
/// ```dart
/// await tester.pumpWidget(
///   createTestApp(child: MyWidget()),
/// );
/// ```
Widget createTestApp({
  required Widget child,
  dynamic overrides = const [],
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Scaffold(body: child),
    ),
  );
}

/// Riverpod Providerのテスト用コンテナを作成
///
/// 使用例:
/// ```dart
/// final container = createContainer();
/// final value = container.read(myProvider);
/// ```
ProviderContainer createContainer({
  dynamic overrides = const [],
}) {
  return ProviderContainer(overrides: overrides);
}

/// 非同期のWidgetテストでpumpを待機
///
/// 使用例:
/// ```dart
/// await pumpAndSettle(tester);
/// ```
Future<void> pumpAndSettle(WidgetTester tester) async {
  await tester.pumpAndSettle(const Duration(seconds: 2));
}
