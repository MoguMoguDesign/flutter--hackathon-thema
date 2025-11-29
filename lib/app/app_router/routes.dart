// 将来的にgo_router_builderでコード生成を使用する場合のために
// TypedGoRouteベースの定義を準備
// part 'routes.g.dart';

/// ルート定義のヘルパー
///
/// アプリケーション全体で使用するルートパスを定義します
///
/// 型安全なナビゲーション用:
/// ```dart
/// context.go(Routes.nickname);
/// context.go(Routes.posts);
/// ```
class Routes {
  /// ニックネーム入力画面のパス
  ///
  /// ユーザーが初回訪問時にニックネームを入力する画面
  /// アプリの初期ルートとして使用されます
  static const String nickname = '/nickname';

  /// 投稿一覧画面のパス
  ///
  /// 全ユーザーの投稿を一覧表示する画面
  /// Pinterest風のグリッドレイアウトで表示されます
  static const String posts = '/posts';

  /// 投稿作成画面のパス
  ///
  /// 俳句を入力して画像生成を行う画面
  /// DALL-E 3 APIを使用して画像を生成します
  static const String create = '/create';

  /// プレビュー画面のパス
  ///
  /// 生成された画像と俳句のプレビューを表示する画面
  /// 投稿の確認と投稿実行を行います
  static const String preview = '/preview';
}
