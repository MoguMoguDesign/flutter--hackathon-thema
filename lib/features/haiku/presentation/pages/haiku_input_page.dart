import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/haiku_preview.dart';
import 'package:flutterhackthema/features/haiku/presentation/widgets/step_indicator.dart';
import 'package:flutterhackthema/shared/presentation/widgets/buttons/primary_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/dialogs/confirm_dialog.dart';
import 'package:flutterhackthema/shared/presentation/widgets/inputs/app_text_field.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/app_header.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/back_button.dart';

/// 俳句入力画面。
///
/// 俳句を3行ステップ形式で入力し、AI画像生成をリクエストする。
/// ワイヤーフレーム: `俳句入力.png`
class HaikuInputPage extends HookWidget {
  /// 俳句入力画面を作成する。
  const HaikuInputPage({super.key});

  static const List<String> _stepLabels = ['上の句', '真ん中の行', '下の句'];
  static const List<String> _stepHints = ['上の句を入力', '真ん中の行を入力', '下の句を入力'];

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    final firstLine = useState('');
    final secondLine = useState('');
    final thirdLine = useState('');
    final inputController = useTextEditingController();
    final isValid = useState(false);

    useEffect(() {
      void listener() {
        isValid.value = inputController.text.trim().isNotEmpty;
      }

      inputController.addListener(listener);
      return () => inputController.removeListener(listener);
    }, [inputController],);

    Future<void> handleBack() async {
      final shouldLeave = await ConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '作成中の句は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '編集を続ける',
      );
      if (shouldLeave && context.mounted) {
        const PostsRoute().go(context);
      }
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

      if (currentStep.value < 2) {
        // 次のステップへ
        currentStep.value++;
        inputController.clear();
        isValid.value = false;
      } else {
        // 3ステップ完了、生成画面へ遷移
        GeneratingRoute(
          firstLine: firstLine.value,
          secondLine: secondLine.value,
          thirdLine: thirdLine.value,
        ).go(context);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー
            const AppHeader(),
            // 戻るボタン
            Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(onPressed: handleBack),
            ),
            // タイトル
            const Text(
              '句を詠む',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // 縦書きプレビュー
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HaikuPreview(
                firstLine: firstLine.value,
                secondLine: currentStep.value >= 1 ? secondLine.value : '',
                thirdLine: currentStep.value >= 2 ? thirdLine.value : '',
              ),
            ),
            const SizedBox(height: 24),
            // ステップインジケーター
            StepIndicator(currentStep: currentStep.value),
            const SizedBox(height: 24),
            // 入力フィールド
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppTextField(
                controller: inputController,
                label: _stepLabels[currentStep.value],
                hintText: _stepHints[currentStep.value],
                autofocus: true,
              ),
            ),
            const SizedBox(height: 24),
            // 決定ボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: '決定して次の行へ',
                onPressed: isValid.value ? handleNext : null,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
