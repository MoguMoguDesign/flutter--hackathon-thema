// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LikeCount _$LikeCountFromJson(Map<String, dynamic> json) => _LikeCount(
      haikuId: json['haikuId'] as String,
      count: (json['count'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LikeCountToJson(_LikeCount instance) =>
    <String, dynamic>{
      'haikuId': instance.haikuId,
      'count': instance.count,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
