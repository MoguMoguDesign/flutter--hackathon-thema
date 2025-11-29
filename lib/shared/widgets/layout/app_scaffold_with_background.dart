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

/// 背景色と背景画像を含む統一されたScaffold。
///
/// アプリケーション全体で共通の背景デザインを提供する。
/// 背景色と背景画像をStackで組み合わせ、その上にコンテンツを表示する。
class AppScaffoldWithBackground extends StatelessWidget {
  /// [AppScaffoldWithBackground] のコンストラクタ。
  ///
  /// [body] は必須パラメータ。
  const AppScaffoldWithBackground({
    required this.body,
    super.key,
    this.backgroundImage = 'assets/images/background.png',
    this.floatingActionButton,
  });

  /// Scaffold内に表示する子ウィジェット。
  final Widget body;

  /// 背景画像のパス。
  ///
  /// デフォルトは 'assets/images/background.png'。
  /// スタート画面などで異なる背景を使用する場合は変更可能。
  final String backgroundImage;

  /// Floating Action Button（オプション）。
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景グラデーション（白からダークグリーンへ）
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFFFFF), // 白
                  AppColors.background, // ダークグリーン (#187360)
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
          // PNG背景画像
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          // コンテンツ
          body,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
