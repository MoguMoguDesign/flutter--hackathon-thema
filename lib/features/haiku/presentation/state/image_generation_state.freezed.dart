// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_generation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageGenerationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageGenerationState()';
}


}

/// @nodoc
class $ImageGenerationStateCopyWith<$Res>  {
$ImageGenerationStateCopyWith(ImageGenerationState _, $Res Function(ImageGenerationState) __);
}


/// Adds pattern-matching-related methods to [ImageGenerationState].
extension ImageGenerationStatePatterns on ImageGenerationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ImageGenerationInitial value)?  initial,TResult Function( ImageGenerationLoading value)?  loading,TResult Function( ImageGenerationSuccess value)?  success,TResult Function( ImageGenerationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ImageGenerationInitial() when initial != null:
return initial(_that);case ImageGenerationLoading() when loading != null:
return loading(_that);case ImageGenerationSuccess() when success != null:
return success(_that);case ImageGenerationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ImageGenerationInitial value)  initial,required TResult Function( ImageGenerationLoading value)  loading,required TResult Function( ImageGenerationSuccess value)  success,required TResult Function( ImageGenerationError value)  error,}){
final _that = this;
switch (_that) {
case ImageGenerationInitial():
return initial(_that);case ImageGenerationLoading():
return loading(_that);case ImageGenerationSuccess():
return success(_that);case ImageGenerationError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ImageGenerationInitial value)?  initial,TResult? Function( ImageGenerationLoading value)?  loading,TResult? Function( ImageGenerationSuccess value)?  success,TResult? Function( ImageGenerationError value)?  error,}){
final _that = this;
switch (_that) {
case ImageGenerationInitial() when initial != null:
return initial(_that);case ImageGenerationLoading() when loading != null:
return loading(_that);case ImageGenerationSuccess() when success != null:
return success(_that);case ImageGenerationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( double progress)?  loading,TResult Function( Uint8List imageData)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ImageGenerationInitial() when initial != null:
return initial();case ImageGenerationLoading() when loading != null:
return loading(_that.progress);case ImageGenerationSuccess() when success != null:
return success(_that.imageData);case ImageGenerationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( double progress)  loading,required TResult Function( Uint8List imageData)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ImageGenerationInitial():
return initial();case ImageGenerationLoading():
return loading(_that.progress);case ImageGenerationSuccess():
return success(_that.imageData);case ImageGenerationError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( double progress)?  loading,TResult? Function( Uint8List imageData)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ImageGenerationInitial() when initial != null:
return initial();case ImageGenerationLoading() when loading != null:
return loading(_that.progress);case ImageGenerationSuccess() when success != null:
return success(_that.imageData);case ImageGenerationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ImageGenerationInitial implements ImageGenerationState {
  const ImageGenerationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageGenerationState.initial()';
}


}




/// @nodoc


class ImageGenerationLoading implements ImageGenerationState {
  const ImageGenerationLoading(this.progress);
  

 final  double progress;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationLoadingCopyWith<ImageGenerationLoading> get copyWith => _$ImageGenerationLoadingCopyWithImpl<ImageGenerationLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationLoading&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,progress);

@override
String toString() {
  return 'ImageGenerationState.loading(progress: $progress)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationLoadingCopyWith<$Res> implements $ImageGenerationStateCopyWith<$Res> {
  factory $ImageGenerationLoadingCopyWith(ImageGenerationLoading value, $Res Function(ImageGenerationLoading) _then) = _$ImageGenerationLoadingCopyWithImpl;
@useResult
$Res call({
 double progress
});




}
/// @nodoc
class _$ImageGenerationLoadingCopyWithImpl<$Res>
    implements $ImageGenerationLoadingCopyWith<$Res> {
  _$ImageGenerationLoadingCopyWithImpl(this._self, this._then);

  final ImageGenerationLoading _self;
  final $Res Function(ImageGenerationLoading) _then;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progress = null,}) {
  return _then(ImageGenerationLoading(
null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class ImageGenerationSuccess implements ImageGenerationState {
  const ImageGenerationSuccess(this.imageData);
  

 final  Uint8List imageData;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationSuccessCopyWith<ImageGenerationSuccess> get copyWith => _$ImageGenerationSuccessCopyWithImpl<ImageGenerationSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationSuccess&&const DeepCollectionEquality().equals(other.imageData, imageData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(imageData));

@override
String toString() {
  return 'ImageGenerationState.success(imageData: $imageData)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationSuccessCopyWith<$Res> implements $ImageGenerationStateCopyWith<$Res> {
  factory $ImageGenerationSuccessCopyWith(ImageGenerationSuccess value, $Res Function(ImageGenerationSuccess) _then) = _$ImageGenerationSuccessCopyWithImpl;
@useResult
$Res call({
 Uint8List imageData
});




}
/// @nodoc
class _$ImageGenerationSuccessCopyWithImpl<$Res>
    implements $ImageGenerationSuccessCopyWith<$Res> {
  _$ImageGenerationSuccessCopyWithImpl(this._self, this._then);

  final ImageGenerationSuccess _self;
  final $Res Function(ImageGenerationSuccess) _then;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageData = null,}) {
  return _then(ImageGenerationSuccess(
null == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class ImageGenerationError implements ImageGenerationState {
  const ImageGenerationError(this.message);
  

 final  String message;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageGenerationErrorCopyWith<ImageGenerationError> get copyWith => _$ImageGenerationErrorCopyWithImpl<ImageGenerationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageGenerationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ImageGenerationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ImageGenerationErrorCopyWith<$Res> implements $ImageGenerationStateCopyWith<$Res> {
  factory $ImageGenerationErrorCopyWith(ImageGenerationError value, $Res Function(ImageGenerationError) _then) = _$ImageGenerationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ImageGenerationErrorCopyWithImpl<$Res>
    implements $ImageGenerationErrorCopyWith<$Res> {
  _$ImageGenerationErrorCopyWithImpl(this._self, this._then);

  final ImageGenerationError _self;
  final $Res Function(ImageGenerationError) _then;

/// Create a copy of ImageGenerationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ImageGenerationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
