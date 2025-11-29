// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Haiku _$HaikuFromJson(Map<String, dynamic> json) => _Haiku(
  id: json['id'] as String,
  userId: json['userId'] as String,
  authorNickname: json['authorNickname'] as String,
  text: json['text'] as String,
  firstLine: json['firstLine'] as String,
  secondLine: json['secondLine'] as String,
  thirdLine: json['thirdLine'] as String,
  imageUrl: json['imageUrl'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  seasonWord: json['seasonWord'] as String?,
);

Map<String, dynamic> _$HaikuToJson(_Haiku instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'authorNickname': instance.authorNickname,
  'text': instance.text,
  'firstLine': instance.firstLine,
  'secondLine': instance.secondLine,
  'thirdLine': instance.thirdLine,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'tags': instance.tags,
  'seasonWord': instance.seasonWord,
};
