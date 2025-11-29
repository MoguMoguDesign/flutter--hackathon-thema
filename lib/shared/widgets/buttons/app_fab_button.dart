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
import '../../constants/app_colors.dart';

/// アプリケーション共通のFloating Action Button。
///
/// 「+ 句を詠む」などの新規作成アクションで使用する。
/// テキストとアイコン付きの拡張FABスタイル。
class AppFabButton extends StatelessWidget {
  /// FABボタンを作成する。
  ///
  /// [onPressed] はボタンがタップされた時のコールバック。
  /// [label] はボタンに表示するテキスト。デフォルトは「句を詠む」。
  /// [icon] はボタンに表示するアイコン。デフォルトは追加アイコン。
  const AppFabButton({
    required this.onPressed,
    this.label = '句を詠む',
    this.icon = Icons.add,
    super.key,
  });

  /// ボタンがタップされた時のコールバック
  final VoidCallback onPressed;

  /// ボタンに表示するテキスト
  final String label;

  /// ボタンに表示するアイコン
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
