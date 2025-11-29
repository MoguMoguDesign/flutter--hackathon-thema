// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'haiku.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Haiku {

/// 俳句ID（UUIDで自動生成）
 String get id;

/// 投稿者のユーザーID
 String get userId;

/// 投稿者のニックネーム（キャッシュ用）
 String get authorNickname;

/// 俳句の文字（完全な文章）
 String get text;

/// 上の句（5文字）
 String get firstLine;

/// 中の句（7文字）
 String get secondLine;

/// 下の句（5文字）
 String get thirdLine;

/// 俳句の画像URL
 String get imageUrl;

/// 作成日時
 DateTime get createdAt;

/// 最終更新日時
 DateTime get updatedAt;

/// タグ（オプション）
 List<String> get tags;

/// 季語（オプション）
 String? get seasonWord;
/// Create a copy of Haiku
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HaikuCopyWith<Haiku> get copyWith => _$HaikuCopyWithImpl<Haiku>(this as Haiku, _$identity);

  /// Serializes this Haiku to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Haiku&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.text, text) || other.text == text)&&(identical(other.firstLine, firstLine) || other.firstLine == firstLine)&&(identical(other.secondLine, secondLine) || other.secondLine == secondLine)&&(identical(other.thirdLine, thirdLine) || other.thirdLine == thirdLine)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.seasonWord, seasonWord) || other.seasonWord == seasonWord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorNickname,text,firstLine,secondLine,thirdLine,imageUrl,createdAt,updatedAt,const DeepCollectionEquality().hash(tags),seasonWord);

@override
String toString() {
  return 'Haiku(id: $id, userId: $userId, authorNickname: $authorNickname, text: $text, firstLine: $firstLine, secondLine: $secondLine, thirdLine: $thirdLine, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags, seasonWord: $seasonWord)';
}


}

