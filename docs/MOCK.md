  ⎿  Plan saved to: ~/.claude/plans/dapper-orbiting-iverson.md · /plan to edit
     Plan: ワイヤーフレームに基づくFlutter UI実装

     概要

     docs/design/*.png のワイヤーフレーム画像に基づいて、Flutter UIを実装する。

     実装方針

     - 実装範囲: 全7画面のUI
     - データ: モック/ダミーデータを使用（Firebase連携なし）
     - 状態管理: Riverpod（ローカル状態のみ）

     現在の状況

     - 設計仕様書: docs/design/wireframe_design.md (v2.0) 完成済み
     - ワイヤーフレーム画像: 7枚
     - 既存コード: 基盤のみ（AppColors, AppTextStyles, AppGradients）
     - UI実装: なし（ページ、コンポーネントすべて未実装）

     実装対象画面（7画面）

     | #   | 画面名          | ルート                | ワイヤーフレーム       |
     |-----|--------------|--------------------|----------------|
     | 1   | ニックネーム入力画面   | /nickname          | ニックネーム入力.png   |
     | 2   | みんなの投稿一覧画面   | /posts             | みんなの投稿.png     |
     | 3   | 俳句入力画面       | /create            | 俳句入力.png       |
     | 4   | 画像生成ローディング画面 | /create/generating | 生成中....png     |
     | 5   | プレビュー・投稿確認画面 | /preview           | プレビュー 投稿する.png |
     | 6   | 詳細ページ        | /posts/:id         | 詳細ページ.png      |
     | 7   | 編集中に戻るダイアログ  | モーダル               | 編集中に戻る.png     |

     ---
     ディレクトリ構造

     Shared Layer（共通コンポーネント）

     lib/shared/
     ├── constants/                    # 既存のsrc/constantsを移動
     │   ├── app_colors.dart
     │   ├── app_text_styles.dart
     │   └── app_gradients.dart
     ├── presentation/
     │   └── widgets/
     │       ├── buttons/
     │       │   ├── primary_button.dart      # 黒背景、白文字
     │       │   ├── secondary_button.dart    # アウトライン
     │       │   ├── text_button.dart         # テキストのみ
     │       │   └── fab_button.dart          # FAB「+ 句を詠む」
     │       ├── inputs/
     │       │   └── app_text_field.dart      # 角丸、グレー背景
     │       ├── dialogs/
     │       │   └── confirm_dialog.dart      # 確認ダイアログ
     │       ├── navigation/
     │       │   ├── app_header.dart          # サービス名ヘッダー
     │       │   └── back_button.dart         # 「< TOPに戻る」
     │       ├── feedback/
     │       │   ├── loading_indicator.dart
     │       │   └── progress_bar.dart
     │       └── layout/
     │           └── vertical_text.dart       # 縦書きテキスト
     └── utilities/
         └── validators.dart

     Feature Layer（機能モジュール）

     lib/features/
     ├── nickname/                     # ニックネーム機能
     │   ├── presentation/
     │   │   ├── pages/
     │   │   │   └── nickname_page.dart
     │   │   ├── providers/
     │   │   │   └── nickname_provider.dart
     │   │   └── state/
     │   │       └── nickname_state.dart
     │   └── service/
     │       └── nickname_storage.dart
     │
     ├── posts/                        # 投稿一覧・詳細機能
     │   ├── data/
     │   │   └── models/
     │   │       └── post.dart
     │   ├── presentation/
     │   │   ├── pages/
     │   │   │   ├── posts_page.dart
     │   │   │   └── post_detail_page.dart
     │   │   ├── widgets/
     │   │   │   ├── post_card.dart
     │   │   │   └── staggered_grid.dart
     │   │   └── providers/
     │   │       └── posts_provider.dart
     │   └── service/
     │       └── share_service.dart    # SNS共有
     │
     └── haiku/                        # 俳句作成機能
         ├── presentation/
         │   ├── pages/
         │   │   ├── haiku_input_page.dart
         │   │   ├── generating_page.dart
         │   │   └── preview_page.dart
         │   ├── widgets/
         │   │   ├── haiku_preview.dart    # 縦書きプレビュー
         │   │   └── step_indicator.dart   # 3ステップインジケーター
         │   ├── providers/
         │   │   └── haiku_provider.dart
         │   └── state/
         │       └── haiku_state.dart
         └── service/
             └── haiku_validator.dart

     App Layer（ルーティング）

     lib/app/
     └── app_router/
         ├── app_router.dart           # 更新: 全ルート定義
         └── routes.dart

     ---
     実装順序

     Phase 1: 基盤整備

     1. lib/src/constants/ → lib/shared/constants/ に移動
     2. 共通ウィジェット作成:
       - PrimaryButton
       - SecondaryButton
       - AppTextField
       - AppHeader
       - BackButton
       - ConfirmDialog

     Phase 2: ニックネーム機能

     3. nickname_page.dart 実装
     4. nickname_provider.dart 実装（localStorage保存）
     5. ルーティング設定（/nickname）

     Phase 3: 投稿一覧機能

     6. Post モデル作成
     7. posts_page.dart 実装（Staggered Grid）
     8. post_card.dart 実装
     9. fab_button.dart 実装
     10. ルーティング設定（/posts）

     Phase 4: 俳句作成機能

     11. haiku_input_page.dart 実装（3ステップ）
     12. vertical_text.dart 実装（縦書き）
     13. step_indicator.dart 実装
     14. generating_page.dart 実装
     15. preview_page.dart 実装
     16. ルーティング設定（/create, /create/generating, /preview）

     Phase 5: 詳細ページ

     17. post_detail_page.dart 実装
     18. SNS共有ボタン実装
     19. いいね機能UI
     20. ルーティング設定（/posts/:id）

     ---
     作成ファイル一覧（優先度順）

     必須（Phase 1-3）

     | ファイル                                                          | 説明        |
     |---------------------------------------------------------------|-----------|
     | lib/shared/presentation/widgets/buttons/primary_button.dart   | 黒背景ボタン    |
     | lib/shared/presentation/widgets/buttons/secondary_button.dart | アウトラインボタン |
     | lib/shared/presentation/widgets/inputs/app_text_field.dart    | テキスト入力    |
     | lib/shared/presentation/widgets/navigation/app_header.dart    | ヘッダー      |
     | lib/shared/presentation/widgets/navigation/back_button.dart   | 戻るボタン     |
     | lib/shared/presentation/widgets/dialogs/confirm_dialog.dart   | 確認ダイアログ   |
     | lib/features/nickname/presentation/pages/nickname_page.dart   | ニックネーム画面  |
     | lib/features/posts/presentation/pages/posts_page.dart         | 投稿一覧画面    |

     重要（Phase 4-5）

     | ファイル                                                        | 説明      |
     |-------------------------------------------------------------|---------|
     | lib/shared/presentation/widgets/layout/vertical_text.dart   | 縦書きテキスト |
     | lib/features/haiku/presentation/pages/haiku_input_page.dart | 俳句入力画面  |
     | lib/features/haiku/presentation/pages/generating_page.dart  | 生成中画面   |
     | lib/features/haiku/presentation/pages/preview_page.dart     | プレビュー画面 |
     | lib/features/posts/presentation/pages/post_detail_page.dart | 詳細画面    |

     ---
     UIデザイン仕様（ワイヤーフレームより）

     カラー

     - Primary Button: 黒背景 (#000000)、白文字
     - Secondary Button: アウトライン、黒枠
     - TextField背景: グレー（AppColors.gray100相当）
     - 角丸: 大きめ（16-24px）

     コンポーネントスタイル

     // PrimaryButton
     ElevatedButton(
       style: ElevatedButton.styleFrom(
         backgroundColor: Colors.black,
         foregroundColor: Colors.white,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(24),
         ),
         minimumSize: Size(double.infinity, 56),
       ),
     )

     // AppTextField
     TextField(
       decoration: InputDecoration(
         filled: true,
         fillColor: Color(0xFFE8E8E8),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide: BorderSide.none,
         ),
       ),
     )

     ---
     テスト戦略

     Widget Tests

     - 各共通ウィジェットのテスト
     - ページレベルのUIテスト

     Unit Tests

     - Provider/State テスト
     - Validator テスト

     ---
     注意事項

     - 三層アーキテクチャを厳守（App → Feature → Shared）
     - Feature間の直接依存禁止
     - @riverpod アノテーションを使用
     - 日本語ドキュメントコメント必須
     - コード生成後に fvm flutter analyze 実行

     ---
     成果物

     - 7画面のFlutter UI実装
     - 共通UIコンポーネントライブラリ
     - ルーティング設定
     - Widget テスト