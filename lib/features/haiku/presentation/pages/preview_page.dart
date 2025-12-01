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
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/haiku_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_generation_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_save_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_generation_state.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_save_state.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// プレビュー・投稿確認画面。
///
/// 生成された画像と俳句のプレビューを表示する。
/// 投稿の確認と投稿実行を行う。
/// Firebase Storageへの画像保存機能を提供する。
class PreviewPage extends ConsumerWidget {
  /// プレビュー画面を作成する。
  const PreviewPage({
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    super.key,
  });

  /// 上の句
  final String firstLine;

  /// 中の句
  final String secondLine;

  /// 下の句
  final String thirdLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generationState = ref.watch(imageGenerationProvider);
    final saveState = ref.watch(imageSaveProvider);

    // 画像URLを取得 (Firebase Storageに既に保存済み)
    final imageUrl = switch (generationState) {
      ImageGenerationSuccess(:final imageUrl) => imageUrl,
      _ => null,
    };

    // 投稿処理中かどうか
    final bool isPosting = switch (saveState) {
      ImageSaveSaving() => true,
      _ => false,
    };

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
        ref.read(imageSaveProvider.notifier).reset();
        const HaikuListRoute().go(context);
      }
    }

    void handleRegenerate() {
      ref.read(imageGenerationProvider.notifier).reset();
      ref.read(imageSaveProvider.notifier).reset();
      GeneratingRoute(
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
      ).go(context);
    }

    /// 俳句を投稿する
    ///
    /// Firebase Functionsで画像は既にStorageに保存済みのため、
    /// Firestoreに俳句データを保存して一覧画面に遷移する。
    Future<void> handlePost() async {
      if (imageUrl == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('画像データがありません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // async操作前にnotifier参照を取得（disposeエラー回避）
      final imageSaveNotifier = ref.read(imageSaveProvider.notifier);
      final haikuNotifier = ref.read(haikuProvider.notifier);
      final imageGenNotifier = ref.read(imageGenerationProvider.notifier);

      // 投稿状態を設定
      imageSaveNotifier.setPosting();

      // Firestoreに俳句データを保存
      // (画像はFunctions側で既にStorageに保存済み)
      try {
        await haikuNotifier.saveHaiku(
          firstLine: firstLine,
          secondLine: secondLine,
          thirdLine: thirdLine,
          imageUrl: imageUrl,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('投稿しました!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('投稿に失敗しました: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
        imageSaveNotifier.reset();
        return;
      }

      // 状態をリセットして一覧画面に遷移
      imageGenNotifier.reset();
      imageSaveNotifier.reset();
      if (context.mounted) {
        const HaikuListRoute().go(context);
      }
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
                              child: imageUrl != null
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.contain,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
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
                      onPressed: isPosting ? null : handleRegenerate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: isPosting
                        ? const _PostingIndicator()
                        : AppFilledButton(
                            label: 'Mya句に投稿する',
                            onPressed: imageUrl != null ? handlePost : null,
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

/// 投稿中インジケーター
///
/// 投稿処理中に表示されるローディングインジケーター。
class _PostingIndicator extends StatelessWidget {
  const _PostingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text(
            '投稿中...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
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
