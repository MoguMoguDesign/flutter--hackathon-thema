# GitHub Actions CI/CD ガイド

このドキュメントでは、プロジェクトのCI/CD設定と使い方について説明します。

## 概要

本プロジェクトでは GitHub Actions を使用して、コード品質を自動的に検証します。
PRやmainブランチへのプッシュ時に、自動的に以下のチェックが実行されます。

## ワークフロー

### check.yml

コード品質を自動的に検証するワークフローです。

**トリガー条件:**
- `main`ブランチへのプッシュ
- プルリクエストの作成・更新

**実行内容:**
1. ✅ FVMのセットアップとFlutterのインストール
2. ✅ 依存関係のインストール (`flutter pub get`)
3. ✅ コード生成 (`build_runner`)
4. ✅ 静的解析 (`flutter analyze`)
5. ✅ コードフォーマットチェック (`dart format`)
6. ✅ CLAUDE.mdルールチェック (`.ai/check_claude_rules.py`)
7. ✅ テスト実行とカバレッジ (`flutter test --coverage`)
8. ✅ カバレッジレポートのアップロード (Codecov、オプション)

**タイムアウト:** 20分

**並行実行制御:**
同じブランチで複数のワークフローが実行される場合、古い実行は自動的にキャンセルされます。

## ローカルでのCI検証

プッシュ前にローカルでCI相当のチェックを実行する方法:

```bash
# 1. 依存関係のインストール
fvm flutter pub get

# 2. コード生成
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 3. 静的解析
fvm flutter analyze

# 4. フォーマットチェック
./.github/scripts/validate-formatting.sh

# 5. CLAUDE.mdルールチェック
python3 .ai/check_claude_rules.py

# 6. テスト実行
fvm flutter test --coverage
```

### 一括実行スクリプト

以下のスクリプトを `.github/scripts/run-all-checks.sh` として作成すると便利です:

```bash
#!/bin/bash
set -e

echo "🔍 Running all CI checks locally..."

echo "📦 1/6: Installing dependencies..."
fvm flutter pub get

echo "⚙️  2/6: Generating code..."
fvm flutter pub run build_runner build --delete-conflicting-outputs

echo "🔎 3/6: Running static analysis..."
fvm flutter analyze

echo "✨ 4/6: Checking code formatting..."
./.github/scripts/validate-formatting.sh

echo "📋 5/6: Checking CLAUDE.md compliance..."
python3 .ai/check_claude_rules.py

echo "🧪 6/6: Running tests..."
fvm flutter test --coverage

echo "✅ All checks passed!"
```

使い方:
```bash
chmod +x .github/scripts/run-all-checks.sh
./.github/scripts/run-all-checks.sh
```

## フォーマット検証スクリプト

`.github/scripts/validate-formatting.sh` は Dartコードのフォーマットを検証します。

**使い方:**
```bash
# 実行
./.github/scripts/validate-formatting.sh
```

**フォーマット修正方法:**
```bash
# 全ファイルをフォーマット
dart format .

# FVM使用時
fvm dart format .
```

## キャッシュ戦略

CI実行時間を短縮するため、以下をキャッシュしています:

1. **Flutter SDK**: `flutter-action`のビルトインキャッシュ
2. **生成ファイル**: `build_runner`で生成される`.g.dart`、`.freezed.dart`ファイル

キャッシュキーは以下に基づいて生成されます:
- `pubspec.lock`のハッシュ値
- Dartソースファイルのハッシュ値（生成ファイルを除く）

## Codecov統合（オプション）

テストカバレッジをCodecovにアップロードする場合:

