import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_generation_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_generation_state.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// プレビュー・投稿確認画面。
///
/// 生成された画像と俳句のプレビューを表示する。
/// 投稿の確認と投稿実行を行う。
class PreviewPage extends ConsumerWidget {
  /// プレビュー画面を作成する。
  const PreviewPage({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    super.key,
  });

  final String firstLine;
  final String secondLine;
  final String thirdLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGenerationProvider);

    // 画像データを取得
    final imageData = state.maybeWhen(
      success: (data) => data,
      orElse: () => null,
    );

    Future<void> handleBack() async {
      final shouldLeave = await AppConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '作成した画像は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '編集を続ける',
        isDangerous: true,
      );
      if (shouldLeave == true && context.mounted) {
        ref.read(imageGenerationProvider.notifier).reset();
        const PostsRoute().go(context);
      }
    }

    void handleRegenerate() {
      ref.read(imageGenerationProvider.notifier).reset();
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
      ref.read(imageGenerationProvider.notifier).reset();
      const PostsRoute().go(context);
    }

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppSliverHeader(),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(onPressed: handleBack),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 4 / 5, // 4:5 のアスペクト比
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: imageData != null
                                  ? Image.memory(
                                      imageData,
                                      fit: BoxFit.contain, // 画像全体を表示
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return _ImageErrorWidget();
                                          },
                                    )
                                  : _ImageErrorWidget(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppOutlinedButton(
                      label: '生成をやり直す',
                      leadingIcon: Icons.refresh,
                      onPressed: handleRegenerate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppFilledButton(
                      label: 'Mya句に投稿する',
                      onPressed: handlePost,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 画像読み込みエラー時のウィジェット
class _ImageErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            '画像を表示できませんでした',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
