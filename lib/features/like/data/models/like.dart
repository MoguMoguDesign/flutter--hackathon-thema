import 'package:freezed_annotation/freezed_annotation.dart';

part 'like.freezed.dart';
part 'like.g.dart';

/// いいねエンティティ（オプショナル機能）
///
/// この機能は後から追加・削除可能です。
/// Feature Flags Providerでいいね機能が有効な場合のみ使用されます。
@freezed
class Like with _$Like {
  const Like._();

  const factory Like({
    /// いいねID（UUIDで自動生成）
    required String id,

    /// いいねしたユーザーのID
    required String userId,

    /// いいねされた俳句のID
    required String haikuId,

    /// いいねした日時
    required DateTime createdAt,
  }) = _Like;

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
}
