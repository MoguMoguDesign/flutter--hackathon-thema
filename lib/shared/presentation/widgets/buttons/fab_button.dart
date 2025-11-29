import 'package:flutter/material.dart';

/// 「+ 句を詠む」フローティングアクションボタン。
///
/// 投稿一覧画面の右下に配置する新規作成ボタン。
/// テキスト付きのFABスタイル。
class FabButton extends StatelessWidget {
  /// FABボタンを作成する。
  ///
  /// [onPressed] はボタンがタップされた時のコールバック。
  /// [label] はボタンに表示するテキスト。デフォルトは「句を詠む」。
  const FabButton({required this.onPressed, this.label = '句を詠む', super.key});

  /// ボタンがタップされた時のコールバック
  final VoidCallback onPressed;

  /// ボタンに表示するテキスト
  final String label;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      icon: const Icon(Icons.add, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
