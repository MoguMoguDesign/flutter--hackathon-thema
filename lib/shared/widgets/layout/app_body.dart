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

/// アプリケーション全体で使用する統一された Body コンポーネント。
///
/// 画面のメインコンテンツエリアを定義し、
/// 一貫した左右の余白とスクロール動作を提供する。
class AppBody extends StatelessWidget {
  /// [AppBody] のコンストラクタ。
  ///
  /// [child] は必須パラメータ。
  const AppBody({
    required this.child,
    super.key,
    this.padding,
    this.isScrollable = true,
  });

  /// デフォルトの水平パディング値。
  static const double defaultHorizontalPadding = 16.0;

  /// デフォルトの垂直パディング値。
  static const double defaultVerticalPadding = 16.0;

  /// Body 内に表示する子ウィジェット。
  final Widget child;

  /// カスタムパディング（オプション）。
  ///
  /// 指定しない場合、デフォルトの余白が適用される。
  final EdgeInsetsGeometry? padding;

  /// スクロール可能にするかどうか。
  ///
  /// true の場合、コンテンツが画面より大きい場合にスクロールできる。
  /// デフォルトは true。
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry effectivePadding =
        padding ??
        const EdgeInsets.symmetric(
          horizontal: defaultHorizontalPadding,
          vertical: defaultVerticalPadding,
        );

    final Widget content = Padding(padding: effectivePadding, child: child);

    if (isScrollable) {
      return SingleChildScrollView(child: content);
    }

    return content;
  }
}
