import 'package:flutter/material.dart';
import 'package:flutterhackthema/src/component_test_page.dart';
import 'package:flutterhackthema/src/gourmet/gourmet_component_test_page.dart';
import 'package:flutterhackthema/src/home_page.dart';
import 'package:go_router/go_router.dart';

// 将来的にgo_router_builderでコード生成を使用する場合のために
// TypedGoRouteベースの定義を準備
// part 'routes.g.dart';

/// ホーム画面のルート
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

/// TCGコンポーネントテストページのルート
class TcgComponentsRoute extends GoRouteData {
  const TcgComponentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ComponentTestPage();
  }
}

/// Gourmetコンポーネントテストページのルート
class GourmetComponentsRoute extends GoRouteData {
  const GourmetComponentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GourmetComponentTestPage();
  }
}

/// ルート定義のヘルパー
///
/// 型安全なナビゲーション用:
/// ```dart
/// context.go(Routes.home);
/// context.go(Routes.tcgComponents);
/// context.go(Routes.gourmetComponents);
/// ```
class Routes {
  static const String home = '/';
  static const String tcgComponents = '/tcg-components';
  static const String gourmetComponents = '/gourmet-components';
}
