import 'package:flutterhackthema/features/haiku/data/models/haiku.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'haiku_with_like_status.freezed.dart';

/// 俳句とログインユーザーのいいね状態を含むDTO（オプショナル）
///
/// いいね機能が有効な場合のみ使用します。
/// いいね機能が無効な場合は、Haikuエンティティを直接使用してください。
@freezed
class HaikuWithLikeStatus with _$HaikuWithLikeStatus {
  const factory HaikuWithLikeStatus({
    /// 俳句本体
    required Haiku haiku,

    /// 現在のユーザーがいいね済みかどうか
    /// いいね機能無効時はfalse
    @Default(false) bool isLikedByCurrentUser,

    /// いいねID（いいね済みの場合のみ）
    String? likeId,

    /// いいね総数（いいね機能有効時のみ集計）
    @Default(0) int likeCount,
  }) = _HaikuWithLikeStatus;
  const HaikuWithLikeStatus._();
}
