# Flutter Hack Theme

TCGマッチマネージャーのコンポーネントテストページとテーマコンポーネントをまとめたFlutterプロジェクトです。

## 概要

このプロジェクトには、以下のコンポーネントが含まれています：

### UIコンポーネント

- **ボタン**: CommonConfirmButton, CommonSmallButton, ButtonIcon
- **入力フィールド**: FigmaTextField, PasswordTextField, SearchTextField, DropdownSelectField
- **ダイアログ**: ConfirmDialog, DialogButtons
- **カード**: TournamentTitleCard, MatchCard, RankingCard
- **コンテナ**: PlayerContainer, PlayersContainer, VSContainer, MatchStatusContainer
- **リスト**: MatchList, RankingContainer, ResultContainer
- **その他**: TableNumberColumn, RoundChangeButtonRow

### テーマ定義

- **カラー**: AppColors - 全体的なカラーパレット
- **テキストスタイル**: AppTextStyles - M PLUS 1pフォントを使用した統一されたタイポグラフィ
- **グラデーション**: AppGradients - 背景グラデーション

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
├── base_ui.dart               # UIコンポーネントのエクスポート
├── main.dart                  # アプリのエントリーポイント
└── src/
    ├── component_test_page.dart  # コンポーネントテストページ
    ├── constants/
    │   ├── app_colors.dart       # カラー定義
    │   ├── app_text_styles.dart  # テキストスタイル定義
    │   └── app_gradients.dart    # グラデーション定義
    ├── models/
    │   └── ranking.dart          # ランキングモデル
    └── widgets/                  # UIコンポーネント
```

## 使用技術

- Flutter SDK ^3.9.2
- Google Fonts (M PLUS 1p)
- Flutter SVG

## ライセンス

このプロジェクトはプライベートプロジェクトです。
