import 'package:flutter/material.dart';

/// 「TOPに戻る」ナビゲーションボタン。
///
/// 画面上部に配置する戻るボタンコンポーネント。
/// タップ時に確認ダイアログを表示するかどうかを制御できる。
class AppBackButton extends StatelessWidget {
  /// 戻るボタンを作成する。
  ///
  /// [onPressed] はボタンがタップされた時のコールバック。
  /// [label] はボタンに表示するテキスト。デフォルトは「TOPに戻る」。
  const AppBackButton({
    required this.onPressed,
    this.label = 'TOPに戻る',
    super.key,
  });

  /// ボタンがタップされた時のコールバック
  final VoidCallback onPressed;

  /// ボタンに表示するテキスト
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chevron_left, size: 24, color: Colors.white),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
