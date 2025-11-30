// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $nicknameRoute,
  $haikuListRoute,
  $postDetailRoute,
  $createRoute,
  $generatingRoute,
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

RouteBase get $haikuListRoute =>
    GoRouteData.$route(path: '/posts', factory: $HaikuListRoute._fromState);

mixin $HaikuListRoute on GoRouteData {
  static HaikuListRoute _fromState(GoRouterState state) =>
      const HaikuListRoute();

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

RouteBase get $postDetailRoute => GoRouteData.$route(
  path: '/posts/:postId',
  factory: $PostDetailRoute._fromState,
);

mixin $PostDetailRoute on GoRouteData {
  static PostDetailRoute _fromState(GoRouterState state) =>
      PostDetailRoute(postId: state.pathParameters['postId']!);

  PostDetailRoute get _self => this as PostDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/posts/${Uri.encodeComponent(_self.postId)}');

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

RouteBase get $generatingRoute => GoRouteData.$route(
  path: '/create/generating',
  factory: $GeneratingRoute._fromState,
);

mixin $GeneratingRoute on GoRouteData {
  static GeneratingRoute _fromState(GoRouterState state) => GeneratingRoute(
    firstLine: state.uri.queryParameters['first-line']!,
    secondLine: state.uri.queryParameters['second-line']!,
    thirdLine: state.uri.queryParameters['third-line']!,
  );

  GeneratingRoute get _self => this as GeneratingRoute;

  @override
  String get location => GoRouteData.$location(
    '/create/generating',
    queryParams: {
      'first-line': _self.firstLine,
      'second-line': _self.secondLine,
      'third-line': _self.thirdLine,
    },
  );

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

RouteBase get $previewRoute => GoRouteData.$route(
  path: '/create/preview',
  factory: $PreviewRoute._fromState,
);

mixin $PreviewRoute on GoRouteData {
  static PreviewRoute _fromState(GoRouterState state) => PreviewRoute(
    firstLine: state.uri.queryParameters['first-line']!,
    secondLine: state.uri.queryParameters['second-line']!,
    thirdLine: state.uri.queryParameters['third-line']!,
  );

  PreviewRoute get _self => this as PreviewRoute;

  @override
  String get location => GoRouteData.$location(
    '/create/preview',
    queryParams: {
      'first-line': _self.firstLine,
      'second-line': _self.secondLine,
      'third-line': _self.thirdLine,
    },
  );

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
