import 'package:freezed_annotation/freezed_annotation.dart';

part 'haiku.freezed.dart';
part 'haiku.g.dart';

/// 俳句投稿エンティティ
///
/// 俳句の文字と画像を含む投稿データ。
/// いいね関連のフィールドは含まず、シンプルな投稿データのみを保持します。
@freezed
class Haiku with _$Haiku {
  const Haiku._();

  const factory Haiku({
    /// 俳句ID（UUIDで自動生成）
    required String id,

    /// 投稿者のユーザーID
    required String userId,

    /// 投稿者のニックネーム（キャッシュ用）
    required String authorNickname,

    /// 俳句の文字（完全な文章）
    required String text,

    /// 上の句（5文字）
    required String firstLine,

    /// 中の句（7文字）
    required String secondLine,

    /// 下の句（5文字）
    required String thirdLine,

    /// 俳句の画像URL
    required String imageUrl,

    /// 作成日時
    required DateTime createdAt,

    /// 最終更新日時
    required DateTime updatedAt,

    /// タグ（オプション）
    @Default([]) List<String> tags,

    /// 季語（オプション）
    String? seasonWord,
  }) = _Haiku;

  factory Haiku.fromJson(Map<String, dynamic> json) => _$HaikuFromJson(json);
}
