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

part 'haiku_model.g.dart';

/// 俳句データモデル
///
/// Firestoreに保存する俳句の情報を保持します。
@JsonSerializable()
class HaikuModel {
  /// ドキュメントID (Firestoreで自動生成)
  final String id;

  /// 上の句 (最大10文字)
  final String firstLine;

  /// 真ん中の行 (最大10文字)
  final String secondLine;

  /// 下の句 (最大10文字)
  final String thirdLine;

  /// 作成日時
  final DateTime createdAt;

  /// AI生成画像のURL (オプショナル)
  final String? imageUrl;

  /// ユーザーID (オプショナル: 将来的な認証対応)
  final String? userId;

  /// いいね数
  final int? likeCount;

  /// 作者のニックネーム (オプショナル: 匿名の場合はnull)
  final String? nickname;

  /// 俳句モデルを作成する
  const HaikuModel({
    required this.id,
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.createdAt,
    this.imageUrl,
    this.userId,
    this.likeCount,
    this.nickname,
  });

  /// FirestoreのMapからHaikuModelを生成
  factory HaikuModel.fromJson(Map<String, dynamic> json) =>
      _$HaikuModelFromJson(json);

  /// HaikuModelをMapに変換
  Map<String, dynamic> toJson() => _$HaikuModelToJson(this);

  /// copyWith method for immutability pattern
  HaikuModel copyWith({
    String? id,
    String? firstLine,
    String? secondLine,
    String? thirdLine,
    DateTime? createdAt,
    String? imageUrl,
    String? userId,
    int? likeCount,
    String? nickname,
  }) {
    return HaikuModel(
      id: id ?? this.id,
      firstLine: firstLine ?? this.firstLine,
      secondLine: secondLine ?? this.secondLine,
      thirdLine: thirdLine ?? this.thirdLine,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      likeCount: likeCount ?? this.likeCount,
      nickname: nickname ?? this.nickname,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HaikuModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstLine == other.firstLine &&
          secondLine == other.secondLine &&
          thirdLine == other.thirdLine &&
          createdAt == other.createdAt &&
          imageUrl == other.imageUrl &&
          userId == other.userId &&
          likeCount == other.likeCount &&
          nickname == other.nickname;

  @override
  int get hashCode =>
      id.hashCode ^
      firstLine.hashCode ^
      secondLine.hashCode ^
      thirdLine.hashCode ^
      createdAt.hashCode ^
      imageUrl.hashCode ^
      userId.hashCode ^
      likeCount.hashCode ^
      nickname.hashCode;

  @override
  String toString() {
    return 'HaikuModel(id: $id, firstLine: $firstLine, secondLine: $secondLine, thirdLine: $thirdLine, createdAt: $createdAt, imageUrl: $imageUrl, userId: $userId, likeCount: $likeCount, nickname: $nickname)';
  }
}
