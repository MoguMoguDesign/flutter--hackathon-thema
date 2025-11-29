import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/widgets/dialogs/confirm_dialog.dart';
import '../../../../shared/presentation/widgets/feedback/progress_bar.dart';
import '../../../../shared/presentation/widgets/navigation/app_header.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';

/// AI画像生成中画面。
///
/// 俳句からAI画像を生成している間のローディング画面。
/// ワイヤーフレーム: `生成中....png`
class GeneratingPage extends HookWidget {
  /// 生成中画面を作成する。
  ///
  /// [firstLine] は上の句。
  /// [secondLine] は中の句。
  /// [thirdLine] は下の句。
  const GeneratingPage({
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
  Widget build(BuildContext context) {
    final progress = useState(0.0);

    // モック: 3秒で生成完了をシミュレート
    useEffect(() {
      Future<void> simulateGeneration() async {
        for (var i = 0; i <= 100; i += 5) {
          await Future<void>.delayed(const Duration(milliseconds: 150));
          if (context.mounted) {
            progress.value = i / 100;
          }
        }
        // 生成完了後、プレビュー画面へ遷移
        if (context.mounted) {
          context.go(
            '/create/preview',
            extra: {
              'firstLine': firstLine,
              'secondLine': secondLine,
              'thirdLine': thirdLine,
              // モック画像URL
              'imageUrl': 'https://picsum.photos/seed/haiku/400/500',
            },
          );
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
        context.go('/posts');
      }
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
            const Spacer(),
            // 生成中テキスト
            const Text(
              '挿絵を生成中...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            // 待機中アニメーションエリア
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
            // プログレスバー
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

/// 待機中のパルスアニメーション。
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
