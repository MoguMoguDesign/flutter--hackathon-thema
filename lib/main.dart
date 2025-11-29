import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/app_router.dart';

/// アプリケーションのエントリーポイント
///
/// Riverpodの[ProviderScope]でアプリ全体をラップして状態管理を有効化
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

/// アプリケーションのルートウィジェット
///
/// go_routerを使用したルーティング設定を適用
/// ConsumerWidgetを使用してProviderにアクセス可能にする
class MainApp extends ConsumerWidget {
  /// [MainApp] のコンストラクタ
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Hackathon Thema',
      routerConfig: AppRouter.createRouter(ref),
      debugShowCheckedModeBanner: false,
    );
  }
}
