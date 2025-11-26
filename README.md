# Flutter Hack Theme

TCGマッチマネージャーとMy GourmetのコンポーネントテストページをまとめたFlutterプロジェクトです。

## 概要

このプロジェクトは2つのプロジェクトからUIコンポーネントを抽出し、テストページで確認できるようにしています。

### ホームページ

初期画面では2つのテストページへの遷移ボタンが表示されます：
- **TCG Match Manager**: TCGマッチマネージャーのUIコンポーネント
- **My Gourmet**: My GourmetアプリのUIコンポーネント

---

## TCG Match Manager コンポーネント

### UIコンポーネント

- **ボタン**: CommonConfirmButton, CommonSmallButton, ButtonIcon
- **入力フィールド**: FigmaTextField, PasswordTextField, SearchTextField, DropdownSelectField
- **ダイアログ**: ConfirmDialog, DialogButtons
- **カード**: TournamentTitleCard, MatchCard, RankingCard
- **コンテナ**: PlayerContainer, PlayersContainer, VSContainer, MatchStatusContainer
- **リスト**: MatchList, RankingContainer, ResultContainer
- **その他**: TableNumberColumn, RoundChangeButtonRow

### テーマ定義

- **カラー**: AppColors - TCGマッチマネージャーのカラーパレット
- **テキストスタイル**: AppTextStyles - M PLUS 1pフォント (Google Fonts)
- **グラデーション**: AppGradients - 背景グラデーション

---

## My Gourmet コンポーネント

### UIコンポーネント

- **ボタン**: AppElevatedButton - カスタムスタイルの立体的なボタン
- **ダイアログ**: AppDialog - 確認用ダイアログ
- **カード**: GuruMemoCard - カスタムボーダー付きカード
- **通知**: AppSnackBar - 共通スナックバー

### テーマ定義

- **カラー**: Themes.mainOrange, Themes.gray, errorAlertColor
- **フォント**: Zenkaku Gothic New

## セットアップ

### 依存関係のインストール

```bash
flutter pub get
```

### 実行

```bash
flutter run
```

## プロジェクト構造

```
lib/
├── base_ui.dart                  # TCG Match Manager UIエクスポート
├── gourmet_ui.dart               # My Gourmet UIエクスポート
├── main.dart                     # アプリのエントリーポイント
└── src/
    ├── home_page.dart            # ホームページ（初期画面）
    ├── component_test_page.dart  # TCG Match Managerテストページ
    ├── constants/                # TCG Match Manager定義
    │   ├── app_colors.dart
    │   ├── app_text_styles.dart
    │   └── app_gradients.dart
    ├── models/                   # データモデル
    │   └── ranking.dart
    ├── widgets/                  # TCG Match Managerウィジェット
    └── gourmet/                  # My Gourmet関連（完全に別フォルダ）
        ├── gourmet_component_test_page.dart  # My Gourmetテストページ
        ├── constants/
        │   ├── themes.dart
        │   ├── constants.dart
        │   └── build_context_extension.dart
        └── widgets/
            ├── app_elevated_button.dart
            ├── app_dialog.dart
            ├── app_snack_bar.dart
            └── cards/
                └── guru_memo_card.dart
```

## 使用技術

- Flutter SDK ^3.9.2
- Google Fonts (M PLUS 1p for TCG Match Manager)
- Flutter SVG
- Flutter Hooks (My Gourmet用)
- Gap (My Gourmet用)

## 画面遷移

1. **ホームページ** (`HomePage`)
   - 初期画面として表示
   - 2つのボタンで各テストページへ遷移

2. **TCG Match Managerテストページ** (`ComponentTestPage`)
   - TCGマッチマネージャーの全UIコンポーネントを表示
   - `/tcg-components` ルート

3. **My Gourmetテストページ** (`GourmetComponentTestPage`)
   - My Gourmetアプリの全UIコンポーネントを表示
   - `/gourmet-components` ルート

## 特徴

- ✅ 2つのプロジェクトのコンポーネントを完全に分離
- ✅ 初期ページから簡単に各テストページへアクセス
- ✅ それぞれ独自のテーマとスタイルを保持
- ✅ エラーなしで動作（`flutter analyze`通過）

## ライセンス

このプロジェクトはプライベートプロジェクトです。