1. [Codecov](https://codecov.io/)でリポジトリを有効化
2. リポジトリのSecretsに`CODECOV_TOKEN`を追加
3. 自動的にカバレッジレポートがアップロードされます

**注:** Codecov統合は失敗してもCI全体は失敗しません（`fail_ci_if_error: false`）

### Codecov Token の設定方法

1. GitHubリポジトリの **Settings** → **Secrets and variables** → **Actions** へ移動
2. **New repository secret** をクリック
3. Name: `CODECOV_TOKEN`
4. Secret: Codecovから取得したトークンを貼り付け
5. **Add secret** をクリック

## トラブルシューティング

### CIが失敗する場合

#### 1. 静的解析エラー

```bash
# ローカルで確認
fvm flutter analyze

# エラーを修正してから再コミット
```

#### 2. フォーマットエラー

```bash
# フォーマットを自動修正
fvm dart format .

# 変更をコミット
git add .
git commit -m "style: フォーマット修正"
```

#### 3. CLAUDE.mdルール違反

```bash
# 問題を確認
python3 .ai/check_claude_rules.py

# 指摘された問題を修正
# 例: ヘッダーの追加、ドキュメントの日本語化など
```

#### 4. テスト失敗

```bash
# ローカルでテストを実行
fvm flutter test

# 失敗したテストを確認して修正
# テストファイルを開いて問題を特定
```

#### 5. コード生成エラー

```bash
# クリーンして再生成
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### キャッシュ問題

キャッシュが原因で問題が発生している場合:

1. GitHub Actionsのワークフロー実行ページへ移動
2. 右上の **...** メニューから **Delete workflow cache** を選択
3. または、ワークフロー内のキャッシュキーを一時的に変更

### タイムアウト問題

ワークフローが20分以内に完了しない場合:

1. ローカルで各ステップの実行時間を確認
2. 特に時間がかかっているステップを特定
3. 必要に応じてタイムアウト値を調整（`.github/workflows/check.yml`）

## 開発ワークフロー推奨事項

### 1. コミット前にローカルチェック

Gitフックを使用すると、コミット時に自動的にチェックが実行されます。

```bash
# Git hooksを有効化
git config core.hooksPath .githooks

# これで git commit 時に自動的にチェックが実行されます
```

### 2. プルリクエスト作成前

- ✅ ローカルで全てのCIチェックが通ることを確認
- ✅ テストカバレッジが十分であることを確認
- ✅ コードレビューの準備（明確な説明、スクリーンショットなど）

### 3. CI失敗時の対応フロー

```
1. GitHub ActionsのログでエラーメッセージをP確認
   ↓
2. ローカルで同じチェックを実行して問題を再現
   ↓
3. 問題を修正
   ↓
4. ローカルで全チェックが通ることを確認
   ↓
5. 修正をコミット＆プッシュ
   ↓
6. CIが自動的に再実行される
```

## CI/CDのカスタマイズ

### 新しいチェックを追加する

`.github/workflows/check.yml` を編集して、新しいステップを追加できます。

例: カスタムスクリプトの追加

```yaml
- name: Run custom checks
  run: |
    chmod +x .github/scripts/custom-check.sh
    .github/scripts/custom-check.sh
```

### 並行ジョブの追加

複数のジョブを並行実行することで、CI時間を短縮できます。

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      # Lint checks only

  test:
    runs-on: ubuntu-latest
    steps:
      # Test execution only
```

## ベストプラクティス

1. **小さく頻繁にコミット**: 大きな変更は分割して、CIフィードバックを早く受け取る
2. **ローカルで事前チェック**: プッシュ前にローカルで全チェックを実行
3. **CI失敗を放置しない**: 失敗したら速やかに修正、または原因を調査
4. **キャッシュを活用**: 依存関係のインストール時間を短縮
5. **明確なコミットメッセージ**: Angular スタイルで何が変更されたか明確に

## 参考リンク

- [GitHub Actions公式ドキュメント](https://docs.github.com/ja/actions)
- [Flutter CI/CDベストプラクティス](https://docs.flutter.dev/deployment/cd)
- [FVM (Flutter Version Management)](https://fvm.app/)
- [Codecov Documentation](https://docs.codecov.com/)

---

最終更新: 2025-11-29
