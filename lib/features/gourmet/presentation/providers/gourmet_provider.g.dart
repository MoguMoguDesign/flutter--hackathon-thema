// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gourmet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// グルメメモの状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final memos = ref.watch(gourmetMemosProvider);
/// ```

@ProviderFor(GourmetMemos)
const gourmetMemosProvider = GourmetMemosProvider._();

/// グルメメモの状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final memos = ref.watch(gourmetMemosProvider);
/// ```
final class GourmetMemosProvider
    extends $NotifierProvider<GourmetMemos, List<String>> {
  /// グルメメモの状態を管理するProvider
  ///
  /// 使用例:
  /// ```dart
  /// final memos = ref.watch(gourmetMemosProvider);
  /// ```
  const GourmetMemosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gourmetMemosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gourmetMemosHash();

  @$internal
  @override
  GourmetMemos create() => GourmetMemos();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$gourmetMemosHash() => r'4108df4f6b711e0b8b7cc8f97f20c7992adf582c';

/// グルメメモの状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final memos = ref.watch(gourmetMemosProvider);
/// ```

abstract class _$GourmetMemos extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
