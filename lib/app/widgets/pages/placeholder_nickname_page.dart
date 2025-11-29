import 'package:flutter/material.dart';
import 'package:flutterhackthema/app/app_di/nickname_provider.dart';
import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/shared/constants/app_colors.dart';
import 'package:flutterhackthema/shared/constants/app_text_styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ニックネーム入力画面のプレースホルダー
///
/// NOTE: これは一時的なプレースホルダー実装です
///
/// Issue #8 完了済み: 三層アーキテクチャ基盤が整備されました
/// 移行先: lib/features/nickname/presentation/pages/nickname_page.dart
///
/// TODO(#10): ニックネーム機能を実装し、このプレースホルダーを削除して
/// lib/features/nickname/presentation/pages/nickname_page.dart に置き換える
///
/// 機能:
/// - ニックネームの入力
/// - 入力後に投稿一覧画面へ遷移
class PlaceholderNicknamePage extends ConsumerWidget {
  /// [PlaceholderNicknamePage] のコンストラクタ
  const PlaceholderNicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ニックネーム入力',
          style: AppTextStyles.labelLarge.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.adminPrimary,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // タイトル
              Text(
                'ニックネーム入力画面',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 16),

              // 説明
              Text(
                'このページは準備中です\n\nIssue #10 で実装されます',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGray,
                ),
              ),
              const SizedBox(height: 32),

              // 一時的なニックネーム入力フィールド
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'ニックネームを入力',
                  border: OutlineInputBorder(),
                  hintText: '例: ユーザー太郎',
                ),
              ),
              const SizedBox(height: 16),

              // 投稿一覧へ遷移ボタン
              ElevatedButton(
                onPressed: () {
                  final nickname = controller.text.trim();
                  if (nickname.isNotEmpty) {
                    // ニックネームを設定
                    ref
                        .read(temporaryNicknameProvider.notifier)
                        .setNickname(nickname);

                    // 投稿一覧画面へ遷移（型安全なルーティング）
                    const PostsRoute().go(context);
                  } else {
                    // エラー表示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ニックネームを入力してください')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.adminPrimary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: Text('投稿一覧へ', style: AppTextStyles.labelMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
