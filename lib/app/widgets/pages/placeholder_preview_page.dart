import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/src/constants/app_colors.dart';
import 'package:flutterhackthema/src/constants/app_text_styles.dart';

/// プレビュー画面のプレースホルダー
///
/// NOTE: これは一時的なプレースホルダー実装です
///
/// Issue #8 完了後に以下へ移行:
/// - lib/features/post_creation/presentation/pages/preview_page.dart
///
/// TODO(#8): Issue #8 完了後、このファイルを削除して
/// lib/features/post_creation/presentation/pages/preview_page.dart に置き換える
///
/// 機能:
/// - 投稿のプレビュー表示
/// - 投稿確定
/// - 投稿作成画面への戻る
class PlaceholderPreviewPage extends StatelessWidget {
  /// [PlaceholderPreviewPage] のコンストラクタ
  const PlaceholderPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'プレビュー',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.adminPrimary,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            context.go(Routes.create);
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
                'プレビュー画面',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),

              // 説明
              Text(
                'このページは準備中です\n\nIssue #15 で実装されます',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGray,
                ),
              ),
              const SizedBox(height: 32),

              // 投稿ボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 投稿完了後、投稿一覧へ遷移
                  context.go(Routes.posts);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('投稿しました（プレースホルダー）')),
                  );
                },
                icon: const Icon(Icons.send),
                label: Text('投稿する', style: AppTextStyles.labelMedium),
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

              // 投稿作成へ戻るボタン
              TextButton(
                onPressed: () {
                  context.go(Routes.create);
                },
                child: Text(
                  '編集に戻る',
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
