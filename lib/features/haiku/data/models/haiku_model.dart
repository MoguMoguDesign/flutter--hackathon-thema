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
import 'package:flutterhackthema/features/haiku/data/models/save_status.dart';

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

  /// ローカルキャッシュの画像パス (オプショナル)
  /// Firebaseへの保存前に一時的にローカルに保存される画像のパス
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? localImagePath;

  /// 保存状態 (オプショナル)
  /// Firestoreへの保存状態を管理するためのステータス
  @JsonKey(includeFromJson: false, includeToJson: false)
  final SaveStatus? saveStatus;

  /// 俳句モデルを作成する
  const HaikuModel({
    required this.id,
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.createdAt,
    this.imageUrl,
    this.userId,
    this.localImagePath,
    this.saveStatus,
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
    String? localImagePath,
    SaveStatus? saveStatus,
  }) {
    return HaikuModel(
      id: id ?? this.id,
      firstLine: firstLine ?? this.firstLine,
      secondLine: secondLine ?? this.secondLine,
      thirdLine: thirdLine ?? this.thirdLine,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      localImagePath: localImagePath ?? this.localImagePath,
      saveStatus: saveStatus ?? this.saveStatus,
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
          localImagePath == other.localImagePath &&
          saveStatus == other.saveStatus;

  @override
  int get hashCode =>
      id.hashCode ^
      firstLine.hashCode ^
      secondLine.hashCode ^
      thirdLine.hashCode ^
      createdAt.hashCode ^
      imageUrl.hashCode ^
      userId.hashCode ^
      localImagePath.hashCode ^
      saveStatus.hashCode;

  @override
  String toString() {
    return 'HaikuModel(id: $id, firstLine: $firstLine, secondLine: $secondLine, thirdLine: $thirdLine, createdAt: $createdAt, imageUrl: $imageUrl, userId: $userId, localImagePath: $localImagePath, saveStatus: $saveStatus)';
  }
}
