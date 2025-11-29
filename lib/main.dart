// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    debugPrint('Firebase初期化開始');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase初期化完了');

    // Firestoreキャッシュ設定
    // オフラインサポートを有効化し、キャッシュサイズを無制限に設定
    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      debugPrint('Firestoreキャッシュ設定完了');
    } catch (e) {
      // Web版では persistence 設定がサポートされていない場合がある
      debugPrint('Firestoreキャッシュ設定エラー (無視): $e');
    }
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
        fontFamily: GoogleFonts.rocknRollOne().fontFamily,
        scaffoldBackgroundColor: AppColors.background,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textBlack,
          contentTextStyle: TextStyle(
            color: AppColors.white,
            fontFamily: GoogleFonts.rocknRollOne().fontFamily,
          ),
        ),
      ),
      routerConfig: AppRouter.createRouter(ref),
      debugShowCheckedModeBanner: false,
    );
  }
}
