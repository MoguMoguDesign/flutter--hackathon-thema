import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/app/route_guard/nickname_guard.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_create_post_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_nickname_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_posts_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_preview_page.dart';
import 'package:flutterhackthema/shared/presentation/pages/error_page.dart';

/// アプリケーション全体のルーティング設定
///
/// go_routerを使用した型安全なルーティングを提供
/// 将来的にgo_router_builderを使用してコード生成による型安全性を強化
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
      initialLocation: Routes.nickname,

      // ルート定義
      routes: [
        // ニックネーム入力画面
        GoRoute(
          path: Routes.nickname,
          name: 'nickname',
          builder: (context, state) => const PlaceholderNicknamePage(),
        ),

        // 投稿一覧画面
        GoRoute(
          path: Routes.posts,
          name: 'posts',
          builder: (context, state) => const PlaceholderPostsPage(),
        ),

        // 投稿作成画面
        GoRoute(
          path: Routes.create,
          name: 'create',
          builder: (context, state) => const PlaceholderCreatePostPage(),
        ),

        // プレビュー画面
        GoRoute(
          path: Routes.preview,
          name: 'preview',
          builder: (context, state) => const PlaceholderPreviewPage(),
        ),
      ],

      // リダイレクトガード
      // ニックネーム未設定時に /nickname へリダイレクト
      redirect: (context, state) => nicknameGuard(context, state, ref),

      // エラー時のフォールバック画面
      errorBuilder: (context, state) => ErrorPage(error: state.error),
    );
  }
}
