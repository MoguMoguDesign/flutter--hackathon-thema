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

import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

/// 投稿データモデル
///
/// Firestoreに保存する俳句×画像の投稿情報を保持する
@JsonSerializable()
class Post {
  /// 投稿を作成する
  const Post({
    required this.id,
    required this.nickname,
    required this.haiku,
    required this.imageUrl,
    required this.createdAt,
    this.likeCount = 0,
  });

  /// 投稿ID
  final String id;

  /// 投稿者のニックネーム
  final String nickname;

  /// 俳句テキスト（上の句、中の句、下の句）
  final String haiku;

  /// 生成画像のURL
  final String imageUrl;

  /// 投稿日時
  final DateTime createdAt;

  /// いいね数
  final int likeCount;

  /// FirestoreドキュメントからPostモデルを生成
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// PostモデルをFirestoreドキュメントに変換
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
