# FVM セットアップ完了

## ✅ 実施内容

このプロジェクトはFVM（Flutter Version Management）で管理されています。

### 1. 設定ファイル

#### `.fvm/fvm_config.json`
```json
{
  "flutterSdkVersion": "stable"
}
```
- **Flutter バージョン**: stable チャンネル（現在 3.35.1）
- チーム全体で同じバージョンを使用するため、このファイルはgit管理されています

#### `.gitignore`
```gitignore
# FVM Version Manager
.fvm/flutter_sdk
```
- シンボリックリンクはgitから除外
- 設定ファイル（`fvm_config.json`）のみをコミット

### 2. VS Code設定

#### `.vscode/settings.json`
```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk",
  "search.exclude": {
    "**/.fvm": true
  },
  "files.watcherExclude": {
    "**/.fvm": true
  }
}
```

これにより、VS CodeはFVM管理下のFlutter SDKを自動的に使用します。

### 3. ディレクトリ構造

```
.fvm/
├── flutter_sdk -> /Users/ookuboitsuki/fvm/versions/stable (シンボリックリンク)
└── fvm_config.json (git管理)
```

## 🚀 使用方法

### 基本コマンド

FVMを使用する場合、すべてのFlutterコマンドの前に`fvm`をつけます：

```bash
# Flutter SDKバージョン確認
fvm flutter --version

# 依存関係のインストール
fvm flutter pub get

# アプリの実行
fvm flutter run

# ビルド
fvm flutter build

# テスト実行
fvm flutter test

# コード生成
fvm dart run build_runner build --delete-conflicting-outputs

# 分析
fvm flutter analyze
```

### 便利なエイリアス（任意）

シェル設定ファイル（`.zshrc`や`.bashrc`）に追加すると便利：

```bash
alias fl="fvm flutter"
alias dr="fvm dart"
```

これで`fl pub get`のように短縮できます。

## 📝 FVM管理コマンド

### バージョン確認

```bash
# インストール済みのFlutterバージョン一覧
fvm list

# 利用可能なFlutterバージョン一覧
fvm releases

# プロジェクトの設定確認
fvm doctor
```

### バージョン切り替え

```bash
# 別のバージョンをインストール（例）
fvm install 3.27.0

# プロジェクトのバージョンを変更
fvm use 3.27.0

# グローバルデフォルトを設定
fvm global stable
```

## 👥 チーム開発での使用

### 新しいメンバーの初期セットアップ

1. **FVMのインストール**（まだの場合）
   ```bash
   # Homebrewの場合
   brew tap leoafarias/fvm
   brew install fvm

   # Dartの場合
   dart pub global activate fvm
   ```

2. **プロジェクトのクローン**
   ```bash
   git clone <repository-url>
   cd flutter--hackathon-thema
   ```

3. **Flutter SDKのインストール**
   ```bash
   # .fvm/fvm_config.jsonに基づいて自動インストール
   fvm install

   # または
   fvm use stable
   ```

4. **依存関係のインストール**
   ```bash
   fvm flutter pub get
   ```

これで、全メンバーが同じFlutterバージョンで開発できます！

## 🔧 トラブルシューティング

### VS Codeが正しいSDKを認識しない

1. VS Codeを再起動
2. コマンドパレット（Cmd+Shift+P）→ "Dart: Capture Debugging Logs"
3. 設定を確認：`.vscode/settings.json`の`dart.flutterSdkPath`が正しいか

### シンボリックリンクが壊れている

```bash
# 再作成
rm .fvm/flutter_sdk
fvm use stable
```

### どのFlutterが使われているか確認

```bash
which flutter          # システムのFlutter
fvm which flutter      # FVM管理下のFlutter
fvm flutter --version  # FVMで実行
```

## 📚 参考資料

- [FVM公式ドキュメント](https://fvm.app/)
- [参考記事: Flutter Version Management](https://zenn.dev/altiveinc/articles/flutter-version-management)
- [FVM GitHub](https://github.com/leoafarias/fvm)

## ⚡ ベストプラクティス

1. **常に`fvm`プレフィックスを使用**: コマンド実行時は必ず`fvm flutter`を使う
2. **バージョン固定推奨**: チームで開発する場合は特定バージョン（例: `3.27.0`）を指定すると安定
3. **CI/CDでも使用**: GitHub ActionsなどでもFVMを使うことで、開発環境と本番環境の一貫性を保つ
4. **定期的なアップデート**: stableチャンネルの更新を定期的にチェック

## 🎯 現在の設定

- **Flutter Version**: 3.35.1（stable channel）
- **Dart Version**: 3.9.0
- **管理方法**: FVM
- **IDE**: VS Code（設定済み）
