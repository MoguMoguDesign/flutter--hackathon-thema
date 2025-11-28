# よく使うコマンド

## 基本コマンド

### 依存関係管理
```bash
# 依存関係のインストール
fvm flutter pub get

# 依存関係の更新
fvm flutter pub upgrade

# pubspec.lockを削除して再インストール（依存関係エラー時）
rm pubspec.lock && fvm flutter pub get
```

### 静的解析・フォーマット
```bash
# 静的解析（エラーチェック）
fvm flutter analyze

# コードフォーマット
dart format --set-exit-if-changed .

# コードフォーマット（自動修正）
dart format .
```

### テスト
```bash
# すべてのテストを実行
fvm flutter test

# 特定のテストファイルを実行
fvm flutter test test/features/auth/auth_test.dart

# カバレッジレポート生成
fvm flutter test --coverage
```

### アプリ起動・ビルド
```bash
# アプリ起動（開発モード）
fvm flutter run

# デバッグビルド
fvm flutter build apk --debug

# リリースビルド
fvm flutter build apk --release

# iOSビルド
fvm flutter build ios

# Webビルド
fvm flutter build web
```

## コード生成

### Riverpod・Freezed生成
```bash
# 一度だけ生成
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watchモード（開発中推奨・ファイル変更時に自動生成）
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# クリーン後に再生成
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## トラブルシューティング

### コード生成エラー時
```bash
# キャッシュをクリアして再生成
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### FVMバージョン不一致時
```bash
# プロジェクトのFlutterバージョンを再インストール
fvm install
fvm use
```

## Git コマンド

### ブランチ操作
```bash
# ブランチ確認
git branch

# 新しいブランチ作成・切り替え
git checkout -b feature/your-feature-name

# ブランチ切り替え
git checkout main
```

### コミット
```bash
# 変更確認
git status
git diff

# ステージング
git add .

# コミット（Angularスタイル）
git commit -m "feat(scope): 機能説明"
git commit -m "fix(scope): バグ修正説明"
git commit -m "refactor(scope): リファクタリング説明"

# プッシュ
git push origin feature/your-feature-name
```

## macOS システムコマンド

### ファイル操作
```bash
# ディレクトリ一覧
ls -la

# ファイル検索
find . -name "*.dart"

# テキスト検索
grep -r "pattern" lib/
```

### プロセス管理
```bash
# プロセス一覧
ps aux | grep flutter

# ポート確認
lsof -i :8080
```

## Claude Code 専用コマンド

### スラッシュコマンド
```bash
/component  # UIコンポーネント作成
/state      # Riverpod状態管理
/router     # go_routerルーティング
/commit     # コミット作成
/pr         # プルリクエスト作成
/issue      # GitHub Issue作成
/agents     # エージェント一覧表示
```

## 開発ワークフロー推奨コマンド順序

### 新機能開発時
```bash
1. git checkout -b feature/new-feature
2. fvm flutter pub get
3. # コード編集
4. fvm flutter pub run build_runner build --delete-conflicting-outputs
5. fvm flutter analyze
6. dart format .
7. fvm flutter test
8. git add .
9. git commit -m "feat: 新機能の説明"
10. git push origin feature/new-feature
```

### タスク完了時のチェック
```bash
# 必須チェック（この順序で実行）
1. fvm flutter analyze   # 静的解析エラーなし
2. dart format .          # コードフォーマット
3. fvm flutter test       # 全テストパス

# 成功したらコミット可能
```
