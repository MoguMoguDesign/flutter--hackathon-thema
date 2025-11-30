// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_save_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HaikuImageStorageRepositoryのプロバイダー
///
/// [HaikuImageStorageRepository]のインスタンスを提供する。

@ProviderFor(haikuImageStorageRepository)
const haikuImageStorageRepositoryProvider =
    HaikuImageStorageRepositoryProvider._();

/// HaikuImageStorageRepositoryのプロバイダー
///
/// [HaikuImageStorageRepository]のインスタンスを提供する。

final class HaikuImageStorageRepositoryProvider
    extends
        $FunctionalProvider<
          HaikuImageStorageRepository,
          HaikuImageStorageRepository,
          HaikuImageStorageRepository
        >
    with $Provider<HaikuImageStorageRepository> {
  /// HaikuImageStorageRepositoryのプロバイダー
  ///
  /// [HaikuImageStorageRepository]のインスタンスを提供する。
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

/// 画像保存プロバイダー
///
/// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
/// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageSaveProvider);
///
/// // 保存を実行
/// final url = await ref.read(imageSaveProvider.notifier).saveImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```

@ProviderFor(ImageSave)
const imageSaveProvider = ImageSaveProvider._();

/// 画像保存プロバイダー
///
/// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
/// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageSaveProvider);
///
/// // 保存を実行
/// final url = await ref.read(imageSaveProvider.notifier).saveImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
final class ImageSaveProvider
    extends $NotifierProvider<ImageSave, ImageSaveState> {
  /// 画像保存プロバイダー
  ///
  /// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
  /// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
  ///
  /// 使用例:
  /// ```dart
  /// // 状態を監視
  /// final state = ref.watch(imageSaveProvider);
  ///
  /// // 保存を実行
  /// final url = await ref.read(imageSaveProvider.notifier).saveImage(
  ///   imageData: imageBytes,
  ///   haikuId: 'haiku123',
  ///   firstLine: '古池や',
  ///   secondLine: '蛙飛び込む',
  ///   thirdLine: '水の音',
  /// );
  /// ```
  const ImageSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageSaveHash();

  @$internal
  @override
  ImageSave create() => ImageSave();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageSaveState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageSaveState>(value),
    );
  }
}

String _$imageSaveHash() => r'19b3edf5834d37272a880a116f90289c6fd701a4';

/// 画像保存プロバイダー
///
/// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
/// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageSaveProvider);
///
/// // 保存を実行
/// final url = await ref.read(imageSaveProvider.notifier).saveImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```

abstract class _$ImageSave extends $Notifier<ImageSaveState> {
  ImageSaveState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ImageSaveState, ImageSaveState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ImageSaveState, ImageSaveState>,
              ImageSaveState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
