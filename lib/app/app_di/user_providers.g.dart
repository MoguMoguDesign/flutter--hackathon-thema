// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリレベルのユーザーニックネームプロバイダー
///
/// Feature層のnicknameProviderをApp層で再エクスポートし、
/// 他のFeature層がApp層経由でニックネームにアクセスできるようにします。
///
/// これにより、Feature-to-Feature依存を回避し、
/// 三層アーキテクチャ(App → Feature → Shared)を維持します。
///
/// 使用例:
/// ```dart
/// // Feature層から使用
/// final nickname = await ref.read(userNicknameProvider.future);
/// ```

@ProviderFor(userNickname)
const userNicknameProvider = UserNicknameProvider._();

/// アプリレベルのユーザーニックネームプロバイダー
///
/// Feature層のnicknameProviderをApp層で再エクスポートし、
/// 他のFeature層がApp層経由でニックネームにアクセスできるようにします。
///
/// これにより、Feature-to-Feature依存を回避し、
/// 三層アーキテクチャ(App → Feature → Shared)を維持します。
///
/// 使用例:
/// ```dart
/// // Feature層から使用
/// final nickname = await ref.read(userNicknameProvider.future);
/// ```

final class UserNicknameProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// アプリレベルのユーザーニックネームプロバイダー
  ///
  /// Feature層のnicknameProviderをApp層で再エクスポートし、
  /// 他のFeature層がApp層経由でニックネームにアクセスできるようにします。
  ///
  /// これにより、Feature-to-Feature依存を回避し、
  /// 三層アーキテクチャ(App → Feature → Shared)を維持します。
  ///
  /// 使用例:
  /// ```dart
  /// // Feature層から使用
  /// final nickname = await ref.read(userNicknameProvider.future);
  /// ```
  const UserNicknameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userNicknameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNicknameHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return userNickname(ref);
  }
}

String _$userNicknameHash() => r'1c6b0f39b180932ff3788a9d18158fb7ee35b2ab';
