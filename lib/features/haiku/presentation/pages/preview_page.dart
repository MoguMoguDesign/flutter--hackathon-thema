import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/widgets/buttons/primary_button.dart';
import '../../../../shared/presentation/widgets/buttons/secondary_button.dart';
import '../../../../shared/presentation/widgets/dialogs/confirm_dialog.dart';
import '../../../../shared/presentation/widgets/navigation/app_header.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// プレビュー・投稿確認画面。
///
/// 生成された画像をプレビューし、投稿または再生成を選択する。
/// ワイヤーフレーム: `プレビュー 投稿する.png`
class PreviewPage extends StatelessWidget {
  /// プレビュー画面を作成する。
  ///
  /// [firstLine] は上の句。
  /// [secondLine] は中の句。
  /// [thirdLine] は下の句。
  /// [imageUrl] は生成された画像のURL。
  const PreviewPage({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.imageUrl,
    super.key,
  });

  /// 上の句
  final String firstLine;

  /// 中の句
  final String secondLine;

  /// 下の句
  final String thirdLine;

  /// 生成された画像のURL
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Future<void> handleBack() async {
      final shouldLeave = await ConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '作成した画像は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '編集を続ける',
      );
      if (shouldLeave && context.mounted) {
        context.go('/posts');
      }
    }

    void handleRegenerate() {
      // 再生成: 生成中画面に戻る
      context.go(
        '/create/generating',
        extra: {
          'firstLine': firstLine,
          'secondLine': secondLine,
          'thirdLine': thirdLine,
        },
      );
    }

    void handlePost() {
      // モック: 投稿完了として投稿一覧に戻る
      // 実際の実装ではFirestoreに保存する
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('投稿しました！'), backgroundColor: Colors.black),
      );
      context.go('/posts');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー
            const AppHeader(serviceName: 'サービス名'),
            // 戻るボタン
            Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(onPressed: handleBack),
            ),
            const SizedBox(height: 16),
            // 画像プレビュー
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            color: Colors.grey,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '画像を読み込めませんでした',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 再生成ボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SecondaryButton(
                text: '生成をやり直す',
                icon: Icons.refresh,
                onPressed: handleRegenerate,
              ),
            ),
            const SizedBox(height: 12),
            // 投稿ボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(text: 'Mya句に投稿する', onPressed: handlePost),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
