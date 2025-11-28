import 'package:flutter/material.dart';
import 'package:flutterhackthema/src/component_test_page.dart';
import 'package:flutterhackthema/src/gourmet/gourmet_component_test_page.dart';
import 'package:flutterhackthema/src/home_page.dart';
import 'package:go_router/go_router.dart';

/// アプリケーション全体のルーティング設定
///
/// go_routerを使用した型安全なルーティングを提供
/// 将来的にgo_router_builderを使用してコード生成による型安全性を強化
class AppRouter {
  /// ルーターインスタンスを作成
  ///
  /// 使用例:
  /// ```dart
  /// MaterialApp.router(
  ///   routerConfig: AppRouter.createRouter(),
  /// )
  /// ```
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/tcg-components',
          name: 'tcg-components',
          builder: (context, state) => const ComponentTestPage(),
        ),
        GoRoute(
          path: '/gourmet-components',
          name: 'gourmet-components',
          builder: (context, state) => const GourmetComponentTestPage(),
        ),
      ],
      // エラー時のフォールバック画面
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('エラー')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('ページが見つかりません: ${state.uri}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('ホームに戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
