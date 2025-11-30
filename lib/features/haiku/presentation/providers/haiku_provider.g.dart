// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HaikuRepositoryのプロバイダー
///
/// [HaikuRepository]のインスタンスを提供します。

@ProviderFor(haikuRepository)
const haikuRepositoryProvider = HaikuRepositoryProvider._();

/// HaikuRepositoryのプロバイダー
///
/// [HaikuRepository]のインスタンスを提供します。

final class HaikuRepositoryProvider
    extends
        $FunctionalProvider<HaikuRepository, HaikuRepository, HaikuRepository>
    with $Provider<HaikuRepository> {
  /// HaikuRepositoryのプロバイダー
  ///
  /// [HaikuRepository]のインスタンスを提供します。
  const HaikuRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuRepositoryHash();

  @$internal
  @override
  $ProviderElement<HaikuRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HaikuRepository create(Ref ref) {
    return haikuRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HaikuRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HaikuRepository>(value),
    );
  }
}

String _$haikuRepositoryHash() => r'a9744e8f7b6ae91b2dc3ae176440224ca2071bf8';

/// 俳句一覧のストリームプロバイダー
///
/// Firestoreから俳句一覧をリアルタイムで監視します

@ProviderFor(haikuListStream)
const haikuListStreamProvider = HaikuListStreamProvider._();

/// 俳句一覧のストリームプロバイダー
///
/// Firestoreから俳句一覧をリアルタイムで監視します

final class HaikuListStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HaikuModel>>,
          List<HaikuModel>,
          Stream<List<HaikuModel>>
        >
    with $FutureModifier<List<HaikuModel>>, $StreamProvider<List<HaikuModel>> {
  /// 俳句一覧のストリームプロバイダー
  ///
  /// Firestoreから俳句一覧をリアルタイムで監視します
  const HaikuListStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuListStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuListStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<HaikuModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HaikuModel>> create(Ref ref) {
    return haikuListStream(ref);
  }
}

String _$haikuListStreamHash() => r'6d26ca5f57c81b59771ef7ab0e710db9da4bd3d6';

/// 俳句保存の状態管理プロバイダー
///
/// 俳句のFirestore保存処理とその状態を管理します。
/// [AsyncValue]を使用して、ローディング・成功・エラー状態を表現します。

@ProviderFor(HaikuNotifier)
const haikuProvider = HaikuNotifierProvider._();

/// 俳句保存の状態管理プロバイダー
///
/// 俳句のFirestore保存処理とその状態を管理します。
/// [AsyncValue]を使用して、ローディング・成功・エラー状態を表現します。
final class HaikuNotifierProvider
    extends $AsyncNotifierProvider<HaikuNotifier, String?> {
  /// 俳句保存の状態管理プロバイダー
  ///
  /// 俳句のFirestore保存処理とその状態を管理します。
  /// [AsyncValue]を使用して、ローディング・成功・エラー状態を表現します。
  const HaikuNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuNotifierHash();

  @$internal
  @override
  HaikuNotifier create() => HaikuNotifier();
}

String _$haikuNotifierHash() => r'99af5fce5c6fdb36d212d65c7880db9da3d78246';

/// 俳句保存の状態管理プロバイダー
///
/// 俳句のFirestore保存処理とその状態を管理します。
/// [AsyncValue]を使用して、ローディング・成功・エラー状態を表現します。

abstract class _$HaikuNotifier extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
