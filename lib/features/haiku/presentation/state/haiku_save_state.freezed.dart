// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'haiku_save_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HaikuSaveState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HaikuSaveState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HaikuSaveState()';
}


}

/// @nodoc
class $HaikuSaveStateCopyWith<$Res>  {
$HaikuSaveStateCopyWith(HaikuSaveState _, $Res Function(HaikuSaveState) __);
}


/// Adds pattern-matching-related methods to [HaikuSaveState].
extension HaikuSaveStatePatterns on HaikuSaveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _SavingToCache value)?  savingToCache,TResult Function( _CachedLocally value)?  cachedLocally,TResult Function( _SavingToFirebase value)?  savingToFirebase,TResult Function( _Saved value)?  saved,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SavingToCache() when savingToCache != null:
return savingToCache(_that);case _CachedLocally() when cachedLocally != null:
return cachedLocally(_that);case _SavingToFirebase() when savingToFirebase != null:
return savingToFirebase(_that);case _Saved() when saved != null:
return saved(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _SavingToCache value)  savingToCache,required TResult Function( _CachedLocally value)  cachedLocally,required TResult Function( _SavingToFirebase value)  savingToFirebase,required TResult Function( _Saved value)  saved,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _SavingToCache():
return savingToCache(_that);case _CachedLocally():
return cachedLocally(_that);case _SavingToFirebase():
return savingToFirebase(_that);case _Saved():
return saved(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _SavingToCache value)?  savingToCache,TResult? Function( _CachedLocally value)?  cachedLocally,TResult? Function( _SavingToFirebase value)?  savingToFirebase,TResult? Function( _Saved value)?  saved,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _SavingToCache() when savingToCache != null:
return savingToCache(_that);case _CachedLocally() when cachedLocally != null:
return cachedLocally(_that);case _SavingToFirebase() when savingToFirebase != null:
return savingToFirebase(_that);case _Saved() when saved != null:
return saved(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( HaikuModel haiku)?  savingToCache,TResult Function( HaikuModel haiku,  String localImagePath)?  cachedLocally,TResult Function( HaikuModel haiku,  String localImagePath)?  savingToFirebase,TResult Function( HaikuModel haiku,  String localImagePath,  String firebaseImageUrl)?  saved,TResult Function( String message,  HaikuModel? haiku,  String? localImagePath)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _SavingToCache() when savingToCache != null:
return savingToCache(_that.haiku);case _CachedLocally() when cachedLocally != null:
return cachedLocally(_that.haiku,_that.localImagePath);case _SavingToFirebase() when savingToFirebase != null:
return savingToFirebase(_that.haiku,_that.localImagePath);case _Saved() when saved != null:
return saved(_that.haiku,_that.localImagePath,_that.firebaseImageUrl);case _Error() when error != null:
return error(_that.message,_that.haiku,_that.localImagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( HaikuModel haiku)  savingToCache,required TResult Function( HaikuModel haiku,  String localImagePath)  cachedLocally,required TResult Function( HaikuModel haiku,  String localImagePath)  savingToFirebase,required TResult Function( HaikuModel haiku,  String localImagePath,  String firebaseImageUrl)  saved,required TResult Function( String message,  HaikuModel? haiku,  String? localImagePath)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _SavingToCache():
return savingToCache(_that.haiku);case _CachedLocally():
return cachedLocally(_that.haiku,_that.localImagePath);case _SavingToFirebase():
return savingToFirebase(_that.haiku,_that.localImagePath);case _Saved():
return saved(_that.haiku,_that.localImagePath,_that.firebaseImageUrl);case _Error():
return error(_that.message,_that.haiku,_that.localImagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( HaikuModel haiku)?  savingToCache,TResult? Function( HaikuModel haiku,  String localImagePath)?  cachedLocally,TResult? Function( HaikuModel haiku,  String localImagePath)?  savingToFirebase,TResult? Function( HaikuModel haiku,  String localImagePath,  String firebaseImageUrl)?  saved,TResult? Function( String message,  HaikuModel? haiku,  String? localImagePath)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _SavingToCache() when savingToCache != null:
return savingToCache(_that.haiku);case _CachedLocally() when cachedLocally != null:
return cachedLocally(_that.haiku,_that.localImagePath);case _SavingToFirebase() when savingToFirebase != null:
return savingToFirebase(_that.haiku,_that.localImagePath);case _Saved() when saved != null:
return saved(_that.haiku,_that.localImagePath,_that.firebaseImageUrl);case _Error() when error != null:
return error(_that.message,_that.haiku,_that.localImagePath);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HaikuSaveState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HaikuSaveState.initial()';
}


}




/// @nodoc


class _SavingToCache implements HaikuSaveState {
  const _SavingToCache({required this.haiku});
  

 final  HaikuModel haiku;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingToCacheCopyWith<_SavingToCache> get copyWith => __$SavingToCacheCopyWithImpl<_SavingToCache>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingToCache&&(identical(other.haiku, haiku) || other.haiku == haiku));
}


@override
int get hashCode => Object.hash(runtimeType,haiku);

@override
String toString() {
  return 'HaikuSaveState.savingToCache(haiku: $haiku)';
}


}

