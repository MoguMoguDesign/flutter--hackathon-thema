// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 俳句詳細データを取得するプロバイダー
///
/// [haikuId] 取得する俳句のID
///
/// Firestoreから指定されたIDの俳句を取得します。
/// 俳句が存在しない場合はnullを返します。

@ProviderFor(haikuDetail)
const haikuDetailProvider = HaikuDetailFamily._();

/// 俳句詳細データを取得するプロバイダー
///
/// [haikuId] 取得する俳句のID
///
/// Firestoreから指定されたIDの俳句を取得します。
/// 俳句が存在しない場合はnullを返します。

final class HaikuDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<HaikuModel?>,
          HaikuModel?,
          FutureOr<HaikuModel?>
        >
    with $FutureModifier<HaikuModel?>, $FutureProvider<HaikuModel?> {
  /// 俳句詳細データを取得するプロバイダー
  ///
  /// [haikuId] 取得する俳句のID
  ///
  /// Firestoreから指定されたIDの俳句を取得します。
  /// 俳句が存在しない場合はnullを返します。
  const HaikuDetailProvider._({
    required HaikuDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'haikuDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$haikuDetailHash();

  @override
  String toString() {
    return r'haikuDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HaikuModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HaikuModel?> create(Ref ref) {
    final argument = this.argument as String;
    return haikuDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HaikuDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$haikuDetailHash() => r'2f5e2629f12812cf5d1f15c2e6bc58134cfed512';

/// 俳句詳細データを取得するプロバイダー
///
/// [haikuId] 取得する俳句のID
///
/// Firestoreから指定されたIDの俳句を取得します。
/// 俳句が存在しない場合はnullを返します。

final class HaikuDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HaikuModel?>, String> {
  const HaikuDetailFamily._()
    : super(
        retry: null,
        name: r'haikuDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 俳句詳細データを取得するプロバイダー
  ///
  /// [haikuId] 取得する俳句のID
  ///
  /// Firestoreから指定されたIDの俳句を取得します。
  /// 俳句が存在しない場合はnullを返します。

  HaikuDetailProvider call(String haikuId) =>
      HaikuDetailProvider._(argument: haikuId, from: this);

  @override
  String toString() => r'haikuDetailProvider';
}

/// いいね機能を管理するNotifier
///
/// いいねボタンのタップ時にFirestoreのいいね数を
/// インクリメントし、詳細データを再取得します。

@ProviderFor(LikeNotifier)
const likeProvider = LikeNotifierProvider._();

/// いいね機能を管理するNotifier
///
/// いいねボタンのタップ時にFirestoreのいいね数を
/// インクリメントし、詳細データを再取得します。
final class LikeNotifierProvider
    extends $AsyncNotifierProvider<LikeNotifier, void> {
  /// いいね機能を管理するNotifier
  ///
  /// いいねボタンのタップ時にFirestoreのいいね数を
  /// インクリメントし、詳細データを再取得します。
  const LikeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeNotifierHash();

  @$internal
  @override
  LikeNotifier create() => LikeNotifier();
}

String _$likeNotifierHash() => r'6d62b0179b473d1c18f3afdd5af3db00a7ec249b';

/// いいね機能を管理するNotifier
///
/// いいねボタンのタップ時にFirestoreのいいね数を
/// インクリメントし、詳細データを再取得します。

abstract class _$LikeNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
