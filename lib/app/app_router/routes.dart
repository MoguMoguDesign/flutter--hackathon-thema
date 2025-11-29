import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutterhackthema/app/widgets/pages/placeholder_create_post_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_nickname_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_posts_page.dart';
import 'package:flutterhackthema/app/widgets/pages/placeholder_preview_page.dart';

part 'routes.g.dart';

/// ニックネーム入力画面のルート定義
///
/// パス: /nickname
/// ユーザーが初回訪問時にニックネームを入力する画面
/// アプリの初期ルートとして使用されます
///
/// 使用例:
/// ```dart
/// const NicknameRoute().go(context);
/// ```
@TypedGoRoute<NicknameRoute>(path: '/nickname')
class NicknameRoute extends GoRouteData with $NicknameRoute {
  /// [NicknameRoute] のコンストラクタ
  const NicknameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaceholderNicknamePage();
  }
}

/// 投稿一覧画面のルート定義
///
/// パス: /posts
/// 全ユーザーの投稿を一覧表示する画面
/// Pinterest風のグリッドレイアウトで表示されます
///
/// 使用例:
/// ```dart
/// const PostsRoute().go(context);
/// ```
@TypedGoRoute<PostsRoute>(path: '/posts')
class PostsRoute extends GoRouteData with $PostsRoute {
  /// [PostsRoute] のコンストラクタ
  const PostsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaceholderPostsPage();
  }
}

/// 投稿作成画面のルート定義
///
/// パス: /create
/// 俳句を入力して画像生成を行う画面
/// DALL-E 3 APIを使用して画像を生成します
///
/// 使用例:
/// ```dart
/// const CreateRoute().go(context);
/// ```
@TypedGoRoute<CreateRoute>(path: '/create')
class CreateRoute extends GoRouteData with $CreateRoute {
  /// [CreateRoute] のコンストラクタ
  const CreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaceholderCreatePostPage();
  }
}

/// プレビュー画面のルート定義
///
/// パス: /preview
/// 生成された画像と俳句のプレビューを表示する画面
/// 投稿の確認と投稿実行を行います
///
/// 使用例:
/// ```dart
/// const PreviewRoute().go(context);
/// ```
@TypedGoRoute<PreviewRoute>(path: '/preview')
class PreviewRoute extends GoRouteData with $PreviewRoute {
  /// [PreviewRoute] のコンストラクタ
  const PreviewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaceholderPreviewPage();
  }
}