/// @nodoc
abstract mixin class _$SavingToCacheCopyWith<$Res> implements $HaikuSaveStateCopyWith<$Res> {
  factory _$SavingToCacheCopyWith(_SavingToCache value, $Res Function(_SavingToCache) _then) = __$SavingToCacheCopyWithImpl;
@useResult
$Res call({
 HaikuModel haiku
});




}
/// @nodoc
class __$SavingToCacheCopyWithImpl<$Res>
    implements _$SavingToCacheCopyWith<$Res> {
  __$SavingToCacheCopyWithImpl(this._self, this._then);

  final _SavingToCache _self;
  final $Res Function(_SavingToCache) _then;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? haiku = null,}) {
  return _then(_SavingToCache(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as HaikuModel,
  ));
}


}

/// @nodoc


class _CachedLocally implements HaikuSaveState {
  const _CachedLocally({required this.haiku, required this.localImagePath});
  

 final  HaikuModel haiku;
 final  String localImagePath;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CachedLocallyCopyWith<_CachedLocally> get copyWith => __$CachedLocallyCopyWithImpl<_CachedLocally>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CachedLocally&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}


@override
int get hashCode => Object.hash(runtimeType,haiku,localImagePath);

@override
String toString() {
  return 'HaikuSaveState.cachedLocally(haiku: $haiku, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class _$CachedLocallyCopyWith<$Res> implements $HaikuSaveStateCopyWith<$Res> {
  factory _$CachedLocallyCopyWith(_CachedLocally value, $Res Function(_CachedLocally) _then) = __$CachedLocallyCopyWithImpl;
@useResult
$Res call({
 HaikuModel haiku, String localImagePath
});




}
/// @nodoc
class __$CachedLocallyCopyWithImpl<$Res>
    implements _$CachedLocallyCopyWith<$Res> {
  __$CachedLocallyCopyWithImpl(this._self, this._then);

  final _CachedLocally _self;
  final $Res Function(_CachedLocally) _then;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? haiku = null,Object? localImagePath = null,}) {
  return _then(_CachedLocally(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as HaikuModel,localImagePath: null == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SavingToFirebase implements HaikuSaveState {
  const _SavingToFirebase({required this.haiku, required this.localImagePath});
  

 final  HaikuModel haiku;
 final  String localImagePath;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingToFirebaseCopyWith<_SavingToFirebase> get copyWith => __$SavingToFirebaseCopyWithImpl<_SavingToFirebase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingToFirebase&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}


@override
int get hashCode => Object.hash(runtimeType,haiku,localImagePath);

@override
String toString() {
  return 'HaikuSaveState.savingToFirebase(haiku: $haiku, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class _$SavingToFirebaseCopyWith<$Res> implements $HaikuSaveStateCopyWith<$Res> {
  factory _$SavingToFirebaseCopyWith(_SavingToFirebase value, $Res Function(_SavingToFirebase) _then) = __$SavingToFirebaseCopyWithImpl;
@useResult
$Res call({
 HaikuModel haiku, String localImagePath
});




}
/// @nodoc
class __$SavingToFirebaseCopyWithImpl<$Res>
    implements _$SavingToFirebaseCopyWith<$Res> {
  __$SavingToFirebaseCopyWithImpl(this._self, this._then);

  final _SavingToFirebase _self;
  final $Res Function(_SavingToFirebase) _then;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? haiku = null,Object? localImagePath = null,}) {
  return _then(_SavingToFirebase(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as HaikuModel,localImagePath: null == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Saved implements HaikuSaveState {
  const _Saved({required this.haiku, required this.localImagePath, required this.firebaseImageUrl});
  

 final  HaikuModel haiku;
 final  String localImagePath;
 final  String firebaseImageUrl;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedCopyWith<_Saved> get copyWith => __$SavedCopyWithImpl<_Saved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Saved&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath)&&(identical(other.firebaseImageUrl, firebaseImageUrl) || other.firebaseImageUrl == firebaseImageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,haiku,localImagePath,firebaseImageUrl);

@override
String toString() {
  return 'HaikuSaveState.saved(haiku: $haiku, localImagePath: $localImagePath, firebaseImageUrl: $firebaseImageUrl)';
}


}

/// @nodoc
abstract mixin class _$SavedCopyWith<$Res> implements $HaikuSaveStateCopyWith<$Res> {
  factory _$SavedCopyWith(_Saved value, $Res Function(_Saved) _then) = __$SavedCopyWithImpl;
@useResult
$Res call({
 HaikuModel haiku, String localImagePath, String firebaseImageUrl
});




}
/// @nodoc
class __$SavedCopyWithImpl<$Res>
    implements _$SavedCopyWith<$Res> {
  __$SavedCopyWithImpl(this._self, this._then);

  final _Saved _self;
  final $Res Function(_Saved) _then;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? haiku = null,Object? localImagePath = null,Object? firebaseImageUrl = null,}) {
  return _then(_Saved(
haiku: null == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as HaikuModel,localImagePath: null == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String,firebaseImageUrl: null == firebaseImageUrl ? _self.firebaseImageUrl : firebaseImageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements HaikuSaveState {
  const _Error({required this.message, this.haiku, this.localImagePath});
  

 final  String message;
 final  HaikuModel? haiku;
 final  String? localImagePath;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message)&&(identical(other.haiku, haiku) || other.haiku == haiku)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}


@override
int get hashCode => Object.hash(runtimeType,message,haiku,localImagePath);

@override
String toString() {
  return 'HaikuSaveState.error(message: $message, haiku: $haiku, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $HaikuSaveStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message, HaikuModel? haiku, String? localImagePath
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of HaikuSaveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? haiku = freezed,Object? localImagePath = freezed,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,haiku: freezed == haiku ? _self.haiku : haiku // ignore: cast_nullable_to_non_nullable
as HaikuModel?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
