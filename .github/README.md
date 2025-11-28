# GitHub テンプレート

このディレクトリには、プロジェクトで使用するGitHubテンプレートが含まれています。

## 📋 プルリクエストテンプレート

**ファイル**: `PULL_REQUEST_TEMPLATE.md`

プルリクエストを作成すると、自動的にこのテンプレートが適用されます。

### 主なセクション

- **Description**: PR の目的と変更内容の説明
- **Key Changes**: 主要な変更点のリスト
- **Files Added/Modified**: 追加・修正されたファイルの説明
- **How to Test**: テスト手順
- **Benefits**: 変更による利点
- **Screenshots**: UI変更がある場合のスクリーンショット
- **Related Issues**: 関連するイシュー番号
- **Additional Notes**: レビュアーへの追加情報

### 使い方

1. GitHubでプルリクエストを作成
2. テンプレートが自動的に適用される
3. 各セクションを適切に記入
4. レビューを依頼

---

## 🐛 イシューテンプレート

`ISSUE_TEMPLATE/` ディレクトリには、3種類のイシューテンプレートがあります。

### 1. Bug Report (`bug_report.md`)

**使用ケース**: バグや予期しない動作を報告する場合

**主なセクション**:
- Description: バグの説明
- Steps to Reproduce: 再現手順
- Expected Behavior: 期待される動作
- Actual Behavior: 実際の動作
- Screenshots / Logs: スクリーンショットやログ
- Environment: 環境情報（OS, Flutter版, デバイス等）
- Additional Context: 追加情報

### 2. Feature Request (`feature_request.md`)

**使用ケース**: 新機能や改善を提案する場合

**主なセクション**:
- Description: 機能の説明
- Motivation: 必要性と利点
- Proposed Solution: 提案する解決策
- Alternatives Considered: 検討した代替案
- Additional Context: 追加情報

### 3. Refactor / Code Cleanup (`refactor_cleanup.md`)

**使用ケース**: リファクタリングやコードクリーンアップを提案する場合

**主なセクション**:
- Description: リファクタリング対象の説明
- Reason / Motivation: 必要性（可読性、パフォーマンス、保守性等）
- Proposed Changes: 変更内容の詳細
- Potential Risks: 潜在的なリスク
- Related Files / Modules: 影響を受けるファイル
- Testing Plan: テスト計画
- Additional Notes: 追加情報

### 使い方

1. GitHubで新しいイシューを作成
2. 「Get started」ボタンから適切なテンプレートを選択
3. テンプレートに従って情報を記入
4. ラベルが自動的に設定される

---

## 📝 テンプレート活用のベストプラクティス

### プルリクエスト作成時

✅ **推奨**:
- すべてのセクションを記入（該当しない場合は「N/A」と記載）
- 変更内容を明確に説明
- テスト手順を具体的に記載
- スクリーンショットを追加（UI変更の場合）
- 関連イシューをリンク

❌ **避けるべき**:
- セクションを空白のまま残す
- 曖昧な説明
- テスト手順の省略

### イシュー作成時

✅ **推奨**:
- 適切なテンプレートを選択
- 再現手順を詳細に記載（バグの場合）
- 環境情報を正確に記載
- スクリーンショットやログを添付

❌ **避けるべき**:
- テンプレートを使用しない
- 情報不足のイシュー
- 曖昧なタイトル

---

## 🏷️ 自動ラベル

各イシューテンプレートには、自動的に適用されるラベルが設定されています：

- **Bug Report**: `bug` ラベル
- **Feature Request**: `enhancement` ラベル
- **Refactor / Code Cleanup**: `refactor` ラベル

---

## 🔧 テンプレートのカスタマイズ

テンプレートは必要に応じてカスタマイズできます：

1. 該当するファイルを編集
2. セクションの追加・削除・変更
3. コミット & プッシュ

変更は次回のPR/イシュー作成時に反映されます。

---

## 📚 参考資料

- [GitHub Docs - About issue and pull request templates](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/about-issue-and-pull-request-templates)
- [プロジェクトREADME](../README.md)
- [Contributing Guidelines](../CONTRIBUTING.md) ※作成予定
