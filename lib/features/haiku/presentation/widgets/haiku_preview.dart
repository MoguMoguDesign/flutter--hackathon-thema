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
import 'package:google_fonts/google_fonts.dart';

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
    return AspectRatio(
      aspectRatio: 4 / 5, // 4:5の縦長
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            // プレースホルダー（何も入力されていない時のみ表示）
            if (firstLine.isEmpty && secondLine.isEmpty && thirdLine.isEmpty)
              Center(
                child: Text(
                  '俳句がここに\n表示されます',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            // 固定位置の3列
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左側：3行目（下の句）
                SizedBox(
                  width: 60,
                  child: thirdLine.isNotEmpty
                      ? _VerticalText(text: thirdLine)
                      : const SizedBox.shrink(),
                ),
                // 真ん中：2行目（中の句）
                SizedBox(
                  width: 60,
                  child: secondLine.isNotEmpty
                      ? _VerticalText(text: secondLine)
                      : const SizedBox.shrink(),
                ),
                // 右側：1行目（上の句）
                SizedBox(
                  width: 60,
                  child: firstLine.isNotEmpty
                      ? _VerticalText(text: firstLine)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
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
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: Colors.black87,
            fontFamily: GoogleFonts.rocknRollOne().fontFamily,
          ),
        );
      }).toList(),
    );
  }
}
