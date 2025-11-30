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

import '../../data/models/haiku_model.dart';
import 'haiku_provider.dart';

part 'haiku_detail_provider.g.dart';

/// 俳句詳細データを取得するプロバイダー
///
/// [haikuId] 取得する俳句のID
///
/// Firestoreから指定されたIDの俳句を取得します。
/// 俳句が存在しない場合はnullを返します。
@riverpod
Future<HaikuModel?> haikuDetail(Ref ref, String haikuId) async {
  final repository = ref.watch(haikuRepositoryProvider);
  return await repository.read(haikuId);
}

/// いいね機能を管理するNotifier
///
/// いいねボタンのタップ時にFirestoreのいいね数を
/// インクリメントし、詳細データを再取得します。
@riverpod
class LikeNotifier extends _$LikeNotifier {
  /// 初期状態を構築
  @override
  FutureOr<void> build() {}

  /// いいね数をインクリメントする
  ///
  /// [haikuId] いいね対象の俳句ID
  ///
  /// Firestoreのいいね数をインクリメントし、
  /// 詳細データのキャッシュを無効化して再取得を促します。
  Future<void> incrementLike(String haikuId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref.read(haikuRepositoryProvider).incrementLikeCount(haikuId);

      // 詳細データを再取得
      ref.invalidate(haikuDetailProvider(haikuId));
    });
  }
}
