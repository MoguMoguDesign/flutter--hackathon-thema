import 'package:flutter/material.dart';

/// 副次アクション用のセカンダリボタン。
///
/// アウトライン（黒枠）スタイルで統一されたボタンコンポーネント。
/// 「生成をやり直す」「編集を続ける」などの副次アクションに使用する。
class SecondaryButton extends StatelessWidget {
  /// セカンダリボタンを作成する。
  ///
  /// [text] はボタンに表示するテキスト。
  /// [onPressed] はボタンがタップされた時のコールバック。nullの場合は無効状態になる。
  /// [icon] はオプションでボタンの前に表示するアイコン。
  const SecondaryButton({
    required this.text,
    required this.onPressed,
    this.icon,
    super.key,
  });

  /// ボタンに表示するテキスト
  final String text;

  /// ボタンがタップされた時のコールバック
  final VoidCallback? onPressed;

  /// ボタンの前に表示するオプションのアイコン
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black, width: 3.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
