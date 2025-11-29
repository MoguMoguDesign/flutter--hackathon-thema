import 'package:flutter/material.dart';
import 'package:flutterhackthema/base_ui.dart';
import 'package:flutterhackthema/src/component_test_page.dart';
import 'package:flutterhackthema/src/gourmet/gourmet_component_test_page.dart';
import 'package:flutterhackthema/src/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリケーションのエントリーポイント
///
/// Riverpodの[ProviderScope]でアプリ全体をラップして状態管理を有効化
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Component Test',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.gradientBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.adminPrimary,
          foregroundColor: AppColors.white,
        ),
      ),
      // 初期ページをHomePageに設定
      home: const HomePage(),
      // ルート設定
      routes: {
        '/tcg-components': (context) => const ComponentTestPage(),
        '/gourmet-components': (context) => const GourmetComponentTestPage(),
      },
    );
  }
}
