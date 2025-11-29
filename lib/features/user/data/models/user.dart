import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// ユーザーエンティティ
///
/// 匿名ログインで使用するユーザー情報。
/// ニックネームのみで登録可能で、ユーザーIDは自動生成されます。
@freezed
sealed class User with _$User {
  const factory User({
    /// ユーザーID（UUIDで自動生成）
    required String id,

    /// ニックネーム（ユーザーが入力）
    required String nickname,

    /// 作成日時
    required DateTime createdAt,

    /// 最終更新日時
    required DateTime updatedAt,

    /// プロフィール画像URL（オプション）
    String? profileImageUrl,

    /// 自己紹介（オプション）
    String? bio,
  }) = _User;
  const User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
