# Claude Code サブエージェント

このプロジェクト用に設定されたサブエージェントの一覧と使い方です。

## Flutter 開発エージェント

### flutter-component-specialist
**用途**: Flutter UIコンポーネントの作成・テスト・最適化

**使用例**:
```
新しいカスタムボタンコンポーネントを作成したい
→ flutter-component-specialistエージェントを使用
```

**得意分野**:
- UIコンポーネント作成
- Material Design & カスタムデザインシステム
- レスポンシブレイアウト
- ウィジェットテスト
- パフォーマンス最適化
- アクセシビリティ対応

---

### riverpod-state-expert
**用途**: hooks_riverpod v3.x を使った状態管理の実装

**使用例**:
```
ユーザー認証の状態管理を実装したい
→ riverpod-state-expertエージェントを使用
```

**得意分野**:
- Riverpod v3.x パターン
- @riverpod コード生成
- AsyncNotifier / StateNotifier
- Provider依存関係の管理
- HooksConsumerWidget パターン
- プロバイダーテスト

---

### go-router-navigator
**用途**: go_router v16.x を使った宣言的ルーティングの実装

**使用例**:
```
アプリのルーティングを設定したい
→ go-router-navigatorエージェントを使用
```

**得意分野**:
- ルーター設定
- 型安全なルーティング (GoRouteData)
- ナビゲーションガード
- 認証リダイレクト
- ShellRoute / StatefulShellRoute
- ディープリンク対応

---

## Git / GitHub エージェント

### github-commit-agent
**用途**: プロジェクト標準に従った適切なコミット作成

**自動起動**: ユーザーがコミット作成を依頼した時

**得意分野**:
- Angular スタイルのコミットメッセージ
- コミット前の変更確認
- 適切なファイルステージング

---

### github-pr-creator
**用途**: GitHub プルリクエストの作成

**自動起動**: ユーザーがPR作成を依頼した時

**得意分野**:
- PRテンプレートの使用
- 変更内容のサマリー作成
- テストプランの記述

---

### github-issue-creator
**用途**: GitHub イシューの作成

**自動起動**: ユーザーがイシュー作成を依頼した時

**得意分野**:
- バグレポート
- 機能リクエスト
- イシューテンプレートの使用

---

## エージェントの使い方

### 基本的な使い方

Claude Code がタスクの種類を認識して自動的に適切なエージェントを起動します：

```
ユーザー: "新しいカードコンポーネントを作成したい"
Claude: "flutter-component-specialist エージェントを使用してカードコンポーネントを作成します"
```

### 明示的な指定

特定のエージェントを明示的に指定することもできます：

```
ユーザー: "flutter-component-specialist を使って新しいボタンを作成して"
Claude: "flutter-component-specialist エージェントでボタンコンポーネントを作成します"
```

---

## プロジェクト構成とエージェントの関係

```
lib/
├── app/                    # → go-router-navigator (ルーティング)
│   └── router.dart
├── features/               # → riverpod-state-expert (状態管理)
│   └── auth/
│       └── providers/
└── widgets/                # → flutter-component-specialist (UI)
    ├── buttons/
    ├── cards/
    └── dialogs/
```

---

## テクノロジースタック

このプロジェクトで使用している主要パッケージ：

- **State Management**: hooks_riverpod ^3.0.3
- **Routing**: go_router ^16.2.4
- **Hooks**: flutter_hooks ^0.21.2
- **Code Generation**:
  - riverpod_generator ^3.0.3
  - freezed ^3.2.3
  - build_runner ^2.6.0
- **UI**:
  - google_fonts ^6.2.1
  - flutter_svg ^2.0.10+1
  - gap ^3.0.1
- **Linting**:
  - very_good_analysis ^10.0.0
  - riverpod_lint ^3.0.3

---

## 開発ワークフロー

### 1. 新機能の実装

```
1. riverpod-state-expert → 状態管理の実装
2. flutter-component-specialist → UIコンポーネント作成
3. go-router-navigator → ルーティング設定
4. github-commit-agent → コミット作成
5. github-pr-creator → PR作成
```

### 2. バグ修正

```
1. 該当エージェントを使って修正
2. github-commit-agent → コミット作成
3. github-issue-creator → 必要に応じてイシュー作成
```

### 3. リファクタリング

```
1. 該当エージェントを使ってリファクタリング
2. github-commit-agent → コミット作成
```

---

## コード生成コマンド

### Riverpod プロバイダー生成

```bash
# 1回だけ生成
dart run build_runner build --delete-conflicting-outputs

# 監視モード（ファイル変更時に自動生成）
dart run build_runner watch --delete-conflicting-outputs
```

### クリーンビルド

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## ベストプラクティス

### 状態管理
- [ ] すべての新しいプロバイダーで `@riverpod` を使用
- [ ] コード生成を実行（build_runner）
- [ ] プロバイダーテストを作成

### UIコンポーネント
- [ ] const コンストラクタを使用
- [ ] 日本語ドキュメントを追加
- [ ] ウィジェットテストを作成
- [ ] テーマ統合を確認

### ルーティング
- [ ] 型安全なルーティング（GoRouteData）を使用
- [ ] 認証ガードを実装
- [ ] ディープリンクをテスト

### コミット
- [ ] Angular スタイルのメッセージ
- [ ] 変更内容を確認してからコミット
- [ ] 適切なファイルのみステージング

---

## トラブルシューティング

### エージェントが起動しない

エージェントの説明文に含まれるキーワードを使って依頼してください：

```
❌ "ボタンを作って"
✅ "新しいカスタムボタンコンポーネントを作成したい"

❌ "状態管理を追加して"
✅ "Riverpodで状態管理を実装したい"
```

### コード生成エラー

```bash
# クリーンしてから再ビルド
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## 参考資料

- [hooks_riverpod ドキュメント](https://riverpod.dev)
- [go_router ドキュメント](https://pub.dev/packages/go_router)
- [Flutter ドキュメント](https://docs.flutter.dev)
- [very_good_analysis](https://pub.dev/packages/very_good_analysis)
