import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/app/route_guard/nickname_guard.dart';
import 'package:flutterhackthema/shared/presentation/pages/error_page.dart';

/// アプリケーション全体のルーティング設定
///
/// go_router_builderを使用した型安全なルーティングを提供
/// TypedGoRouteアノテーションによるコード生成で型安全性を保証
///
/// ルート構成:
/// - /nickname - ニックネーム入力画面（初期ルート）
/// - /posts - 投稿一覧画面
/// - /create - 投稿作成画面
/// - /preview - プレビュー画面
///
/// リダイレクトガード:
/// - ニックネーム未設定時は /nickname へ自動リダイレクト
class AppRouter {
  /// ルーターインスタンスを作成
  ///
  /// [ref] Riverpod の WidgetRef
  ///   リダイレクトガードで Provider にアクセスするために必要
  ///
  /// 使用例:
  /// ```dart
  /// MaterialApp.router(
  ///   routerConfig: AppRouter.createRouter(ref),
  /// )
  /// ```
  static GoRouter createRouter(WidgetRef ref) {
    return GoRouter(
      // 初期ルートをニックネーム入力画面に設定
      initialLocation: '/nickname',

      // go_router_builderで生成されたルート定義を使用
      // $appRoutes には全ての @TypedGoRoute アノテーション付きルートが含まれる
      routes: $appRoutes,

      // リダイレクトガード
      // ニックネーム未設定時に /nickname へリダイレクト
      redirect: (context, state) => nicknameGuard(context, state, ref),

      // エラー時のフォールバック画面
      errorBuilder: (context, state) => ErrorPage(error: state.error),
    );
  }
}
