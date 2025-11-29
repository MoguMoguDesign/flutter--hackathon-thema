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

/// アプリ共通のSliverAppBarヘッダー。
///
/// スクロール時に消える透明な背景のヘッダー。
/// サービスロゴを左揃えで表示する。
class AppSliverHeader extends StatelessWidget {
  /// SliverAppBarヘッダーを作成する。
  const AppSliverHeader({super.key, this.actions});

  /// 右上に表示するアクションボタン。
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        height: 32,
        fit: BoxFit.contain,
      ),
      centerTitle: false, // 左揃え
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }
}
