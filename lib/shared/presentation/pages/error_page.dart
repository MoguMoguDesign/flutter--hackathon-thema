import 'package:flutter/material.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/shared/constants/app_colors.dart';
import 'package:flutterhackthema/shared/constants/app_text_styles.dart';

/// エラー表示画面
///
/// 404エラーやルーティングエラーが発生した際に表示される画面
///
/// 機能:
/// - エラーアイコンの表示
/// - エラーメッセージの表示
/// - ホームへ戻るボタン
///
/// 使用例:
/// ```dart
/// GoRouter(
///   errorBuilder: (context, state) => ErrorPage(error: state.error),
/// )
/// ```
class ErrorPage extends StatelessWidget {
  /// エラー情報
  final Exception? error;

  /// [ErrorPage] のコンストラクタ
  ///
  /// [error] エラー情報（オプション）
  const ErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'エラー',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.error,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // エラーアイコン
              const Icon(Icons.error_outline, size: 80, color: AppColors.error),
              const SizedBox(height: 24),

              // エラータイトル
              Text(
                'ページが見つかりません',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // エラーメッセージ
              if (error != null)
                Text(
                  error.toString(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textGray,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              if (error != null) const SizedBox(height: 8),

              // 補足説明
              Text(
                'お探しのページは見つかりませんでした。\nURLをご確認いただくか、ホームに戻ってください。',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // ホームへ戻るボタン
              ElevatedButton.icon(
                onPressed: () {
                  // 型安全なルーティング
                  const NicknameRoute().go(context);
                },
                icon: const Icon(Icons.home),
                label: Text('ホームに戻る', style: AppTextStyles.labelMedium),
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
