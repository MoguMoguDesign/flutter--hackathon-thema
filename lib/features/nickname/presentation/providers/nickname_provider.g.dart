// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ユーザーIDサービスのプロバイダー
///
/// UserIdServiceのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

@ProviderFor(userIdService)
const userIdServiceProvider = UserIdServiceProvider._();

/// ユーザーIDサービスのプロバイダー
///
/// UserIdServiceのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

final class UserIdServiceProvider
    extends $FunctionalProvider<UserIdService, UserIdService, UserIdService>
    with $Provider<UserIdService> {
  /// ユーザーIDサービスのプロバイダー
  ///
  /// UserIdServiceのインスタンスを提供します。
  /// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
  const UserIdServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userIdServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userIdServiceHash();

  @$internal
  @override
  $ProviderElement<UserIdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserIdService create(Ref ref) {
    return userIdService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserIdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserIdService>(value),
    );
  }
}

String _$userIdServiceHash() => r'db9f5fd46b2d6bbc9929fdda25e9df2764f40d96';

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

@ProviderFor(nicknameRepository)
const nicknameRepositoryProvider = NicknameRepositoryProvider._();

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。

final class NicknameRepositoryProvider
    extends
        $FunctionalProvider<
          NicknameRepository,
          NicknameRepository,
          NicknameRepository
        >
    with $Provider<NicknameRepository> {
  /// ニックネームリポジトリのプロバイダー
  ///
  /// NicknameRepositoryのインスタンスを提供します。
  /// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
  const NicknameRepositoryProvider._()
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
  String debugGetCreateSourceHash() => _$nicknameRepositoryHash();

  @$internal
  @override
  $ProviderElement<NicknameRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NicknameRepository create(Ref ref) {
    return nicknameRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NicknameRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NicknameRepository>(value),
    );
  }
}

String _$nicknameRepositoryHash() =>
    r'b2297efa7fb02445f382bd6cfd5395d55eced7c3';

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に Firebase Firestore からニックネームを読み込み、
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
/// アプリ起動時に Firebase Firestore からニックネームを読み込み、
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
  /// アプリ起動時に Firebase Firestore からニックネームを読み込み、
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

String _$nicknameNotifierHash() => r'8c06113da09d2af3622a38b4b27143ad0ef0b47d';

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に Firebase Firestore からニックネームを読み込み、
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
