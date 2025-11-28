# 技術スタック

## コア技術
- **Flutter SDK**: ^3.9.2
- **Dart**: >=3.9.0 <4.0.0
- **FVM**: Flutter Version Management (stable)

## 状態管理・ルーティング
- **hooks_riverpod**: ^3.0.3 - 最新の状態管理
- **flutter_hooks**: ^0.21.2 - React Hooks風の状態管理
- **riverpod_annotation**: ^3.0.3 - コード生成によるProvider定義
- **go_router**: ^16.2.4 - 宣言的ルーティング

## コード生成
- **build_runner**: ^2.6.0 - コード生成ツール
- **riverpod_generator**: ^3.0.3 - Riverpodプロバイダー生成
- **freezed**: ^3.2.3 - イミュータブルなモデル生成
- **freezed_annotation**: ^3.1.0
- **json_serializable**: ^6.11.1 - JSONシリアライゼーション
- **json_annotation**: ^4.9.0
- **go_router_builder**: ^4.1.0 - go_routerのコード生成

## 品質管理・Linting
- **very_good_analysis**: ^10.0.0 - 厳格な静的解析
- **riverpod_lint**: ^3.0.3 - Riverpod固有のLint
- **custom_lint**: ^0.8.0 - カスタムLintルール
- **flutter_lints**: ^6.0.0 - Flutter標準Lint

## UI・スタイリング
- **google_fonts**: ^6.2.1 - Googleフォント
- **flutter_svg**: ^2.0.10+1 - SVGサポート
- **gap**: ^3.0.1 - 簡易スペーシング

## ユーティリティ
- **async**: ^2.11.0 - 非同期処理ユーティリティ
- **logger**: ^2.6.2 - ロギング
- **uuid**: ^4.5.2 - UUID生成

## テスト
- **flutter_test**: SDK - テストフレームワーク
- **mockito**: ^5.5.0 - モックライブラリ

## パッケージマネージャー
すべてのFlutterコマンドは `fvm` プレフィックスを使用：
- `fvm flutter pub get`
- `fvm flutter run`
- `fvm flutter test`
- `fvm flutter analyze`
