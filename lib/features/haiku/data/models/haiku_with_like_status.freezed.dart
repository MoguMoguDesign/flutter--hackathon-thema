// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'haiku_with_like_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HaikuWithLikeStatus {

/// 俳句本体
 Haiku get haiku;/// 現在のユーザーがいいね済みかどうか
/// いいね機能無効時はfalse
 bool get isLikedByCurrentUser;/// いいねID（いいね済みの場合のみ）
 String? get likeId;/// いいね総数（いいね機能有効時のみ集計）
 int get likeCount;
/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HaikuWithLikeStatusCopyWith<HaikuWithLikeStatus> get copyWith => _$HaikuWithLikeStatusCopyWithImpl<HaikuWithLikeStatus>(this as HaikuWithLikeStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HaikuWithLikeStatus&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.likeId, likeId) || other.likeId == likeId)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}


@override
int get hashCode => Object.hash(runtimeType,haiku,isLikedByCurrentUser,likeId,likeCount);

@override
String toString() {
  return 'HaikuWithLikeStatus(haiku: $haiku, isLikedByCurrentUser: $isLikedByCurrentUser, likeId: $likeId, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class $HaikuWithLikeStatusCopyWith<$Res>  {
  factory $HaikuWithLikeStatusCopyWith(HaikuWithLikeStatus value, $Res Function(HaikuWithLikeStatus) _then) = _$HaikuWithLikeStatusCopyWithImpl;
@useResult
$Res call({
 Haiku haiku, bool isLikedByCurrentUser, String? likeId, int likeCount
});


$HaikuCopyWith<$Res> get haiku;

}
/// @nodoc
class _$HaikuWithLikeStatusCopyWithImpl<$Res>
    implements $HaikuWithLikeStatusCopyWith<$Res> {
  _$HaikuWithLikeStatusCopyWithImpl(this._self, this._then);

  final HaikuWithLikeStatus _self;
  final $Res Function(HaikuWithLikeStatus) _then;

/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? haiku = null,Object? isLikedByCurrentUser = null,Object? likeId = freezed,Object? likeCount = null,}) {
  return _then(_self.copyWith(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as Haiku,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,likeId: freezed == likeId ? _self.likeId : likeId // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HaikuCopyWith<$Res> get haiku {
  
  return $HaikuCopyWith<$Res>(_self.haiku, (value) {
    return _then(_self.copyWith(haiku: value));
  });
}
}


/// Adds pattern-matching-related methods to [HaikuWithLikeStatus].
extension HaikuWithLikeStatusPatterns on HaikuWithLikeStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HaikuWithLikeStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HaikuWithLikeStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HaikuWithLikeStatus value)  $default,){
final _that = this;
switch (_that) {
case _HaikuWithLikeStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HaikuWithLikeStatus value)?  $default,){
final _that = this;
switch (_that) {
case _HaikuWithLikeStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Haiku haiku,  bool isLikedByCurrentUser,  String? likeId,  int likeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HaikuWithLikeStatus() when $default != null:
return $default(_that.haiku,_that.isLikedByCurrentUser,_that.likeId,_that.likeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Haiku haiku,  bool isLikedByCurrentUser,  String? likeId,  int likeCount)  $default,) {final _that = this;
switch (_that) {
case _HaikuWithLikeStatus():
return $default(_that.haiku,_that.isLikedByCurrentUser,_that.likeId,_that.likeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Haiku haiku,  bool isLikedByCurrentUser,  String? likeId,  int likeCount)?  $default,) {final _that = this;
switch (_that) {
case _HaikuWithLikeStatus() when $default != null:
return $default(_that.haiku,_that.isLikedByCurrentUser,_that.likeId,_that.likeCount);case _:
  return null;

}
}

}

/// @nodoc


class _HaikuWithLikeStatus extends HaikuWithLikeStatus {
  const _HaikuWithLikeStatus({required this.haiku, this.isLikedByCurrentUser = false, this.likeId, this.likeCount = 0}): super._();
  

/// 俳句本体
@override final  Haiku haiku;
/// 現在のユーザーがいいね済みかどうか
/// いいね機能無効時はfalse
@override@JsonKey() final  bool isLikedByCurrentUser;
/// いいねID（いいね済みの場合のみ）
@override final  String? likeId;
/// いいね総数（いいね機能有効時のみ集計）
@override@JsonKey() final  int likeCount;

/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HaikuWithLikeStatusCopyWith<_HaikuWithLikeStatus> get copyWith => __$HaikuWithLikeStatusCopyWithImpl<_HaikuWithLikeStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HaikuWithLikeStatus&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.likeId, likeId) || other.likeId == likeId)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount));
}


@override
int get hashCode => Object.hash(runtimeType,haiku,isLikedByCurrentUser,likeId,likeCount);

@override
String toString() {
  return 'HaikuWithLikeStatus(haiku: $haiku, isLikedByCurrentUser: $isLikedByCurrentUser, likeId: $likeId, likeCount: $likeCount)';
}


}

/// @nodoc
abstract mixin class _$HaikuWithLikeStatusCopyWith<$Res> implements $HaikuWithLikeStatusCopyWith<$Res> {
  factory _$HaikuWithLikeStatusCopyWith(_HaikuWithLikeStatus value, $Res Function(_HaikuWithLikeStatus) _then) = __$HaikuWithLikeStatusCopyWithImpl;
@override @useResult
$Res call({
 Haiku haiku, bool isLikedByCurrentUser, String? likeId, int likeCount
});


@override $HaikuCopyWith<$Res> get haiku;

}
/// @nodoc
class __$HaikuWithLikeStatusCopyWithImpl<$Res>
    implements _$HaikuWithLikeStatusCopyWith<$Res> {
  __$HaikuWithLikeStatusCopyWithImpl(this._self, this._then);

  final _HaikuWithLikeStatus _self;
  final $Res Function(_HaikuWithLikeStatus) _then;

/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? haiku = null,Object? isLikedByCurrentUser = null,Object? likeId = freezed,Object? likeCount = null,}) {
  return _then(_HaikuWithLikeStatus(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as Haiku,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,likeId: freezed == likeId ? _self.likeId : likeId // ignore: cast_nullable_to_non_nullable
as String?,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HaikuWithLikeStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HaikuCopyWith<$Res> get haiku {
  
  return $HaikuCopyWith<$Res>(_self.haiku, (value) {
    return _then(_self.copyWith(haiku: value));
  });
}
}

// dart format on
