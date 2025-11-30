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

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/features/nickname/presentation/providers/nickname_provider.dart';

part 'user_providers.g.dart';

/// アプリレベルのユーザーニックネームプロバイダー
///
/// Feature層のnicknameProviderをApp層で再エクスポートし、
/// 他のFeature層がApp層経由でニックネームにアクセスできるようにします。
///
/// これにより、Feature-to-Feature依存を回避し、
/// 三層アーキテクチャ(App → Feature → Shared)を維持します。
///
/// 使用例:
/// ```dart
/// // Feature層から使用
/// final nickname = await ref.read(userNicknameProvider.future);
/// ```
@riverpod
Future<String?> userNickname(Ref ref) async {
  return ref.watch(nicknameProvider.future);
}
