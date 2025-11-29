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
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/nickname/presentation/providers/nickname_provider.dart';

/// ニックネーム認証ガード
///
/// ニックネームが未設定の場合、ニックネーム入力画面へリダイレクトします
///
/// リダイレクトロジック:
/// - ニックネームが null かつ 現在のページが /nickname 以外の場合 → /nickname へリダイレクト
/// - それ以外の場合 → リダイレクトなし（null を返す）
///
/// 注意: このガードは同期的に呼び出されるため、AsyncValue の現在の値を使用します。
/// 初回アクセス時は AsyncLoading 状態の可能性があり、その場合は null として扱われます。
///
/// 使用例:
/// ```dart
/// GoRouter(
///   redirect: (context, state) => nicknameGuard(context, state, ref),
/// )
/// ```
String? nicknameGuard(
  BuildContext context,
  GoRouterState state,
  WidgetRef ref,
) {
  // 現在のニックネームを取得（AsyncValueから値を取得）
  final nicknameAsync = ref.read(nicknameProvider);
  final String? nickname = nicknameAsync.value;

  // 現在のページがニックネームページかどうかを確認
  // TypedGoRouteで生成されたlocationを使用
  final bool isNicknamePage =
      state.matchedLocation == const NicknameRoute().location;

  // ニックネームが未設定 かつ ニックネームページ以外の場合
  if (nickname == null && !isNicknamePage) {
    // ニックネームページへリダイレクト
    // TypedGoRouteで生成されたlocationを使用
    return const NicknameRoute().location;
  }

  // リダイレクトなし
  return null;
}
