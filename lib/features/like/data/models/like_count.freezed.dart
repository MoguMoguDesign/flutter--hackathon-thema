// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_count.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LikeCount {

/// 俳句ID
 String get haikuId;/// いいね総数
 int get count;/// 最終更新日時
 DateTime get updatedAt;
/// Create a copy of LikeCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeCountCopyWith<LikeCount> get copyWith => _$LikeCountCopyWithImpl<LikeCount>(this as LikeCount, _$identity);

  /// Serializes this LikeCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeCount&&(identical(other.haikuId, haikuId) || other.haikuId == haikuId)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,haikuId,count,updatedAt);

@override
String toString() {
  return 'LikeCount(haikuId: $haikuId, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LikeCountCopyWith<$Res>  {
  factory $LikeCountCopyWith(LikeCount value, $Res Function(LikeCount) _then) = _$LikeCountCopyWithImpl;
@useResult
$Res call({
 String haikuId, int count, DateTime updatedAt
});




}
/// @nodoc
class _$LikeCountCopyWithImpl<$Res>
    implements $LikeCountCopyWith<$Res> {
  _$LikeCountCopyWithImpl(this._self, this._then);

  final LikeCount _self;
  final $Res Function(LikeCount) _then;

/// Create a copy of LikeCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? haikuId = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
haikuId: null == haikuId ? _self.haikuId : haikuId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LikeCount].
extension LikeCountPatterns on LikeCount {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeCount() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeCount value)  $default,){
final _that = this;
switch (_that) {
case _LikeCount():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeCount value)?  $default,){
final _that = this;
switch (_that) {
case _LikeCount() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String haikuId,  int count,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeCount() when $default != null:
return $default(_that.haikuId,_that.count,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String haikuId,  int count,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LikeCount():
return $default(_that.haikuId,_that.count,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String haikuId,  int count,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LikeCount() when $default != null:
return $default(_that.haikuId,_that.count,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LikeCount extends LikeCount {
  const _LikeCount({required this.haikuId, required this.count, required this.updatedAt}): super._();
  factory _LikeCount.fromJson(Map<String, dynamic> json) => _$LikeCountFromJson(json);

/// 俳句ID
@override final  String haikuId;
/// いいね総数
@override final  int count;
/// 最終更新日時
@override final  DateTime updatedAt;

/// Create a copy of LikeCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeCountCopyWith<_LikeCount> get copyWith => __$LikeCountCopyWithImpl<_LikeCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LikeCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeCount&&(identical(other.haikuId, haikuId) || other.haikuId == haikuId)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,haikuId,count,updatedAt);

@override
String toString() {
  return 'LikeCount(haikuId: $haikuId, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LikeCountCopyWith<$Res> implements $LikeCountCopyWith<$Res> {
  factory _$LikeCountCopyWith(_LikeCount value, $Res Function(_LikeCount) _then) = __$LikeCountCopyWithImpl;
@override @useResult
$Res call({
 String haikuId, int count, DateTime updatedAt
});




}
/// @nodoc
class __$LikeCountCopyWithImpl<$Res>
    implements _$LikeCountCopyWith<$Res> {
  __$LikeCountCopyWithImpl(this._self, this._then);

  final _LikeCount _self;
  final $Res Function(_LikeCount) _then;

/// Create a copy of LikeCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? haikuId = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_LikeCount(
haikuId: null == haikuId ? _self.haikuId : haikuId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
