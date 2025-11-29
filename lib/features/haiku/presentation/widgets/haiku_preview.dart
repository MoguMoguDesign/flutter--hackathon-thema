import 'package:flutter/material.dart';

/// 俳句縦書きプレビューコンポーネント。
///
/// 入力した俳句を縦書きでリアルタイム表示する。
/// 右から左へ3列（上の句・中の句・下の句）で配置。
class HaikuPreview extends StatelessWidget {
  /// 縦書きプレビューを作成する。
  ///
  /// [firstLine] は上の句。
  /// [secondLine] は中の句。
  /// [thirdLine] は下の句。
  const HaikuPreview({
    this.firstLine = '',
    this.secondLine = '',
    this.thirdLine = '',
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
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 右から左へ配置（日本語縦書きの順序）
          if (thirdLine.isNotEmpty) _VerticalText(text: thirdLine),
          if (thirdLine.isNotEmpty) const SizedBox(width: 24),
          if (secondLine.isNotEmpty) _VerticalText(text: secondLine),
          if (secondLine.isNotEmpty) const SizedBox(width: 24),
          if (firstLine.isNotEmpty) _VerticalText(text: firstLine),
          // プレースホルダー表示
          if (firstLine.isEmpty && secondLine.isEmpty && thirdLine.isEmpty)
            Text(
              '俳句がここに\n表示されます',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
        ],
      ),
    );
  }
}

/// 縦書きテキストコンポーネント。
class _VerticalText extends StatelessWidget {
  const _VerticalText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: text.split('').map((char) {
        return Text(
          char,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: Colors.black87,
            fontFamily: 'Hannari',
          ),
        );
      }).toList(),
    );
  }
}
