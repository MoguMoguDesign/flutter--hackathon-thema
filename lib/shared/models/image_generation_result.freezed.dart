// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_generation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageGenerationResult {

/// 画像のバイナリデータ
 Uint8List get imageData;/// 画像のMIMEタイプ
 String get mimeType;
/// Create a copy of ImageGenerationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationResultCopyWith<ImageGenerationResult> get copyWith => _$ImageGenerationResultCopyWithImpl<ImageGenerationResult>(this as ImageGenerationResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationResult&&const DeepCollectionEquality().equals(other.imageData, imageData)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageData),mimeType);

@override
String toString() {
  return 'ImageGenerationResult(imageData: $imageData, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationResultCopyWith<$Res>  {
  factory $ImageGenerationResultCopyWith(ImageGenerationResult value, $Res Function(ImageGenerationResult) _then) = _$ImageGenerationResultCopyWithImpl;
@useResult
$Res call({
 Uint8List imageData, String mimeType
});




}
/// @nodoc
class _$ImageGenerationResultCopyWithImpl<$Res>
    implements $ImageGenerationResultCopyWith<$Res> {
  _$ImageGenerationResultCopyWithImpl(this._self, this._then);

  final ImageGenerationResult _self;
  final $Res Function(ImageGenerationResult) _then;

/// Create a copy of ImageGenerationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageData = null,Object? mimeType = null,}) {
  return _then(_self.copyWith(
imageData: null == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as Uint8List,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageGenerationResult].
extension ImageGenerationResultPatterns on ImageGenerationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageGenerationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageGenerationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageGenerationResult value)  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationResult():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageGenerationResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImageGenerationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List imageData,  String mimeType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageGenerationResult() when $default != null:
return $default(_that.imageData,_that.mimeType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List imageData,  String mimeType)  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationResult():
return $default(_that.imageData,_that.mimeType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List imageData,  String mimeType)?  $default,) {final _that = this;
switch (_that) {
case _ImageGenerationResult() when $default != null:
return $default(_that.imageData,_that.mimeType);case _:
  return null;

}
}

}

/// @nodoc


class _ImageGenerationResult implements ImageGenerationResult {
  const _ImageGenerationResult({required this.imageData, required this.mimeType});
  

/// 画像のバイナリデータ
@override final  Uint8List imageData;
/// 画像のMIMEタイプ
@override final  String mimeType;

/// Create a copy of ImageGenerationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageGenerationResultCopyWith<_ImageGenerationResult> get copyWith => __$ImageGenerationResultCopyWithImpl<_ImageGenerationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageGenerationResult&&const DeepCollectionEquality().equals(other.imageData, imageData)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageData),mimeType);

@override
String toString() {
  return 'ImageGenerationResult(imageData: $imageData, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class _$ImageGenerationResultCopyWith<$Res> implements $ImageGenerationResultCopyWith<$Res> {
  factory _$ImageGenerationResultCopyWith(_ImageGenerationResult value, $Res Function(_ImageGenerationResult) _then) = __$ImageGenerationResultCopyWithImpl;
@override @useResult
$Res call({
 Uint8List imageData, String mimeType
});




}
/// @nodoc
class __$ImageGenerationResultCopyWithImpl<$Res>
    implements _$ImageGenerationResultCopyWith<$Res> {
  __$ImageGenerationResultCopyWithImpl(this._self, this._then);

  final _ImageGenerationResult _self;
  final $Res Function(_ImageGenerationResult) _then;

/// Create a copy of ImageGenerationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageData = null,Object? mimeType = null,}) {
  return _then(_ImageGenerationResult(
imageData: null == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as Uint8List,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
