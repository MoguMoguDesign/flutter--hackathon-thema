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

/// アプリ共通のSliverAppBarヘッダー。
///
/// スクロール時に消える透明な背景のヘッダー。
/// サービス名を左揃えで表示する。
class AppSliverHeader extends StatelessWidget {
  /// SliverAppBarヘッダーを作成する。
  ///
  /// [serviceName] はヘッダーに表示するサービス名。
  const AppSliverHeader({this.serviceName = 'サービス名', super.key});

  /// ヘッダーに表示するサービス名
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(serviceName),
      centerTitle: false, // 左揃え
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
    );
  }
}
