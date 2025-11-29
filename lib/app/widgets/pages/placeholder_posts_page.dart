import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/src/constants/app_colors.dart';
import 'package:flutterhackthema/src/constants/app_text_styles.dart';

/// 投稿一覧画面のプレースホルダー
///
/// NOTE: これは一時的なプレースホルダー実装です
///
/// Issue #8 完了後に以下へ移行:
/// - lib/features/posts/presentation/pages/posts_page.dart
///
/// TODO(#8): Issue #8 完了後、このファイルを削除して
/// lib/features/posts/presentation/pages/posts_page.dart に置き換える
///
/// 機能:
/// - 投稿一覧の表示
/// - 投稿作成画面への遷移ボタン
class PlaceholderPostsPage extends StatelessWidget {
  /// [PlaceholderPostsPage] のコンストラクタ
  const PlaceholderPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '投稿一覧',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.adminPrimary,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // タイトル
              Text(
                '投稿一覧画面',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),

              // 説明
              Text(
                'このページは準備中です\n\nIssue #12 で実装されます',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGray,
                ),
              ),
              const SizedBox(height: 32),

              // 投稿作成画面へ遷移ボタン
              ElevatedButton.icon(
                onPressed: () {
                  context.go(Routes.create);
                },
                icon: const Icon(Icons.add),
                label: Text('投稿作成へ', style: AppTextStyles.labelMedium),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
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
