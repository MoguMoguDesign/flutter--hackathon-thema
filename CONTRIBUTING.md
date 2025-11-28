# コントリビューションガイド

Flutter Hackathon Thema プロジェクトへのコントリビューションをご検討いただき、ありがとうございます！
このドキュメントは、プロジェクトへの貢献方法とガイドラインを説明します。

---

## 目次

1. [はじめに](#はじめに)
2. [開発環境のセットアップ](#開発環境のセットアップ)
3. [開発ワークフロー](#開発ワークフロー)
4. [コーディング規約](#コーディング規約)
5. [コミットメッセージ](#コミットメッセージ)
6. [プルリクエスト](#プルリクエスト)
7. [イシューの作成](#イシューの作成)
8. [テスト](#テスト)
9. [コードレビュー](#コードレビュー)

---

## はじめに

### プロジェクトの目的

このプロジェクトは、Flutter のハッカソン用テーマアプリケーションです。
三層アーキテクチャ（App → Feature → Shared）を採用し、スケーラブルで保守性の高いコードベースを目指しています。

### 貢献の種類

以下のような貢献を歓迎します：

- 🐛 バグ修正
- ✨ 新機能の追加
- 📝 ドキュメントの改善
- 🎨 UI/UX の改善
- ♻️ リファクタリング
- ✅ テストの追加・改善

---

## 開発環境のセットアップ

### 必要なツール

1. **Flutter SDK**: 3.9.2 以上
2. **FVM** (Flutter Version Management)
3. **Git**
4. **エディタ**: VS Code または Android Studio 推奨

### セットアップ手順

#### 1. リポジトリのクローン

```bash
git clone https://github.com/yourusername/flutter--hackathon-thema.git
cd flutter--hackathon-thema
```

#### 2. FVM で Flutter をインストール

```bash
# FVM がインストールされていない場合
dart pub global activate fvm

# プロジェクトで使用する Flutter バージョンをインストール
fvm install

# FVM を使用するように設定
fvm use
```

#### 3. 依存関係のインストール

```bash
fvm flutter pub get
```

#### 4. コード生成

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

#### 5. 動作確認

```bash
# 静的解析
fvm flutter analyze

# テスト実行
fvm flutter test

# アプリ起動
fvm flutter run
```

---

## 開発ワークフロー

### ブランチ戦略

- **main**: 本番環境用の安定版ブランチ
- **feature/\***: 新機能開発用ブランチ
- **fix/\***: バグ修正用ブランチ
- **refactor/\***: リファクタリング用ブランチ
- **docs/\***: ドキュメント更新用ブランチ

### 開発の流れ

#### 1. イシューの確認・作成

既存のイシューを確認し、作業内容が決まったら新しいイシューを作成します。

```bash
# GitHub で Issue を作成
# 適切なテンプレートを選択（Bug Report / Feature Request / Refactor）
```

#### 2. ブランチの作成

```bash
# main ブランチから最新を取得
git checkout main
git pull origin main

# 作業用ブランチを作成
git checkout -b feature/your-feature-name

# または
git checkout -b fix/issue-123-bug-description
```

#### 3. 開発作業

```bash
# コードを編集

# コード生成（必要に応じて）
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 静的解析でエラーがないか確認
fvm flutter analyze

# フォーマット
dart format --set-exit-if-changed .
```

#### 4. テストの実行

```bash
# すべてのテストを実行
fvm flutter test

# 特定のテストファイルを実行
fvm flutter test test/features/auth/auth_test.dart
```

#### 5. コミット

```bash
git add .
git commit -m "feat: ユーザー認証機能を追加"
```

#### 6. プッシュとプルリクエスト

```bash
# リモートにプッシュ
git push origin feature/your-feature-name

# GitHub でプルリクエストを作成
```

---

## コーディング規約

本プロジェクトは厳格なコーディング規約に従います。
詳細は [docs/STYLE_GUIDE.md](docs/STYLE_GUIDE.md) を参照してください。

### 主要なルール

1. **flutter_lints に従う**: `fvm flutter analyze` でエラーが出ないこと
2. **型を明示する**: `var` の使用を避け、明示的な型指定を行う
3. **const を使用する**: パフォーマンス向上のため積極的に使用
4. **コメントを書く**: 公開 API には必ずドキュメントコメントを記載
5. **命名規則を守る**:
   - ファイル: `snake_case`
   - クラス: `PascalCase`
   - 変数・関数: `lowerCamelCase`

### アーキテクチャ

本プロジェクトは三層アーキテクチャを採用しています。
詳細は [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) を参照してください。

**依存関係のルール**:
- App → Feature → Shared の一方向依存
- Feature 間の直接依存は禁止
- Shared は他の層に依存しない

---

## コミットメッセージ

### Angular スタイルのコミットメッセージ

本プロジェクトは Angular のコミットメッセージ規約に従います。

#### フォーマット

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### Type（必須）

- `feat`: 新機能の追加
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの動作に影響しない変更（フォーマット、セミコロン等）
- `refactor`: リファクタリング
- `test`: テストの追加・修正
- `chore`: ビルドプロセスやツールの変更

#### Scope（任意）

変更の影響範囲を指定します。

- `auth`: 認証機能
- `profile`: プロフィール機能
- `shared`: 共通コンポーネント
- `app`: アプリ全体

#### 例

```bash
# 新機能
git commit -m "feat(auth): ログイン機能を追加"

# バグ修正
git commit -m "fix(profile): ユーザー名の表示エラーを修正"

# ドキュメント
git commit -m "docs: CONTRIBUTING.md を更新"

# リファクタリング
git commit -m "refactor(shared): CustomButton を再利用可能に改善"

# テスト
git commit -m "test(auth): ログインテストを追加"
```

#### 詳細な説明が必要な場合

```bash
git commit -m "feat(auth): ログイン機能を追加

- メールアドレスとパスワードによる認証
- Firebase Authentication を使用
- エラーハンドリングを実装

Closes #123"
```

---

## プルリクエスト

### プルリクエスト作成前のチェックリスト

- [ ] `fvm flutter analyze` でエラーがないこと
- [ ] `fvm flutter test` がすべてパスすること
- [ ] コードが [STYLE_GUIDE.md](docs/STYLE_GUIDE.md) に準拠していること
- [ ] 新機能にはテストが追加されていること
- [ ] ドキュメントが更新されていること（必要な場合）
- [ ] コミットメッセージが規約に従っていること

### プルリクエストテンプレート

GitHub のプルリクエストテンプレートが自動的に適用されます。
以下のセクションを埋めてください：

- **Description**: 変更内容の説明
- **Key Changes**: 主要な変更点のリスト
- **Files Added/Modified**: 追加・修正されたファイルの説明
- **How to Test**: テスト手順
- **Benefits**: 変更による利点
- **Screenshots**: UI 変更がある場合のスクリーンショット
- **Related Issues**: 関連するイシュー番号（`Closes #123`）
- **Additional Notes**: レビュアーへの追加情報

### レビューの流れ

1. **PR を作成**: GitHub でプルリクエストを作成
2. **自動チェック**: CI/CD が自動的に実行される
3. **コードレビュー**: レビュアーがコードを確認
4. **修正**: 指摘事項があれば修正してプッシュ
5. **承認**: レビュアーが承認
6. **マージ**: main ブランチにマージ

---

## イシューの作成

### イシューテンプレート

プロジェクトには3種類のイシューテンプレートがあります：

#### 1. Bug Report（バグ報告）

バグや予期しない動作を報告する場合に使用します。

**必要な情報**:
- バグの説明
- 再現手順
- 期待される動作
- 実際の動作
- スクリーンショット/ログ
- 環境情報（OS、Flutter バージョン、デバイス等）

#### 2. Feature Request（機能リクエスト）

新機能や改善を提案する場合に使用します。

**必要な情報**:
- 機能の説明
- 必要性と利点
- 提案する解決策
- 検討した代替案

#### 3. Refactor / Code Cleanup（リファクタリング）

リファクタリングやコードクリーンアップを提案する場合に使用します。

**必要な情報**:
- リファクタリング対象の説明
- 必要性（可読性、パフォーマンス、保守性等）
- 提案する変更内容
- 潜在的なリスク
- 影響を受けるファイル/モジュール

### ラベルの使用

イシューには適切なラベルを付けてください：

- `bug`: バグ
- `enhancement`: 新機能・改善
- `refactor`: リファクタリング
- `documentation`: ドキュメント
- `good first issue`: 初心者向け
- `help wanted`: ヘルプ募集中

---

## テスト

### テストの種類

1. **Unit Test**: 個別の関数やクラスのテスト
2. **Widget Test**: ウィジェットの動作テスト
3. **Integration Test**: 複数のコンポーネントの統合テスト

### テストの作成ルール

- すべての新機能にはテストを追加する
- リポジトリやプロバイダーには必ずテストを書く
- テストファイルは対応するソースファイルと同じディレクトリ構造にする

```
lib/features/auth/data/repositories/auth_repository.dart
↓
test/features/auth/data/repositories/auth_repository_test.dart
```

### テストの実行

```bash
# すべてのテストを実行
fvm flutter test

# 特定のファイルをテスト
fvm flutter test test/features/auth/auth_repository_test.dart

# カバレッジレポートを生成
fvm flutter test --coverage
```

---

## コードレビュー

### レビュアーのガイドライン

#### チェック項目

- [ ] コードが [STYLE_GUIDE.md](docs/STYLE_GUIDE.md) に準拠しているか
- [ ] アーキテクチャのルールに従っているか
- [ ] テストが適切に書かれているか
- [ ] パフォーマンスの問題がないか
- [ ] セキュリティの問題がないか
- [ ] ドキュメントが適切に更新されているか

#### レビューのトーン

- **建設的なフィードバック**: 改善点を具体的に指摘
- **肯定的な姿勢**: 良い点も積極的に評価
- **質問形式**: 「なぜこのように実装したのですか？」
- **提案**: 「こうすることもできますが、どうでしょうか？」

### レビュイーのガイドライン

- フィードバックを前向きに受け入れる
- 不明点は遠慮なく質問する
- 指摘事項は速やかに対応する
- 議論が必要な場合は丁寧にコミュニケーションを取る

---

## その他

### 質問やサポート

- **GitHub Discussions**: 一般的な質問や議論
- **GitHub Issues**: バグ報告や機能リクエスト
- **Slack/Discord**: リアルタイムなコミュニケーション（設定されている場合）

### ライセンス

本プロジェクトはプライベートプロジェクトです。
コントリビューションする際は、プロジェクトのライセンスに同意したものとみなされます。

---

## まとめ

このガイドラインに従って開発することで、高品質なコードベースを維持できます。
不明な点があれば、遠慮なく質問してください。

皆様のコントリビューションをお待ちしています！
