// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_save_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageSaveState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSaveState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageSaveState()';
}


}

/// @nodoc
class $ImageSaveStateCopyWith<$Res>  {
$ImageSaveStateCopyWith(ImageSaveState _, $Res Function(ImageSaveState) __);
}


/// Adds pattern-matching-related methods to [ImageSaveState].
extension ImageSaveStatePatterns on ImageSaveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ImageSaveInitial value)?  initial,TResult Function( ImageSaveSaving value)?  saving,TResult Function( ImageSaveSuccess value)?  success,TResult Function( ImageSaveError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ImageSaveInitial() when initial != null:
return initial(_that);case ImageSaveSaving() when saving != null:
return saving(_that);case ImageSaveSuccess() when success != null:
return success(_that);case ImageSaveError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ImageSaveInitial value)  initial,required TResult Function( ImageSaveSaving value)  saving,required TResult Function( ImageSaveSuccess value)  success,required TResult Function( ImageSaveError value)  error,}){
final _that = this;
switch (_that) {
case ImageSaveInitial():
return initial(_that);case ImageSaveSaving():
return saving(_that);case ImageSaveSuccess():
return success(_that);case ImageSaveError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ImageSaveInitial value)?  initial,TResult? Function( ImageSaveSaving value)?  saving,TResult? Function( ImageSaveSuccess value)?  success,TResult? Function( ImageSaveError value)?  error,}){
final _that = this;
switch (_that) {
case ImageSaveInitial() when initial != null:
return initial(_that);case ImageSaveSaving() when saving != null:
return saving(_that);case ImageSaveSuccess() when success != null:
return success(_that);case ImageSaveError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  saving,TResult Function( String downloadUrl)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ImageSaveInitial() when initial != null:
return initial();case ImageSaveSaving() when saving != null:
return saving();case ImageSaveSuccess() when success != null:
return success(_that.downloadUrl);case ImageSaveError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  saving,required TResult Function( String downloadUrl)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ImageSaveInitial():
return initial();case ImageSaveSaving():
return saving();case ImageSaveSuccess():
return success(_that.downloadUrl);case ImageSaveError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  saving,TResult? Function( String downloadUrl)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ImageSaveInitial() when initial != null:
return initial();case ImageSaveSaving() when saving != null:
return saving();case ImageSaveSuccess() when success != null:
return success(_that.downloadUrl);case ImageSaveError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ImageSaveInitial implements ImageSaveState {
  const ImageSaveInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSaveInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageSaveState.initial()';
}


}




/// @nodoc


class ImageSaveSaving implements ImageSaveState {
  const ImageSaveSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSaveSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImageSaveState.saving()';
}


}




/// @nodoc


class ImageSaveSuccess implements ImageSaveState {
  const ImageSaveSuccess(this.downloadUrl);
  

 final  String downloadUrl;

/// Create a copy of ImageSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageSaveSuccessCopyWith<ImageSaveSuccess> get copyWith => _$ImageSaveSuccessCopyWithImpl<ImageSaveSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSaveSuccess&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}


@override
int get hashCode => Object.hash(runtimeType,downloadUrl);

@override
String toString() {
  return 'ImageSaveState.success(downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $ImageSaveSuccessCopyWith<$Res> implements $ImageSaveStateCopyWith<$Res> {
  factory $ImageSaveSuccessCopyWith(ImageSaveSuccess value, $Res Function(ImageSaveSuccess) _then) = _$ImageSaveSuccessCopyWithImpl;
@useResult
$Res call({
 String downloadUrl
});




}
/// @nodoc
class _$ImageSaveSuccessCopyWithImpl<$Res>
    implements $ImageSaveSuccessCopyWith<$Res> {
  _$ImageSaveSuccessCopyWithImpl(this._self, this._then);

  final ImageSaveSuccess _self;
  final $Res Function(ImageSaveSuccess) _then;

/// Create a copy of ImageSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? downloadUrl = null,}) {
  return _then(ImageSaveSuccess(
null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ImageSaveError implements ImageSaveState {
  const ImageSaveError(this.message);
  

 final  String message;

/// Create a copy of ImageSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageSaveErrorCopyWith<ImageSaveError> get copyWith => _$ImageSaveErrorCopyWithImpl<ImageSaveError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSaveError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ImageSaveState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ImageSaveErrorCopyWith<$Res> implements $ImageSaveStateCopyWith<$Res> {
  factory $ImageSaveErrorCopyWith(ImageSaveError value, $Res Function(ImageSaveError) _then) = _$ImageSaveErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ImageSaveErrorCopyWithImpl<$Res>
    implements $ImageSaveErrorCopyWith<$Res> {
  _$ImageSaveErrorCopyWithImpl(this._self, this._then);

  final ImageSaveError _self;
  final $Res Function(ImageSaveError) _then;

/// Create a copy of ImageSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ImageSaveError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
