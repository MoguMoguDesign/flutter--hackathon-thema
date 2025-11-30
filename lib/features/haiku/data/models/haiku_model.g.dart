// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HaikuModel _$HaikuModelFromJson(Map<String, dynamic> json) => HaikuModel(
  id: json['id'] as String,
  firstLine: json['firstLine'] as String,
  secondLine: json['secondLine'] as String,
  thirdLine: json['thirdLine'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  imageUrl: json['imageUrl'] as String?,
  userId: json['userId'] as String?,
  likeCount: (json['likeCount'] as num?)?.toInt(),
  nickname: json['nickname'] as String?,
);

Map<String, dynamic> _$HaikuModelToJson(HaikuModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstLine': instance.firstLine,
      'secondLine': instance.secondLine,
      'thirdLine': instance.thirdLine,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'likeCount': instance.likeCount,
      'nickname': instance.nickname,
    };
