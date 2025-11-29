import 'package:flutter/material.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/shared/presentation/widgets/buttons/primary_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/buttons/secondary_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/dialogs/confirm_dialog.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/app_header.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/back_button.dart';

/// プレビュー・投稿確認画面。
class PreviewPage extends StatelessWidget {
  const PreviewPage({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.imageUrl,
    super.key,
  });

  final String firstLine;
  final String secondLine;
  final String thirdLine;
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
        const PostsRoute().go(context);
      }
    }

    void handleRegenerate() {
      GeneratingRoute(
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
      ).go(context);
    }

    void handlePost() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('投稿しました！'), backgroundColor: Colors.black),
      );
      const PostsRoute().go(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(onPressed: handleBack),
            ),
            const SizedBox(height: 16),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SecondaryButton(
                text: '生成をやり直す',
                icon: Icons.refresh,
                onPressed: handleRegenerate,
              ),
            ),
            const SizedBox(height: 12),
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
