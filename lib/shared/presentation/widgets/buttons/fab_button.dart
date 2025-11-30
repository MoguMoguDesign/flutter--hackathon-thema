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
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_colors.dart';

/// 「+ 句を詠む」フローティングアクションボタン。
///
/// 俳句一覧画面の右下に配置する新規作成ボタン。
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // FABボタン本体（正円）
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 8,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 24),
        ),
        // 左上の装飾SVG（上レイヤー）
        Positioned(
          left: -15,
          top: -8,
          child: Transform.rotate(
            angle: 3.14159, // 180度回転
            child: SvgPicture.asset(
              'assets/images/button_decoration.svg',
              width: 40,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // 右下の装飾SVG（上レイヤー）
        Positioned(
          right: -15,
          bottom: -8,
          child: SvgPicture.asset(
            'assets/images/button_decoration.svg',
            width: 40,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
