// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $nicknameRoute,
  $postsRoute,
  $createRoute,
  $previewRoute,
];

RouteBase get $nicknameRoute =>
    GoRouteData.$route(path: '/nickname', factory: $NicknameRoute._fromState);

mixin $NicknameRoute on GoRouteData {
  static NicknameRoute _fromState(GoRouterState state) => const NicknameRoute();

  @override
  String get location => GoRouteData.$location('/nickname');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $postsRoute =>
    GoRouteData.$route(path: '/posts', factory: $PostsRoute._fromState);

mixin $PostsRoute on GoRouteData {
  static PostsRoute _fromState(GoRouterState state) => const PostsRoute();

  @override
  String get location => GoRouteData.$location('/posts');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createRoute =>
    GoRouteData.$route(path: '/create', factory: $CreateRoute._fromState);

mixin $CreateRoute on GoRouteData {
  static CreateRoute _fromState(GoRouterState state) => const CreateRoute();

  @override
  String get location => GoRouteData.$location('/create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $previewRoute =>
    GoRouteData.$route(path: '/preview', factory: $PreviewRoute._fromState);

mixin $PreviewRoute on GoRouteData {
  static PreviewRoute _fromState(GoRouterState state) => const PreviewRoute();

  @override
  String get location => GoRouteData.$location('/preview');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
