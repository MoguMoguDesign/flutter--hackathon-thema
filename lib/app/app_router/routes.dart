import 'package:flutter/material.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/generating_page.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/haiku_input_page.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/preview_page.dart';
import 'package:flutterhackthema/features/nickname/presentation/pages/nickname_page.dart';
import 'package:flutterhackthema/features/posts/presentation/pages/post_detail_page.dart';
import 'package:flutterhackthema/features/posts/presentation/pages/posts_page.dart';
import 'package:go_router/go_router.dart';

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
    return const NicknamePage();
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
    return const PostsPage();
  }
}

/// 投稿詳細画面のルート定義
///
/// パス: /posts/:postId
/// 投稿の詳細を表示する画面
/// SNSシェアボタン付き
///
/// 使用例:
/// ```dart
/// PostDetailRoute(postId: '123').go(context);
/// ```
@TypedGoRoute<PostDetailRoute>(path: '/posts/:postId')
class PostDetailRoute extends GoRouteData with $PostDetailRoute {
  /// [PostDetailRoute] のコンストラクタ
  const PostDetailRoute({required this.postId});

  /// 投稿ID
  final String postId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PostDetailPage(postId: postId);
  }
}

/// 俳句入力画面のルート定義
///
/// パス: /create
/// 俳句を入力して画像生成を行う画面
/// 3ステップ入力（上の句・中の句・下の句）
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
    return const HaikuInputPage();
  }
}

/// AI画像生成中画面のルート定義
///
/// パス: /create/generating
/// AI画像を生成している間のローディング画面
///
/// 使用例:
/// ```dart
/// GeneratingRoute(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// ).go(context);
/// ```
@TypedGoRoute<GeneratingRoute>(path: '/create/generating')
class GeneratingRoute extends GoRouteData with $GeneratingRoute {
  /// [GeneratingRoute] のコンストラクタ
  const GeneratingRoute({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
  });

  /// 上の句
  final String firstLine;

  /// 中の句
  final String secondLine;

  /// 下の句
  final String thirdLine;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GeneratingPage(
      firstLine: firstLine,
      secondLine: secondLine,
      thirdLine: thirdLine,
    );
  }
}

/// プレビュー画面のルート定義
///
/// パス: /create/preview
/// 生成された画像と俳句のプレビューを表示する画面
/// 投稿の確認と投稿実行を行います
///
/// 使用例:
/// ```dart
/// PreviewRoute(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
///   imageUrl: 'https://example.com/image.png',
/// ).go(context);
/// ```
@TypedGoRoute<PreviewRoute>(path: '/create/preview')
class PreviewRoute extends GoRouteData with $PreviewRoute {
  /// [PreviewRoute] のコンストラクタ
  const PreviewRoute({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.imageUrl,
  });

  /// 上の句
  final String firstLine;

  /// 中の句
  final String secondLine;

  /// 下の句
  final String thirdLine;

  /// 生成された画像のURL
  final String imageUrl;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PreviewPage(
      firstLine: firstLine,
      secondLine: secondLine,
      thirdLine: thirdLine,
      imageUrl: imageUrl,
    );
  }
}
