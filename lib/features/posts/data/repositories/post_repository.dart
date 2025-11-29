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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'package:flutterhackthema/shared/data/repositories/firestore_repository.dart';
import '../models/post.dart';

/// 投稿データのFirestoreリポジトリ
///
/// Firestoreの`posts`コレクションに対するCRUD操作を提供します
/// [FirestoreRepository]を継承し、投稿特有のロジックを実装します
class PostRepository extends FirestoreRepository<Post> {
  /// 投稿リポジトリを作成する
  PostRepository() : super(collectionPath: 'posts');

  final Logger _logger = Logger();

  @override
  Post fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Document data is null for post ${snapshot.id}');
    }

    // IDをデータに追加してモデルを生成
    return Post.fromJson({...data, 'id': snapshot.id});
  }

  @override
  Map<String, dynamic> toFirestore(Post data) {
    final json = data.toJson();

    // Firestoreに保存する際はIDを除外
    // (IDはドキュメントIDとして自動設定される)
    json.remove('id');

    return json;
  }

  /// 投稿を作成時刻の降順でリアルタイム監視
  ///
  /// Returns: 投稿のリアルタイムストリーム（新しい順）
  Stream<List<Post>> watchAllPosts() {
    _logger.d('Watching all posts with createdAt desc order');
    return watchAll(query: collection.orderBy('createdAt', descending: true));
  }
}
