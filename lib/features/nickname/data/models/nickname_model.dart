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

/// ニックネームデータモデル
///
/// Firestoreに保存されるニックネーム情報を表すイミュータブルなモデルです。
///
/// フィールド:
/// - [nickname]: ユーザーのニックネーム（1〜20文字）
/// - [updatedAt]: 最終更新日時
///
/// 使用例:
/// ```dart
/// final model = NicknameModel(
///   nickname: 'テストユーザー',
///   updatedAt: DateTime.now(),
/// );
/// ```
class NicknameModel {
  /// ニックネームモデルを作成
  ///
  /// [nickname] ユーザーのニックネーム
  /// [updatedAt] 最終更新日時
  const NicknameModel({required this.nickname, required this.updatedAt});

  /// ユーザーのニックネーム
  final String nickname;

  /// 最終更新日時
  final DateTime updatedAt;

  /// JSONからNicknameModelを生成
  ///
  /// Firestoreから取得したデータをモデルに変換します。
  /// [json] Firestoreドキュメントのデータ
  factory NicknameModel.fromJson(Map<String, dynamic> json) {
    return NicknameModel(
      nickname: json['nickname'] as String,
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  /// NicknameModelをJSONに変換
  ///
  /// Firestoreに保存するためのデータに変換します。
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nickname': nickname,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// 指定されたフィールドを更新した新しいインスタンスを作成
  NicknameModel copyWith({String? nickname, DateTime? updatedAt}) {
    return NicknameModel(
      nickname: nickname ?? this.nickname,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NicknameModel &&
        other.nickname == nickname &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode => Object.hash(nickname, updatedAt);

  @override
  String toString() {
    return 'NicknameModel(nickname: $nickname, updatedAt: $updatedAt)';
  }
}
