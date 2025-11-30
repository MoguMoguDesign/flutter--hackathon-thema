// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haiku_save_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 俳句保存を管理するNotifier
///
/// ローカルキャッシュへの即座の保存とFirebaseへのバックグラウンド保存を調整します。

@ProviderFor(HaikuSaveNotifier)
const haikuSaveProvider = HaikuSaveNotifierProvider._();

/// 俳句保存を管理するNotifier
///
/// ローカルキャッシュへの即座の保存とFirebaseへのバックグラウンド保存を調整します。
final class HaikuSaveNotifierProvider
    extends $NotifierProvider<HaikuSaveNotifier, HaikuSaveState> {
  /// 俳句保存を管理するNotifier
  ///
  /// ローカルキャッシュへの即座の保存とFirebaseへのバックグラウンド保存を調整します。
  const HaikuSaveNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'haikuSaveProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$haikuSaveNotifierHash();

  @$internal
  @override
  HaikuSaveNotifier create() => HaikuSaveNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HaikuSaveState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HaikuSaveState>(value),
    );
  }
}

String _$haikuSaveNotifierHash() => r'880b54e97345da2543f82ad15b140b3f514c84e0';

/// 俳句保存を管理するNotifier
///
/// ローカルキャッシュへの即座の保存とFirebaseへのバックグラウンド保存を調整します。

abstract class _$HaikuSaveNotifier extends $Notifier<HaikuSaveState> {
  HaikuSaveState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<HaikuSaveState, HaikuSaveState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HaikuSaveState, HaikuSaveState>,
              HaikuSaveState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
