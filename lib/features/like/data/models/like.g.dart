// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Like _$LikeFromJson(Map<String, dynamic> json) => _Like(
  id: json['id'] as String,
  userId: json['userId'] as String,
  haikuId: json['haikuId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$LikeToJson(_Like instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'haikuId': instance.haikuId,
  'createdAt': instance.createdAt.toIso8601String(),
};
