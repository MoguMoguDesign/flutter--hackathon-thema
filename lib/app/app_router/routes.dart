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
import 'package:go_router/go_router.dart';

import 'package:flutterhackthema/features/haiku/presentation/pages/generating_page.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/haiku_input_page.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/haiku_list_page.dart';
import 'package:flutterhackthema/features/haiku/presentation/pages/preview_page.dart';
import 'package:flutterhackthema/features/nickname/presentation/pages/nickname_page.dart';
import 'package:flutterhackthema/features/posts/presentation/pages/post_detail_page.dart';

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

/// 俳句一覧画面のルート定義
///
/// パス: /posts
/// 全ユーザーの俳句を一覧表示する画面
/// Pinterest風のグリッドレイアウトで表示されます
///
/// 使用例:
/// ```dart
/// const HaikuListRoute().go(context);
/// ```
@TypedGoRoute<HaikuListRoute>(path: '/posts')
class HaikuListRoute extends GoRouteData with $HaikuListRoute {
  /// [HaikuListRoute] のコンストラクタ
  const HaikuListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HaikuListPage();
  }
}

/// @Deprecated('Use HaikuListRoute instead')
/// 後方互換性のため残しています
typedef PostsRoute = HaikuListRoute;

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
/// 画像データはImageGenerationProviderから取得します
///
/// 使用例:
/// ```dart
/// PreviewRoute(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// ).go(context);
/// ```
@TypedGoRoute<PreviewRoute>(path: '/create/preview')
class PreviewRoute extends GoRouteData with $PreviewRoute {
  /// [PreviewRoute] のコンストラクタ
  const PreviewRoute({
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
    return PreviewPage(
      firstLine: firstLine,
      secondLine: secondLine,
      thirdLine: thirdLine,
    );
  }
}