/// @nodoc
abstract mixin class $HaikuCopyWith<$Res>  {
  factory $HaikuCopyWith(Haiku value, $Res Function(Haiku) _then) = _$HaikuCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String authorNickname, String text, String firstLine, String secondLine, String thirdLine, String imageUrl, DateTime createdAt, DateTime updatedAt, List<String> tags, String? seasonWord
});




}
/// @nodoc
class _$HaikuCopyWithImpl<$Res>
    implements $HaikuCopyWith<$Res> {
  _$HaikuCopyWithImpl(this._self, this._then);

  final Haiku _self;
  final $Res Function(Haiku) _then;

/// Create a copy of Haiku
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? authorNickname = null,Object? text = null,Object? firstLine = null,Object? secondLine = null,Object? thirdLine = null,Object? imageUrl = null,Object? createdAt = null,Object? updatedAt = null,Object? tags = null,Object? seasonWord = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorNickname: null == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,firstLine: null == firstLine ? _self.firstLine : firstLine // ignore: cast_nullable_to_non_nullable
as String,secondLine: null == secondLine ? _self.secondLine : secondLine // ignore: cast_nullable_to_non_nullable
as String,thirdLine: null == thirdLine ? _self.thirdLine : thirdLine // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,seasonWord: freezed == seasonWord ? _self.seasonWord : seasonWord // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Haiku].
extension HaikuPatterns on Haiku {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Haiku value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Haiku() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Haiku value)  $default,){
final _that = this;
switch (_that) {
case _Haiku():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Haiku value)?  $default,){
final _that = this;
switch (_that) {
case _Haiku() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String authorNickname,  String text,  String firstLine,  String secondLine,  String thirdLine,  String imageUrl,  DateTime createdAt,  DateTime updatedAt,  List<String> tags,  String? seasonWord)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Haiku() when $default != null:
return $default(_that.id,_that.userId,_that.authorNickname,_that.text,_that.firstLine,_that.secondLine,_that.thirdLine,_that.imageUrl,_that.createdAt,_that.updatedAt,_that.tags,_that.seasonWord);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String authorNickname,  String text,  String firstLine,  String secondLine,  String thirdLine,  String imageUrl,  DateTime createdAt,  DateTime updatedAt,  List<String> tags,  String? seasonWord)  $default,) {final _that = this;
switch (_that) {
case _Haiku():
return $default(_that.id,_that.userId,_that.authorNickname,_that.text,_that.firstLine,_that.secondLine,_that.thirdLine,_that.imageUrl,_that.createdAt,_that.updatedAt,_that.tags,_that.seasonWord);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String authorNickname,  String text,  String firstLine,  String secondLine,  String thirdLine,  String imageUrl,  DateTime createdAt,  DateTime updatedAt,  List<String> tags,  String? seasonWord)?  $default,) {final _that = this;
switch (_that) {
case _Haiku() when $default != null:
return $default(_that.id,_that.userId,_that.authorNickname,_that.text,_that.firstLine,_that.secondLine,_that.thirdLine,_that.imageUrl,_that.createdAt,_that.updatedAt,_that.tags,_that.seasonWord);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Haiku extends Haiku {
  const _Haiku({required this.id, required this.userId, required this.authorNickname, required this.text, required this.firstLine, required this.secondLine, required this.thirdLine, required this.imageUrl, required this.createdAt, required this.updatedAt, final  List<String> tags = const [], this.seasonWord}): _tags = tags,super._();
  factory _Haiku.fromJson(Map<String, dynamic> json) => _$HaikuFromJson(json);

/// 俳句ID（UUIDで自動生成）
@override final  String id;
/// 投稿者のユーザーID
@override final  String userId;
/// 投稿者のニックネーム（キャッシュ用）
@override final  String authorNickname;
/// 俳句の文字（完全な文章）
@override final  String text;
/// 上の句（5文字）
@override final  String firstLine;
/// 中の句（7文字）
@override final  String secondLine;
/// 下の句（5文字）
@override final  String thirdLine;
/// 俳句の画像URL
@override final  String imageUrl;
/// 作成日時
@override final  DateTime createdAt;
/// 最終更新日時
@override final  DateTime updatedAt;
/// タグ（オプション）
 final  List<String> _tags;
/// タグ（オプション）
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// 季語（オプション）
@override final  String? seasonWord;

/// Create a copy of Haiku
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HaikuCopyWith<_Haiku> get copyWith => __$HaikuCopyWithImpl<_Haiku>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HaikuToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Haiku&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.text, text) || other.text == text)&&(identical(other.firstLine, firstLine) || other.firstLine == firstLine)&&(identical(other.secondLine, secondLine) || other.secondLine == secondLine)&&(identical(other.thirdLine, thirdLine) || other.thirdLine == thirdLine)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.seasonWord, seasonWord) || other.seasonWord == seasonWord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorNickname,text,firstLine,secondLine,thirdLine,imageUrl,createdAt,updatedAt,const DeepCollectionEquality().hash(_tags),seasonWord);

@override
String toString() {
  return 'Haiku(id: $id, userId: $userId, authorNickname: $authorNickname, text: $text, firstLine: $firstLine, secondLine: $secondLine, thirdLine: $thirdLine, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags, seasonWord: $seasonWord)';
}


}

/// @nodoc
abstract mixin class _$HaikuCopyWith<$Res> implements $HaikuCopyWith<$Res> {
  factory _$HaikuCopyWith(_Haiku value, $Res Function(_Haiku) _then) = __$HaikuCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String authorNickname, String text, String firstLine, String secondLine, String thirdLine, String imageUrl, DateTime createdAt, DateTime updatedAt, List<String> tags, String? seasonWord
});




}
/// @nodoc
class __$HaikuCopyWithImpl<$Res>
    implements _$HaikuCopyWith<$Res> {
  __$HaikuCopyWithImpl(this._self, this._then);

  final _Haiku _self;
  final $Res Function(_Haiku) _then;

/// Create a copy of Haiku
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? authorNickname = null,Object? text = null,Object? firstLine = null,Object? secondLine = null,Object? thirdLine = null,Object? imageUrl = null,Object? createdAt = null,Object? updatedAt = null,Object? tags = null,Object? seasonWord = freezed,}) {
  return _then(_Haiku(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorNickname: null == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,firstLine: null == firstLine ? _self.firstLine : firstLine // ignore: cast_nullable_to_non_nullable
as String,secondLine: null == secondLine ? _self.secondLine : secondLine // ignore: cast_nullable_to_non_nullable
as String,thirdLine: null == thirdLine ? _self.thirdLine : thirdLine // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,seasonWord: freezed == seasonWord ? _self.seasonWord : seasonWord // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
