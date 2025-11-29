import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutterhackthema/app/app_router/app_router.dart';
import 'package:flutterhackthema/firebase_options.dart';
import 'package:flutterhackthema/shared/constants/app_colors.dart';

/// アプリケーションのエントリーポイント
///
/// Firebase初期化後、Riverpodの[ProviderScope]でアプリ全体をラップ
/// して状態管理を有効化する。
///
/// Firebase初期化エラーは開発環境でログ出力され、本番環境では
/// エラーハンドリングが必要。
Future<void> main() async {
  // Flutterフレームワークの初期化を確実に完了
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase初期化（Web用設定を自動選択）
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stackTrace) {
    // Firebase初期化エラーをログ出力
    // TODO(#7): 本番環境ではエラーページへのリダイレクトを検討
    debugPrint('Firebase initialization error: $e');
    debugPrint('Stack trace: $stackTrace');
  }

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
