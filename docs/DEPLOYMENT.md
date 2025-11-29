# デプロイ手順

## Vercelへのデプロイ

このプロジェクトはVercelに自動デプロイされるよう設定されています。

### 初回セットアップ

#### 1. Vercelプロジェクトの作成

1. [Vercel](https://vercel.com)にログイン
2. 「Add New Project」をクリック
3. GitHubリポジトリを選択
4. プロジェクト名を設定
5. Framework Presetは「Other」を選択
6. 「Deploy」をクリック（初回は失敗してOK）

#### 2. Vercel CLIでトークンを取得

```bash
npm i -g vercel
vercel login
vercel link
```

このコマンドで以下の情報が表示されます：
- `VERCEL_ORG_ID`
- `VERCEL_PROJECT_ID`

または、Vercelのダッシュボードから取得：
1. プロジェクト設定 → General
2. Project ID をコピー
3. Settings → Tokens で新しいトークンを作成

#### 3. GitHub Secretsの設定

GitHubリポジトリの Settings → Secrets and variables → Actions で以下を追加：

- `VERCEL_TOKEN`: Vercelのアクセストークン
- `VERCEL_ORG_ID`: VercelのOrganization ID (Team IDとも呼ばれる)
- `VERCEL_PROJECT_ID`: VercelのProject ID

**取得方法:**

```bash
# Vercel CLIでログイン
vercel login

# プロジェクトをリンク
vercel link

# .vercel/project.json に ID が保存される
cat .vercel/project.json
```

または、Vercelダッシュボードから：
- Settings → General → Project ID
- Settings → Tokens → Create Token

#### 4. 自動デプロイの確認

`main`ブランチにプッシュすると、自動的にデプロイされます。

### 手動デプロイ

GitHub Actionsから手動でデプロイすることもできます：

1. GitHubリポジトリの「Actions」タブ
2. 「Deploy to Vercel」ワークフローを選択
3. 「Run workflow」をクリック

### ローカルでのビルド確認

```bash
# Webビルド
make build-web

# または
fvm flutter build web --release

# ローカルでプレビュー
cd build/web
python3 -m http.server 8000
# http://localhost:8000 でアクセス
```

### デプロイの仕組み

1. **ビルド**: GitHub ActionsでFlutter Webをビルド (`build/web/`)
2. **デプロイ**: Vercel CLIで`build/web/`ディレクトリをVercelにデプロイ
3. **最適化**: 
   - CanvasKitレンダラー使用（高品質な描画）
   - アセットのキャッシュ設定（1年）
   - SPA用のリライト設定

### トラブルシューティング

#### デプロイが失敗する場合

1. **GitHub Secretsの確認**
   ```
   VERCEL_TOKEN
   VERCEL_ORG_ID
   VERCEL_PROJECT_ID
   ```
   が正しく設定されているか確認

2. **Vercelプロジェクトの確認**
   - プロジェクトが存在するか
   - リポジトリが正しくリンクされているか

3. **ビルドログの確認**
   - GitHub Actionsのログを確認
   - エラーメッセージをチェック

#### 画面が真っ白になる場合

`index.html`の`base href`を確認：
```html
<base href="/">
```

または、ビルドコマンドに`--base-href`オプションを追加：
```bash
flutter build web --release --base-href=/
```

### その他のデプロイ先

#### Firebase Hosting

```bash
# Firebase CLIインストール
npm install -g firebase-tools

# ログイン
firebase login

# 初期化
firebase init hosting

# デプロイ
firebase deploy --only hosting
```

#### GitHub Pages

`.github/workflows/deploy-gh-pages.yml` を作成して、GitHub Pagesにデプロイすることも可能です。

### 参考リンク

- [Vercel Documentation](https://vercel.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [GitHub Actions for Flutter](https://github.com/marketplace/actions/flutter-action)

