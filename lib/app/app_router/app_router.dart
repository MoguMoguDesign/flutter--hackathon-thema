import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/haiku/presentation/pages/generating_page.dart';
import '../../features/haiku/presentation/pages/haiku_input_page.dart';
import '../../features/haiku/presentation/pages/preview_page.dart';
import '../../features/nickname/presentation/pages/nickname_page.dart';
import '../../features/posts/presentation/pages/post_detail_page.dart';
import '../../features/posts/presentation/pages/posts_page.dart';

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
        // ニックネーム入力画面（初回起動）
        GoRoute(
          path: '/',
          name: 'nickname',
          builder: (context, state) => const NicknamePage(),
        ),
        // 投稿一覧画面
        GoRoute(
          path: '/posts',
          name: 'posts',
          builder: (context, state) => const PostsPage(),
        ),
        // 投稿詳細画面
        GoRoute(
          path: '/posts/:postId',
          name: 'postDetail',
          builder: (context, state) {
            final postId = state.pathParameters['postId'] ?? '';
            return PostDetailPage(postId: postId);
          },
        ),
        // 俳句入力画面
        GoRoute(
          path: '/create',
          name: 'create',
          builder: (context, state) => const HaikuInputPage(),
        ),
        // AI画像生成中画面
        GoRoute(
          path: '/create/generating',
          name: 'generating',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return GeneratingPage(
              firstLine: extra['firstLine'] as String? ?? '',
              secondLine: extra['secondLine'] as String? ?? '',
              thirdLine: extra['thirdLine'] as String? ?? '',
            );
          },
        ),
        // プレビュー・投稿確認画面
        GoRoute(
          path: '/create/preview',
          name: 'preview',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            return PreviewPage(
              firstLine: extra['firstLine'] as String? ?? '',
              secondLine: extra['secondLine'] as String? ?? '',
              thirdLine: extra['thirdLine'] as String? ?? '',
              imageUrl: extra['imageUrl'] as String? ?? '',
            );
          },
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
