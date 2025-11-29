import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/app_router.dart';
import 'shared/constants/app_colors.dart';

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
      title: 'Mya句',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          surface: AppColors.background,
        ),
        useMaterial3: true,
        fontFamily: 'Noto Sans JP',
        scaffoldBackgroundColor: AppColors.background,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textBlack,
          contentTextStyle: const TextStyle(color: AppColors.white),
        ),
      ),
      routerConfig: AppRouter.createRouter(ref),
      debugShowCheckedModeBanner: false,
    );
  }
}
