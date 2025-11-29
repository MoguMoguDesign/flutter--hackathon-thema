import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/shared/presentation/widgets/dialogs/confirm_dialog.dart';
import 'package:flutterhackthema/shared/presentation/widgets/feedback/progress_bar.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/app_header.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/back_button.dart';

/// AI画像生成中画面。
///
/// 俳句からAI画像を生成している間のローディング画面。
/// ワイヤーフレーム: `生成中....png`
class GeneratingPage extends HookWidget {
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
  Widget build(BuildContext context) {
    final progress = useState<double>(0);

    useEffect(() {
      Future<void> simulateGeneration() async {
        for (var i = 0; i <= 100; i += 5) {
          await Future<void>.delayed(const Duration(milliseconds: 150));
          if (context.mounted) {
            progress.value = i / 100;
          }
        }
        if (context.mounted) {
          PreviewRoute(
            firstLine: firstLine,
            secondLine: secondLine,
            thirdLine: thirdLine,
            imageUrl: 'https://picsum.photos/seed/haiku/400/500',
          ).go(context);
        }
      }

      simulateGeneration();
      return null;
    }, []);

    Future<void> handleBack() async {
      final shouldLeave = await ConfirmDialog.show(
        context: context,
        title: 'TOPに戻りますか？',
        message: '生成を中断し、作成中の句は保存されません。',
        confirmText: '変更を破棄してTOPへ',
        cancelText: '生成を続ける',
      );
      if (shouldLeave && context.mounted) {
        const PostsRoute().go(context);
      }
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
            const Spacer(),
            const Text(
              '挿絵を生成中...',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
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
                child: Center(child: _PulsingAnimation()),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppProgressBar(progress: progress.value),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _PulsingAnimation extends HookWidget {
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
                '待機中アニメーション',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
            ],
          ),
        );
      },
    );
  }
}
