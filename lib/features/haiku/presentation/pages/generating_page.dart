// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_generation_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_generation_state.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/feedback/progress_bar.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// AI画像生成中画面。
///
/// 俳句からAI画像を生成している間のローディング画面。
/// ワイヤーフレーム: `生成中....png`
class GeneratingPage extends HookConsumerWidget {
  /// 生成中画面を作成する。
  const GeneratingPage({
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

    // 画像生成を開始
    useEffect(() {
      // プロバイダーをリセットして新しい生成を開始
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(imageGenerationProvider.notifier)
            .generate(
              firstLine: firstLine,
              secondLine: secondLine,
              thirdLine: thirdLine,
            );
      });
      return null;
    }, []);

    // 状態変化を監視してナビゲーション
    ref.listen<ImageGenerationState>(imageGenerationProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: (_) {},
        success: (imageData) {
          if (context.mounted) {
            PreviewRoute(
              firstLine: firstLine,
              secondLine: secondLine,
              thirdLine: thirdLine,
            ).go(context);
          }
        },
        error: (_) {},
      );
    });

    // 進捗を取得
    final progress = state.when(
      initial: () => 0.0,
      loading: (p) => p,
      success: (_) => 1.0,
      error: (_) => 0.0,
    );

    // エラー状態かどうか
    final isError = state is ImageGenerationError;
    final errorMessage = state.maybeWhen(
      error: (message) => message,
      orElse: () => '',
    );

    Future<void> handleBack() async {
      final shouldLeave = await AppConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '生成を中断し、作成中の句は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '生成を続ける',
        isDangerous: true,
      );
      if (shouldLeave == true && context.mounted) {
        ref.read(imageGenerationProvider.notifier).reset();
        const PostsRoute().go(context);
      }
    }

    void handleRetry() {
      ref
          .read(imageGenerationProvider.notifier)
          .generate(
            firstLine: firstLine,
            secondLine: secondLine,
            thirdLine: thirdLine,
          );
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
                  const Spacer(),
                  Text(
                    isError ? 'エラーが発生しました' : '挿絵を生成中...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  if (isError) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: double.infinity,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: isError
                            ? _ErrorContent(onRetry: handleRetry)
                            : const _PulsingAnimation(),
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!isError)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AppProgressBar(progress: progress),
                    ),
                  if (isError)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AppFilledButton(
                        label: '再試行',
                        onPressed: handleRetry,
                      ),
                    ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// エラー時のコンテンツ
class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
        const SizedBox(height: 12),
        Text(
          '画像の生成に失敗しました',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

/// ローディングアニメーション
class _PulsingAnimation extends HookWidget {
  const _PulsingAnimation();

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1500),
    );

    useEffect(() {
      controller.repeat(reverse: true);
      return null;
    }, [controller]);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.3 + (controller.value * 0.7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.brush, size: 48, color: Colors.grey.shade500),
              const SizedBox(height: 12),
              Text(
                'AIが描いています...',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
            ],
          ),
        );
      },
    );
  }
}
