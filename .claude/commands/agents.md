---
description: Display all available agents and their quick access commands
---

# 利用可能なエージェント一覧

このプロジェクトで使用できるサブエージェントとスラッシュコマンドの一覧です。

## Flutter 開発エージェント

### `/component` - UIコンポーネント開発
**エージェント**: flutter-component-specialist
**用途**: Flutter UIコンポーネントの作成・テスト・最適化
**カラー**: 紫

**使用例**:
```
/component
新しいカスタムボタンコンポーネントを作成して
```

**得意分野**:
- UIコンポーネント作成
- Material Design & カスタムデザイン
- レスポンシブレイアウト
- ウィジェットテスト
- パフォーマンス最適化

---

### `/state` - 状態管理
**エージェント**: riverpod-state-expert
**用途**: hooks_riverpod v3.x を使った状態管理
**カラー**: シアン

**使用例**:
```
/state
ユーザー認証の状態管理を実装して
```

**得意分野**:
- @riverpod コード生成
- AsyncNotifier / StateNotifier
- Provider依存管理
- HookConsumerWidget
- プロバイダーテスト

---

### `/router` - ルーティング
**エージェント**: go-router-navigator
**用途**: go_router v16.x を使った宣言的ルーティング
**カラー**: オレンジ

**使用例**:
```
/router
アプリのルーティング設定をセットアップして
```

**得意分野**:
- GoRouter設定
- 型安全なルーティング (GoRouteData)
- ナビゲーションガード
- ShellRoute / StatefulShellRoute
- ディープリンク

---

## Git / GitHub エージェント

### `/commit` - コミット作成
**エージェント**: github-commit-agent
**用途**: プロジェクト標準に従った適切なコミット作成

**使用例**:
```
/commit
この変更をコミットして
```

**処理内容**:
1. git status & diff 確認
2. コミットメッセージ作成
3. ファイルステージング
4. コミット実行

---

### `/pr` - プルリクエスト作成
**エージェント**: github-pr-creator
**用途**: GitHub プルリクエストの作成

**使用例**:
```
/pr
この機能のPRを作成して
```

**処理内容**:
1. ブランチ確認
2. 変更内容サマリー作成
3. push（必要な場合）
4. PR作成

---

### `/issue` - イシュー作成
**エージェント**: github-issue-creator
**用途**: GitHub イシューの作成

**使用例**:
```
/issue
バグレポートを作成して
```

**処理内容**:
1. イシュータイプ判定
2. 情報収集
3. イシュー作成
4. ラベル設定

---

## 使い方のコツ

### 基本的な使い方
1. スラッシュコマンドを入力（例: `/component`）
2. 具体的なタスクを指示
3. エージェントが自動的に起動して処理

### 明示的な起動
スラッシュコマンドなしでも、キーワードで自動起動：
```
"新しいボタンコンポーネントを作成" → /component 相当
"状態管理を実装" → /state 相当
"コミットして" → /commit 相当
```

### よくある組み合わせ

**新機能の開発フロー**:
```
1. /state → 状態管理実装
2. /component → UIコンポーネント作成
3. /router → ルーティング設定
4. /commit → コミット作成
5. /pr → プルリクエスト作成
```

**バグ修正フロー**:
```
1. 修正実装
2. /commit → コミット作成
3. /issue → イシュー作成（必要に応じて）
```

---

## テクノロジースタック

- **State Management**: hooks_riverpod ^3.0.3
- **Routing**: go_router ^16.2.4
- **Hooks**: flutter_hooks ^0.21.2
- **Code Generation**: riverpod_generator, freezed, build_runner
- **Linting**: very_good_analysis, riverpod_lint

---

## よくある質問

**Q: エージェントが起動しない場合は？**
A: より具体的なキーワードを使ってください：
- ❌ "ボタンを作って"
- ✅ "新しいカスタムボタンコンポーネントを作成して"

**Q: スラッシュコマンドとエージェント名の違いは？**
A: スラッシュコマンドは短いエイリアスです：
- `/component` = flutter-component-specialist
- `/state` = riverpod-state-expert
- `/router` = go-router-navigator

**Q: 複数のエージェントを同時に使える？**
A: 1つずつ順番に使用することを推奨します。

---

詳細は `.claude/agents/README.md` を参照してください。
