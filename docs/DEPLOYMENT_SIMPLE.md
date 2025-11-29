# シンプルなVercelデプロイ手順

GitHub Actionsが失敗する場合は、以下の手動デプロイ方法を試してください。

## 方法1: Vercel CLI（推奨）

### 1. Vercel CLIをインストール

```bash
npm install -g vercel
```

### 2. ログイン

```bash
vercel login
```

### 3. Flutterアプリをビルド

```bash
# ビルド
make build-web-release

# または
fvm flutter build web --release --web-renderer canvaskit
```

### 4. Vercelにデプロイ

```bash
# 初回デプロイ（プロジェクトの設定）
cd build/web
vercel

# プロダクションデプロイ
vercel --prod
```

## 方法2: Vercel Dashboard（最も簡単）

### 1. build/webディレクトリをZIPで圧縮

```bash
cd build/web
zip -r vercel-deploy.zip .
```

### 2. Vercelダッシュボードからアップロード

1. [Vercel Dashboard](https://vercel.com/dashboard)にアクセス
2. 「Add New Project」をクリック
3. 「Deploy」タブで ZIPファイルをドラッグ&ドロップ

## 方法3: GitHub統合（自動デプロイ）

GitHub Actionsを使わず、Vercelの組み込みGitHub統合を使用します。

### 1. Vercelでプロジェクト作成

1. [Vercel Dashboard](https://vercel.com/dashboard)にアクセス
2. 「Add New Project」→ 「Import Git Repository」
3. GitHubリポジトリを選択

### 2. ビルド設定

- **Framework Preset**: Other
- **Build Command**: 空欄（ビルドしない）
- **Output Directory**: `build/web`
- **Install Command**: 空欄

### 3. GitHub Actionsでビルドのみ実行

`.github/workflows/build-only.yml` を作成：

```yaml
name: Build Flutter Web

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup FVM
        uses: kuhnroyal/flutter-fvm-config-action@v2
        id: fvm-config-action

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ steps.fvm-config-action.outputs.FLUTTER_VERSION }}
          channel: ${{ steps.fvm-config-action.outputs.FLUTTER_CHANNEL }}
          cache: true

      - name: Get dependencies
        run: flutter pub get

      - name: Generate code
        run: flutter pub run build_runner build --delete-conflicting-outputs

      - name: Build Web
        run: flutter build web --release --web-renderer canvaskit

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

その後、VercelでGitHub Pagesブランチをデプロイソースとして設定。

## トラブルシューティング

### エラー: "VERCEL_TOKEN not found"

GitHub Secretsを設定してください：
1. GitHub リポジトリ → Settings → Secrets and variables → Actions
2. 必要なシークレット：
   - `VERCEL_TOKEN`
   - `VERCEL_ORG_ID`
   - `VERCEL_PROJECT_ID`

### エラー: "Build timed out"

Flutterのビルドに時間がかかりすぎている場合：
- ローカルでビルドしてから手動デプロイ（方法1または2）
- Vercelのタイムアウト設定を増やす（Pro プラン）

### 画面が真っ白

`web/index.html`の`<base href="/">`を確認してください。

## 推奨フロー

開発中は**方法1（Vercel CLI）**が最も簡単で確実です：

```bash
# 1. ビルド
make build-web-release

# 2. デプロイ
cd build/web && vercel --prod
```

本番環境では、GitHub Actionsが安定したら自動デプロイに切り替えてください。

