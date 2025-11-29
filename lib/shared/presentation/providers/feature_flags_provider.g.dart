// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flags_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリの機能フラグを管理するプロバイダー
///
/// 機能の有効/無効を動的に切り替えることができます

@ProviderFor(FeatureFlags)
const featureFlagsProvider = FeatureFlagsProvider._();

/// アプリの機能フラグを管理するプロバイダー
///
/// 機能の有効/無効を動的に切り替えることができます
final class FeatureFlagsProvider
    extends $NotifierProvider<FeatureFlags, FeatureFlagsState> {
  /// アプリの機能フラグを管理するプロバイダー
  ///
  /// 機能の有効/無効を動的に切り替えることができます
  const FeatureFlagsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'featureFlagsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$featureFlagsHash();

  @$internal
  @override
  FeatureFlags create() => FeatureFlags();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeatureFlagsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeatureFlagsState>(value),
    );
  }
}

String _$featureFlagsHash() => r'b86f6513acc51a2804e5d99653981612c9add9d1';

/// アプリの機能フラグを管理するプロバイダー
///
/// 機能の有効/無効を動的に切り替えることができます

abstract class _$FeatureFlags extends $Notifier<FeatureFlagsState> {
  FeatureFlagsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FeatureFlagsState, FeatureFlagsState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<FeatureFlagsState, FeatureFlagsState>,
        FeatureFlagsState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

/// いいね機能が有効かどうかを取得する便利なプロバイダー

@ProviderFor(isLikeFeatureEnabled)
const isLikeFeatureEnabledProvider = IsLikeFeatureEnabledProvider._();

/// いいね機能が有効かどうかを取得する便利なプロバイダー

final class IsLikeFeatureEnabledProvider
    extends $FunctionalProvider<bool, bool, bool> with $Provider<bool> {
  /// いいね機能が有効かどうかを取得する便利なプロバイダー
  const IsLikeFeatureEnabledProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isLikeFeatureEnabledProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isLikeFeatureEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLikeFeatureEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLikeFeatureEnabledHash() =>
    r'4da57ae7799db06e4beb0c87196b55578fe69a55';
