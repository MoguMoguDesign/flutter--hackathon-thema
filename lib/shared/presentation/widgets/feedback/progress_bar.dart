import 'package:flutter/material.dart';

/// プログレスバーコンポーネント。
///
/// 画像生成の進捗状況を表示する。
/// ワイヤーフレームに基づいた黒/グレーのスタイル。
class AppProgressBar extends StatelessWidget {
  /// プログレスバーを作成する。
  ///
  /// [progress] は進捗率（0.0〜1.0）。nullの場合は不定のアニメーションを表示。
  const AppProgressBar({this.progress, super.key});

  /// 進捗率（0.0〜1.0）
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 8,
        child: progress != null
            ? LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              )
            : LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
      ),
    );
  }
}
