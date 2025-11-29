// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一時的なニックネーム管理用Provider
///
/// NOTE: これは一時的な実装です
/// Issue #10 完了時に shared_preferences を使用した永続化実装に置き換えられます
///
/// 現在の実装:
/// - メモリ上でのみニックネームを保持
/// - アプリ再起動時にニックネームが消失
///
/// 将来の実装 (Issue #10):
/// - SharedPreferences による永続化
/// - アプリ再起動後もニックネームを保持
///
/// TODO(#10): Issue #10 完了後、このファイルを削除して
/// lib/features/nickname/presentation/providers/nickname_provider.dart に置き換える

@ProviderFor(TemporaryNickname)
const temporaryNicknameProvider = TemporaryNicknameProvider._();

/// 一時的なニックネーム管理用Provider
///
/// NOTE: これは一時的な実装です
/// Issue #10 完了時に shared_preferences を使用した永続化実装に置き換えられます
///
/// 現在の実装:
/// - メモリ上でのみニックネームを保持
/// - アプリ再起動時にニックネームが消失
///
/// 将来の実装 (Issue #10):
/// - SharedPreferences による永続化
/// - アプリ再起動後もニックネームを保持
///
/// TODO(#10): Issue #10 完了後、このファイルを削除して
/// lib/features/nickname/presentation/providers/nickname_provider.dart に置き換える
final class TemporaryNicknameProvider
    extends $NotifierProvider<TemporaryNickname, String?> {
  /// 一時的なニックネーム管理用Provider
  ///
  /// NOTE: これは一時的な実装です
  /// Issue #10 完了時に shared_preferences を使用した永続化実装に置き換えられます
  ///
  /// 現在の実装:
  /// - メモリ上でのみニックネームを保持
  /// - アプリ再起動時にニックネームが消失
  ///
  /// 将来の実装 (Issue #10):
  /// - SharedPreferences による永続化
  /// - アプリ再起動後もニックネームを保持
  ///
  /// TODO(#10): Issue #10 完了後、このファイルを削除して
  /// lib/features/nickname/presentation/providers/nickname_provider.dart に置き換える
  const TemporaryNicknameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'temporaryNicknameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$temporaryNicknameHash();

  @$internal
  @override
  TemporaryNickname create() => TemporaryNickname();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$temporaryNicknameHash() => r'65002a74ce5ed7c525916d27411d5c9a7194aa90';

/// 一時的なニックネーム管理用Provider
///
/// NOTE: これは一時的な実装です
/// Issue #10 完了時に shared_preferences を使用した永続化実装に置き換えられます
///
/// 現在の実装:
/// - メモリ上でのみニックネームを保持
/// - アプリ再起動時にニックネームが消失
///
/// 将来の実装 (Issue #10):
/// - SharedPreferences による永続化
/// - アプリ再起動後もニックネームを保持
///
/// TODO(#10): Issue #10 完了後、このファイルを削除して
/// lib/features/nickname/presentation/providers/nickname_provider.dart に置き換える

abstract class _$TemporaryNickname extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
