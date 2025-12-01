// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_functions_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// FirebaseFunctionsService プロバイダー
///
/// [FirebaseFunctionsService] のインスタンスを提供する。

@ProviderFor(firebaseFunctionsService)
const firebaseFunctionsServiceProvider = FirebaseFunctionsServiceProvider._();

/// FirebaseFunctionsService プロバイダー
///
/// [FirebaseFunctionsService] のインスタンスを提供する。

final class FirebaseFunctionsServiceProvider
    extends
        $FunctionalProvider<
          FirebaseFunctionsService,
          FirebaseFunctionsService,
          FirebaseFunctionsService
        >
    with $Provider<FirebaseFunctionsService> {
  /// FirebaseFunctionsService プロバイダー
  ///
  /// [FirebaseFunctionsService] のインスタンスを提供する。
  const FirebaseFunctionsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseFunctionsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseFunctionsServiceHash();

  @$internal
  @override
  $ProviderElement<FirebaseFunctionsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseFunctionsService create(Ref ref) {
    return firebaseFunctionsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFunctionsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFunctionsService>(value),
    );
  }
}

String _$firebaseFunctionsServiceHash() =>
    r'4d840261532538fac04e9ff418d380dc6fdcdb1e';
