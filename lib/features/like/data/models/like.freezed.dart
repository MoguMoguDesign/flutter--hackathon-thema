// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Like {
  /// いいねID（UUIDで自動生成）
  String get id;

  /// いいねしたユーザーのID
  String get userId;

  /// いいねされた俳句のID
  String get haikuId;

  /// いいねした日時
  DateTime get createdAt;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LikeCopyWith<Like> get copyWith =>
      _$LikeCopyWithImpl<Like>(this as Like, _$identity);

  /// Serializes this Like to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Like &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.haikuId, haikuId) || other.haikuId == haikuId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, haikuId, createdAt);

  @override
  String toString() {
    return 'Like(id: $id, userId: $userId, haikuId: $haikuId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LikeCopyWith<$Res> {
  factory $LikeCopyWith(Like value, $Res Function(Like) _then) =
      _$LikeCopyWithImpl;
  @useResult
  $Res call({String id, String userId, String haikuId, DateTime createdAt});
}

/// @nodoc
class _$LikeCopyWithImpl<$Res> implements $LikeCopyWith<$Res> {
  _$LikeCopyWithImpl(this._self, this._then);

  final Like _self;
  final $Res Function(Like) _then;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? haikuId = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      haikuId: null == haikuId
          ? _self.haikuId
          : haikuId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [Like].
extension LikePatterns on Like {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Like value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Like() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Like value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Like():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Like value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Like() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id, String userId, String haikuId, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Like() when $default != null:
        return $default(_that.id, _that.userId, _that.haikuId, _that.createdAt);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id, String userId, String haikuId, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Like():
        return $default(_that.id, _that.userId, _that.haikuId, _that.createdAt);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id, String userId, String haikuId, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Like() when $default != null:
        return $default(_that.id, _that.userId, _that.haikuId, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Like extends Like {
  const _Like(
      {required this.id,
      required this.userId,
      required this.haikuId,
      required this.createdAt})
      : super._();
  factory _Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);

  /// いいねID（UUIDで自動生成）
  @override
  final String id;

  /// いいねしたユーザーのID
  @override
  final String userId;

  /// いいねされた俳句のID
  @override
  final String haikuId;

  /// いいねした日時
  @override
  final DateTime createdAt;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LikeCopyWith<_Like> get copyWith =>
      __$LikeCopyWithImpl<_Like>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LikeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Like &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.haikuId, haikuId) || other.haikuId == haikuId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, haikuId, createdAt);

  @override
  String toString() {
    return 'Like(id: $id, userId: $userId, haikuId: $haikuId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LikeCopyWith<$Res> implements $LikeCopyWith<$Res> {
  factory _$LikeCopyWith(_Like value, $Res Function(_Like) _then) =
      __$LikeCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String userId, String haikuId, DateTime createdAt});
}

/// @nodoc
class __$LikeCopyWithImpl<$Res> implements _$LikeCopyWith<$Res> {
  __$LikeCopyWithImpl(this._self, this._then);

  final _Like _self;
  final $Res Function(_Like) _then;

  /// Create a copy of Like
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? haikuId = null,
    Object? createdAt = null,
  }) {
    return _then(_Like(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      haikuId: null == haikuId
          ? _self.haikuId
          : haikuId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
