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
import 'package:uuid/uuid.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/haiku_save_notifier.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_generation_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/haiku_save_state.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_generation_state.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// UUID生成用のインスタンス
const _uuid = Uuid();

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
    final imageGenerationState = ref.watch(imageGenerationProvider);
    final saveState = ref.watch(haikuSaveProvider);

    // 画像データを取得
    final imageData = imageGenerationState.maybeWhen(
      success: (data) => data,
      orElse: () => null,
    );

    // 保存状態を監視してナビゲーション
    ref.listen<HaikuSaveState>(haikuSaveProvider, (previous, next) {
      next.when(
        initial: () {},
        savingToCache: (haiku) {},
        cachedLocally: (haiku, localImagePath) {
          // ローカル保存完了時にSnackBarを表示
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ローカルに保存しました'),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        savingToFirebase: (haiku, localImagePath) {},
        saved: (haiku, localImagePath, firebaseImageUrl) {
          // 完全保存完了時に成功メッセージを表示してリストページへ
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('俳句を投稿しました！'),
                backgroundColor: Colors.black,
              ),
            );
            ref.read(imageGenerationProvider.notifier).reset();
            ref.read(haikuSaveProvider.notifier).reset();
            const HaikuListRoute().go(context);
          }
        },
        error: (message, haiku, localImagePath) {
          // エラー時にダイアログを表示
          if (context.mounted) {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('保存エラー'),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('閉じる'),
                  ),
                ],
              ),
            );
          }
        },
      );
    });

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
        ref.read(haikuSaveProvider.notifier).reset();
        const HaikuListRoute().go(context);
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

    Future<void> handlePost() async {
      if (imageData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('画像データがありません'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // HaikuModelを作成
      final haiku = HaikuModel(
        id: _uuid.v4(),
        userId: 'anonymous', // TODO: 認証機能実装後にユーザーIDを取得
        imageUrl: '', // Firebase保存後に更新される
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
        createdAt: DateTime.now(),
      );

      // 俳句と画像を保存
      try {
        await ref.read(haikuSaveProvider.notifier).saveHaiku(haiku, imageData);
      } catch (e) {
        // エラーは ref.listen で処理される
      }
    }

    // 保存中かどうか
    final isSaving = saveState.isProcessing;
    final isCached = saveState.isCached;

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppSliverHeader(),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(
                  onPressed: () {
                    if (!isSaving) {
                      handleBack();
                    }
                  },
                ),
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
                  // 保存状態インジケーター
                  if (isSaving)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isCached ? 'Firebaseに保存中...' : 'ローカルに保存中...',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isSaving) const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppOutlinedButton(
                      label: '生成をやり直す',
                      leadingIcon: Icons.refresh,
                      onPressed: isSaving ? null : handleRegenerate,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppFilledButton(
                      label: isSaving ? '保存中...' : 'Mya句に投稿する',
                      onPressed: isSaving ? null : handlePost,
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
