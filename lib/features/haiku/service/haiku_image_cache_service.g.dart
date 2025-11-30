// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_image_cache_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HaikuImageCacheServiceのプロバイダー

@ProviderFor(haikuImageCacheService)
const haikuImageCacheServiceProvider = HaikuImageCacheServiceProvider._();

/// HaikuImageCacheServiceのプロバイダー

final class HaikuImageCacheServiceProvider
    extends
        $FunctionalProvider<
          HaikuImageCacheService,
          HaikuImageCacheService,
          HaikuImageCacheService
        >
    with $Provider<HaikuImageCacheService> {
  /// HaikuImageCacheServiceのプロバイダー
  const HaikuImageCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuImageCacheServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuImageCacheServiceHash();

  @$internal
  @override
  $ProviderElement<HaikuImageCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HaikuImageCacheService create(Ref ref) {
    return haikuImageCacheService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HaikuImageCacheService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HaikuImageCacheService>(value),
    );
  }
}

String _$haikuImageCacheServiceHash() =>
    r'3ed739d91512e3ac2ca14671a06bca0d1cb4d429';
