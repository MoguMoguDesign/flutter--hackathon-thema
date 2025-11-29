// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

@ProviderFor(NicknameRepositoryNotifier)
const nicknameRepositoryProvider = NicknameRepositoryNotifierProvider._();

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
final class NicknameRepositoryNotifierProvider
    extends $NotifierProvider<NicknameRepositoryNotifier, NicknameRepository> {
  /// ニックネームリポジトリのプロバイダー
  ///
  /// NicknameRepositoryのインスタンスを提供します。
  /// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
  const NicknameRepositoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nicknameRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nicknameRepositoryNotifierHash();

  @$internal
  @override
  NicknameRepositoryNotifier create() => NicknameRepositoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NicknameRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NicknameRepository>(value),
    );
  }
}

String _$nicknameRepositoryNotifierHash() =>
    r'9dca83c4e680b264160d7f573185e31dcb2c5b6b';

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

abstract class _$NicknameRepositoryNotifier
    extends $Notifier<NicknameRepository> {
  NicknameRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NicknameRepository, NicknameRepository>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NicknameRepository, NicknameRepository>,
              NicknameRepository,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に SharedPreferences からニックネームを読み込み、
/// 状態を管理します。
///
/// 使用例:
/// ```dart
/// // ニックネームを取得
/// final nicknameAsync = ref.watch(nicknameNotifierProvider);
///
/// // ニックネームを設定
/// await ref.read(nicknameNotifierProvider.notifier).setNickname('ユーザー名');
/// ```

@ProviderFor(NicknameNotifier)
const nicknameProvider = NicknameNotifierProvider._();

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に SharedPreferences からニックネームを読み込み、
/// 状態を管理します。
///
/// 使用例:
/// ```dart
/// // ニックネームを取得
/// final nicknameAsync = ref.watch(nicknameNotifierProvider);
///
/// // ニックネームを設定
/// await ref.read(nicknameNotifierProvider.notifier).setNickname('ユーザー名');
/// ```
final class NicknameNotifierProvider
    extends $AsyncNotifierProvider<NicknameNotifier, String?> {
  /// ニックネームの状態を管理するプロバイダー
  ///
  /// アプリ起動時に SharedPreferences からニックネームを読み込み、
  /// 状態を管理します。
  ///
  /// 使用例:
  /// ```dart
  /// // ニックネームを取得
  /// final nicknameAsync = ref.watch(nicknameNotifierProvider);
  ///
  /// // ニックネームを設定
  /// await ref.read(nicknameNotifierProvider.notifier).setNickname('ユーザー名');
  /// ```
  const NicknameNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nicknameProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nicknameNotifierHash();

  @$internal
  @override
  NicknameNotifier create() => NicknameNotifier();
}

String _$nicknameNotifierHash() => r'0567fe5407b4f92d2501fded3e56aea3f75e4d10';

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に SharedPreferences からニックネームを読み込み、
/// 状態を管理します。
///
/// 使用例:
/// ```dart
/// // ニックネームを取得
/// final nicknameAsync = ref.watch(nicknameNotifierProvider);
///
/// // ニックネームを設定
/// await ref.read(nicknameNotifierProvider.notifier).setNickname('ユーザー名');
/// ```

abstract class _$NicknameNotifier extends $AsyncNotifier<String?> {
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
