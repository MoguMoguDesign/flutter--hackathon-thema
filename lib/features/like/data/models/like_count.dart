import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_count.freezed.dart';
part 'like_count.g.dart';

/// いいね数の集計結果（オプショナル機能）
///
/// 俳句ごとのいいね数をキャッシュするために使用します。
/// パフォーマンス向上のため、頻繁に参照されるいいね数を事前に集計して保持します。
@freezed
class LikeCount with _$LikeCount {

  const factory LikeCount({
    /// 俳句ID
    required String haikuId,

    /// いいね総数
    required int count,

    /// 最終更新日時
    required DateTime updatedAt,
  }) = _LikeCount;
  const LikeCount._();

  factory LikeCount.fromJson(Map<String, dynamic> json) =>
      _$LikeCountFromJson(json);
}
