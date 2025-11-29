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
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFE53935),
                ),
              )
            : LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFE53935),
                ),
              ),
      ),
    );
  }
}
