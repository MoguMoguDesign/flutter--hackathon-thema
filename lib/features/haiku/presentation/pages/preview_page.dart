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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
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

    // 画像データを取得
    final imageData = generationState.maybeWhen(
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

    void handlePost() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('投稿しました！'), backgroundColor: Colors.black),
      );
      ref.read(imageGenerationProvider.notifier).reset();
      ref.read(imageSaveProvider.notifier).reset();
      const HaikuListRoute().go(context);
    }

    Future<void> handleSave() async {
      if (imageData == null) return;

      final url = await ref
          .read(imageSaveProvider.notifier)
          .saveImage(
            imageData: imageData,
            firstLine: firstLine,
            secondLine: secondLine,
            thirdLine: thirdLine,
          );

      if (url != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('画像を保存しました'),
            backgroundColor: Colors.green,
          ),
        );
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
                  _SaveButtonSection(
                    saveState: saveState,
                    imageData: imageData,
                    onSave: handleSave,
                  ),
                  const SizedBox(height: 12),
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

/// 画像保存ボタンセクション
///
/// 保存状態に応じてボタン、ローディング、成功、エラー表示を切り替える。
class _SaveButtonSection extends StatelessWidget {
  const _SaveButtonSection({
    required this.saveState,
    required this.imageData,
    required this.onSave,
  });

  final ImageSaveState saveState;
  final Uint8List? imageData;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return saveState.when(
      initial: () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AppOutlinedButton(
          label: '画像を保存',
          leadingIcon: Icons.save,
          onPressed: imageData != null ? onSave : null,
        ),
      ),
      saving: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      success: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade600),
            const SizedBox(width: 8),
            Text(
              '保存済み',
              style: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      error: (message) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(color: Colors.red.shade600, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppOutlinedButton(
              label: '再試行',
              leadingIcon: Icons.refresh,
              onPressed: onSave,
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
