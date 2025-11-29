import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 将来的にgo_router_builderでコード生成を使用する場合のために
// TypedGoRouteベースの定義を準備
// part 'routes.g.dart';

/// ホーム画面のルート
class HomeRoute extends GoRouteData {
  /// [HomeRoute] のコンストラクタ
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Scaffold();
  }
}

/// ルート定義のヘルパー
///
/// 型安全なナビゲーション用:
/// ```dart
/// context.go(Routes.home);
/// ```
class Routes {
  /// ホーム画面のパス
  static const String home = '/';
}
