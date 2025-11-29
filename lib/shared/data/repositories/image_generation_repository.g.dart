// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 画像生成リポジトリのプロバイダー
///
/// アプリケーション全体で共有される ImageGenerationRepository インスタンスを提供する。

@ProviderFor(imageGenerationRepository)
const imageGenerationRepositoryProvider = ImageGenerationRepositoryProvider._();

/// 画像生成リポジトリのプロバイダー
///
/// アプリケーション全体で共有される ImageGenerationRepository インスタンスを提供する。

final class ImageGenerationRepositoryProvider
    extends
        $FunctionalProvider<
          ImageGenerationRepository,
          ImageGenerationRepository,
          ImageGenerationRepository
        >
    with $Provider<ImageGenerationRepository> {
  /// 画像生成リポジトリのプロバイダー
  ///
  /// アプリケーション全体で共有される ImageGenerationRepository インスタンスを提供する。
  const ImageGenerationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageGenerationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageGenerationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ImageGenerationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImageGenerationRepository create(Ref ref) {
    return imageGenerationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageGenerationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageGenerationRepository>(value),
    );
  }
}

String _$imageGenerationRepositoryHash() =>
    r'4df138012c6b4ea9eb9f4000971ee7fd57f6bb23';
