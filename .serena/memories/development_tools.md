# 開発支援ツール

## Claude Code 専用エージェント

本プロジェクトには、開発を効率化するための専用エージェントが設定されています。

### Flutter開発エージェント

#### 1. flutter-component-specialist
**用途**: Flutter UIコンポーネントの作成・テスト・最適化

**起動方法**:
- スラッシュコマンド: `/component`
- キーワード: "コンポーネント作成", "ウィジェット作成", "UI作成"

**得意分野**:
- UIコンポーネント作成
- Material Design & カスタムデザインシステム
- レスポンシブレイアウト
- ウィジェットテスト
- パフォーマンス最適化
- アクセシビリティ対応

---

#### 2. riverpod-state-expert
**用途**: hooks_riverpod v3.x を使った状態管理の実装

**起動方法**:
- スラッシュコマンド: `/state`
- キーワード: "状態管理", "Riverpod", "プロバイダー"

**得意分野**:
- Riverpod v3.x パターン
- @riverpod コード生成
- AsyncNotifier / StateNotifier
- Provider依存関係の管理
- HooksConsumerWidget パターン
- プロバイダーテスト

---

#### 3. go-router-navigator
**用途**: go_router v16.x を使った宣言的ルーティングの実装

**起動方法**:
- スラッシュコマンド: `/router`
- キーワード: "ルーティング", "ナビゲーション", "画面遷移"

**得意分野**:
- ルーター設定
- 型安全なルーティング (GoRouteData)
- ナビゲーションガード
- 認証リダイレクト
- ShellRoute / StatefulShellRoute
- ディープリンク対応

---

### Git / GitHub エージェント

#### 4. github-commit-agent
**用途**: プロジェクト標準に従った適切なコミット作成

**起動方法**:
- スラッシュコマンド: `/commit`
- キーワード: "コミット", "コミット作成"
- 自動起動: ユーザーがコミット作成を依頼した時

**得意分野**:
- Angular スタイルのコミットメッセージ
- コミット前の変更確認
- 適切なファイルステージング

**コミットメッセージ形式**:
```
<type>(<scope>): <subject>

type: feat, fix, docs, style, refactor, test, chore
scope: auth, profile, shared, app など
subject: 簡潔な説明

例:
feat(auth): ログイン機能を追加
fix(profile): ユーザー名表示のバグを修正
refactor(shared): ボタンコンポーネントを改善
```

---

#### 5. github-pr-creator
**用途**: GitHub プルリクエストの作成

**起動方法**:
- スラッシュコマンド: `/pr`
- キーワード: "PR", "プルリクエスト"
- 自動起動: ユーザーがPR作成を依頼した時

**得意分野**:
- PRテンプレートの使用
- 変更内容のサマリー作成
- テストプランの記述

---

#### 6. github-issue-creator
**用途**: GitHub イシューの作成

**起動方法**:
- スラッシュコマンド: `/issue`
- キーワード: "Issue", "イシュー", "バグレポート", "機能リクエスト"
- 自動起動: ユーザーがイシュー作成を依頼した時

**得意分野**:
- バグレポート
- 機能リクエスト
- リファクタリング提案
- イシューテンプレートの使用

---

## スラッシュコマンド一覧

### Flutter開発
| コマンド | エージェント | 用途 |
|---------|------------|------|
| `/component` | flutter-component-specialist | UIコンポーネント開発 |
| `/state` | riverpod-state-expert | Riverpod状態管理 |
| `/router` | go-router-navigator | go_routerルーティング |

### Git / GitHub
| コマンド | エージェント | 用途 |
|---------|------------|------|
| `/commit` | github-commit-agent | コミット作成 |
| `/pr` | github-pr-creator | プルリクエスト作成 |
| `/issue` | github-issue-creator | イシュー作成 |

### ヘルプ
| コマンド | 用途 |
|---------|------|
| `/agents` | 全エージェント一覧表示 |

## 開発ワークフロー例

### 新機能開発の場合
```
1. /state
   → Riverpodで状態管理を実装

2. /component
   → UIコンポーネントを作成

3. /router
   → ルーティングを設定

4. 動作確認・テスト実行

5. /commit
   → 変更をコミット

6. /pr
   → プルリクエストを作成
```

### バグ修正の場合
```
1. バグ修正を実装

2. テスト追加・実行

3. /commit
   → 修正をコミット

4. /issue (必要に応じて)
   → バグレポートを作成
```

### リファクタリングの場合
```
1. コード改善実装

2. 既存テストの確認

3. /commit
   → リファクタリングをコミット
```

## GitHub テンプレート

### プルリクエストテンプレート
場所: `.github/PULL_REQUEST_TEMPLATE.md`

**含まれるセクション**:
- Description: 変更内容の説明
- Key Changes: 主要な変更点
- Files Added/Modified: 追加・修正ファイル
- How to Test: テスト手順
- Benefits: 変更による利点
- Screenshots: UI変更のスクリーンショット
- Related Issues: 関連Issue番号

### イシューテンプレート
場所: `.github/ISSUE_TEMPLATE/`

**種類**:
1. **Bug Report** (`bug_report.md`)
   - バグの説明
   - 再現手順
   - 期待される動作
   - 実際の動作
   - 環境情報

2. **Feature Request** (`feature_request.md`)
   - 機能の説明
   - 必要性と利点
   - 提案する解決策
   - 代替案

3. **Refactor / Cleanup** (`refactor_cleanup.md`)
   - リファクタリング対象
   - 必要性
   - 提案する変更内容
   - 影響範囲

## エージェント使用のベストプラクティス

### ✅ DO
- 具体的なタスクを明確に指示
- 関連するファイルやコードを事前に確認
- エージェント完了後、結果を確認
- 必要に応じて手動で微調整

### ❌ DON'T
- 曖昧な指示をしない
- 複数のエージェントを同時に起動しない
- エージェントの結果を確認せずに次に進まない

## トラブルシューティング

### エージェントが起動しない
**解決方法**:
- より具体的なキーワードを使用
- スラッシュコマンドを明示的に使用
- `/agents` でエージェント一覧を確認

### コード生成エラー
**解決方法**:
```bash
# キャッシュクリアして再生成
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## 参考資料

### Claude Code
- [Claude Code ドキュメント](https://docs.anthropic.com/claude/docs)
- `.claude/agents/README.md`: エージェント詳細
- `.claude/commands/README.md`: コマンド詳細

### Flutter / Dart
- [hooks_riverpod](https://riverpod.dev)
- [go_router](https://pub.dev/packages/go_router)
- [freezed](https://pub.dev/packages/freezed)
- [Flutter ドキュメント](https://docs.flutter.dev)

### プロジェクト固有
- `README.md`: プロジェクト概要
- `CONTRIBUTING.md`: コントリビューションガイド
- `docs/ARCHITECTURE.md`: アーキテクチャ詳細
- `docs/STYLE_GUIDE.md`: スタイルガイド
