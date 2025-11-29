import 'package:flutter/material.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/src/constants/app_colors.dart';
import 'package:flutterhackthema/src/constants/app_text_styles.dart';

/// 投稿作成画面のプレースホルダー
///
/// NOTE: これは一時的なプレースホルダー実装です
///
/// Issue #8 完了後に以下へ移行:
/// - lib/features/post_creation/presentation/pages/create_post_page.dart
///
/// TODO(#8): Issue #8 完了後、このファイルを削除して
/// lib/features/post_creation/presentation/pages/create_post_page.dart に置き換える
///
/// 機能:
/// - 俳句の入力
/// - プレビュー画面への遷移
/// - 投稿一覧への戻る
class PlaceholderCreatePostPage extends StatelessWidget {
  /// [PlaceholderCreatePostPage] のコンストラクタ
  const PlaceholderCreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '投稿作成',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.adminPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            // 型安全なルーティング
            const PostsRoute().go(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // タイトル
              Text(
                '投稿作成画面',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),

              // 説明
              Text(
                'このページは準備中です\n\nIssue #13 で実装されます',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGray,
                ),
              ),
              const SizedBox(height: 32),

              // プレビュー画面へ遷移ボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 型安全なルーティング
                  const PreviewRoute(
                    firstLine: 'サンプル上の句',
                    secondLine: 'サンプル中の句',
                    thirdLine: 'サンプル下の句',
                    imageUrl: 'https://picsum.photos/400/500',
                  ).go(context);
                },
                icon: const Icon(Icons.preview),
                label: Text('プレビューへ', style: AppTextStyles.labelMedium),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 投稿一覧へ戻るボタン
              TextButton(
                onPressed: () {
                  // 型安全なルーティング
                  const PostsRoute().go(context);
                },
                child: Text(
                  '投稿一覧へ戻る',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.adminPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
