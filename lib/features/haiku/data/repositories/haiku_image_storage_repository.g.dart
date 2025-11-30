// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_image_storage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HaikuImageStorageRepositoryのプロバイダー

@ProviderFor(haikuImageStorageRepository)
const haikuImageStorageRepositoryProvider =
    HaikuImageStorageRepositoryProvider._();

/// HaikuImageStorageRepositoryのプロバイダー

final class HaikuImageStorageRepositoryProvider
    extends
        $FunctionalProvider<
          HaikuImageStorageRepository,
          HaikuImageStorageRepository,
          HaikuImageStorageRepository
        >
    with $Provider<HaikuImageStorageRepository> {
  /// HaikuImageStorageRepositoryのプロバイダー
  const HaikuImageStorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuImageStorageRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuImageStorageRepositoryHash();

  @$internal
  @override
  $ProviderElement<HaikuImageStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HaikuImageStorageRepository create(Ref ref) {
    return haikuImageStorageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HaikuImageStorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HaikuImageStorageRepository>(value),
    );
  }
}

String _$haikuImageStorageRepositoryHash() =>
    r'a3392856f6c6cb101e5f052f6afbaf5120b30e44';
