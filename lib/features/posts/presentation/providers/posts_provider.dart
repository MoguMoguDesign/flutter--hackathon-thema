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

import '../../data/models/post.dart';
import '../../data/repositories/post_repository.dart';

part 'posts_provider.g.dart';

/// PostRepositoryのプロバイダー
///
/// Firestoreの投稿データにアクセスするためのリポジトリインスタンスを提供します
@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepository();
}

/// 投稿一覧のストリームプロバイダー
///
/// Firestoreから投稿一覧をリアルタイムで監視し、作成日時の降順で提供します
@riverpod
Stream<List<Post>> postsStream(Ref ref) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.watchAllPosts();
}
