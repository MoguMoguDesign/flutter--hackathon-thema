import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリケーションのエントリーポイント
///
/// Riverpodの[ProviderScope]でアプリ全体をラップして状態管理を有効化
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

/// アプリケーションのルートウィジェット
class MainApp extends StatelessWidget {
  /// [MainApp] のコンストラクタ
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter App', home: const Scaffold());
  }
}
