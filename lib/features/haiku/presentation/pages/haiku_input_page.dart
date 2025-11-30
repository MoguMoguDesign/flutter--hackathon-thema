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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/inputs/app_text_field.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';
import '../widgets/haiku_hint_dialog.dart';
import '../widgets/haiku_preview.dart';
import '../widgets/step_indicator.dart';

/// 俳句入力画面。
///
/// 俳句を4ステップ形式で入力し、AI画像生成をリクエストする。
/// ワイヤーフレーム: `俳句入力.png`
class HaikuInputPage extends HookConsumerWidget {
  /// 俳句入力画面を作成する。
  const HaikuInputPage({super.key});

  static const List<String> _stepLabels = ['上五', '中七', '下五', '確認'];
  static const List<String> _stepHints = ['上五を入力', '中七を入力', '下五を入力', ''];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = useState(0);
    final firstLine = useState('');
    final secondLine = useState('');
    final thirdLine = useState('');
    final inputController = useTextEditingController();
    final currentInputText = useState('');
    final isValid = useState(false);

    useEffect(() {
      void listener() {
        final text = inputController.text.trim();
        currentInputText.value = inputController.text;
        isValid.value = text.isNotEmpty && text.length <= 10;
      }

      inputController.addListener(listener);
      return () => inputController.removeListener(listener);
    }, [inputController]);

    Future<void> handleBack() async {
      final shouldLeave = await AppConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '作成中の句は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '編集を続ける',
        isDangerous: true,
      );
      if (shouldLeave == true && context.mounted) {
        const HaikuListRoute().go(context);
      }
    }

    void handleShowHint() {
      HaikuHintDialog.show(
        context: context,
        title: '季語のヒント',
        hints: const [
          '🌸 春: 桜・つばめ・霞・朧月・春風',
          '🌻 夏: 蛍・入道雲・夕立・蝉・青葉',
          '🍁 秋: 紅葉・虫・月・稲穂・秋風',
          '⛄️ 冬: 雪・霜・冬星・炬燵・寒月',
          '💡 5・7・5のリズムで詠む',
          '🎨 心に浮かんだ情景を描く',
          '✨ 季節の風物詩を入れる',
        ],
        closeText: '閉じる',
      );
    }

    void handleNext() {
      final text = inputController.text.trim();
      if (text.isEmpty) return;

      // 現在のステップの値を保存
      switch (currentStep.value) {
        case 0:
          firstLine.value = text;
        case 1:
          secondLine.value = text;
        case 2:
          thirdLine.value = text;
      }

      if (currentStep.value < 3) {
        // 次のステップへ
        currentStep.value++;
        inputController.clear();
        currentInputText.value = '';
        isValid.value = false;
      }
    }

    void handlePreviousStep() {
      if (currentStep.value > 0) {
        currentStep.value--;
        // 前のステップの値を復元
        switch (currentStep.value) {
          case 0:
            inputController.text = firstLine.value;
            currentInputText.value = firstLine.value;
          case 1:
            inputController.text = secondLine.value;
            currentInputText.value = secondLine.value;
          case 2:
            inputController.text = thirdLine.value;
            currentInputText.value = thirdLine.value;
        }
      }
    }

    void handleGenerate() {
      // 画面遷移のみ（Firestore保存はPreviewPageで行う）
      GeneratingRoute(
        firstLine: firstLine.value,
        secondLine: secondLine.value,
        thirdLine: thirdLine.value,
      ).go(context);
    }

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ヘッダー
            AppSliverHeader(
              actions: [
                TextButton.icon(
                  icon: const Icon(Icons.wb_incandescent),
                  label: const Text('季語のヒント'),
                  onPressed: handleShowHint,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                ),
              ],
            ),
            // 戻るボタン
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(onPressed: handleBack),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            // 縦書きプレビュー
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: HaikuPreview(
                  firstLine: currentStep.value == 0
                      ? currentInputText.value
                      : firstLine.value,
                  secondLine: currentStep.value == 1
                      ? currentInputText.value
                      : (currentStep.value >= 1 ? secondLine.value : ''),
                  thirdLine: currentStep.value == 2
                      ? currentInputText.value
                      : (currentStep.value >= 2 ? thirdLine.value : ''),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // ステップインジケーター
            SliverToBoxAdapter(
              child: StepIndicator(currentStep: currentStep.value),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // 入力フィールド（ステップ3以外）
            if (currentStep.value < 3)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppTextField(
                    controller: inputController,
                    label: _stepLabels[currentStep.value],
                    hintText: _stepHints[currentStep.value],
                    autofocus: true,
                    maxLength: 10,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // ステップ3以外：決定ボタン
            if (currentStep.value < 3)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppFilledButton(
                    label: currentStep.value == 2 ? '決定' : '次の行へ',
                    onPressed: isValid.value ? handleNext : null,
                  ),
                ),
              ),
            // ステップ1,2：ひとつ戻るボタン
            if (currentStep.value > 0 && currentStep.value < 3) ...[
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppOutlinedButton(
                    label: 'ひとつ戻る',
                    onPressed: handlePreviousStep,
                  ),
                ),
              ),
            ],
            // ステップ3：確認画面のボタン
            if (currentStep.value == 3) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _GenerateButton(onPressed: handleGenerate),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppOutlinedButton(
                    label: 'ひとつ戻る',
                    onPressed: handlePreviousStep,
                  ),
                ),
              ),
            ],
            SliverFillRemaining(hasScrollBody: false, child: Container()),
          ],
        ),
      ),
    );
  }
}

/// 背景生成ボタン（ブロブ装飾付き）
class _GenerateButton extends StatelessWidget {
  const _GenerateButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const double height = 64.0;
    const Color bgColor = Color(0xFF040811);

    final ButtonStyle buttonStyle =
        FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, height),
          maximumSize: const Size(double.infinity, height),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
            Colors.white.withValues(alpha: 0.1),
          ),
        );

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ボタン本体
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withValues(alpha: 0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(height / 2),
              child: FilledButton(
                onPressed: onPressed,
                style: buttonStyle,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '背景を生成する',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.rocknRollOne().fontFamily,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 右上の装飾SVG
          Positioned(
            right: -5,
            top: -5,
            child: SvgPicture.asset(
              'assets/images/button_decoration.svg',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
