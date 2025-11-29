// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 画像生成プロバイダー
///
/// 俳句から画像を生成する状態管理を提供する。
/// HaikuPromptService を使用してプロンプトを生成し、
/// ImageGenerationRepository を使用して画像を生成する。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageGenerationProvider);
///
/// // 生成を開始
/// ref.read(imageGenerationProvider.notifier).generate(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```

@ProviderFor(ImageGeneration)
const imageGenerationProvider = ImageGenerationProvider._();

/// 画像生成プロバイダー
///
/// 俳句から画像を生成する状態管理を提供する。
/// HaikuPromptService を使用してプロンプトを生成し、
/// ImageGenerationRepository を使用して画像を生成する。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageGenerationProvider);
///
/// // 生成を開始
/// ref.read(imageGenerationProvider.notifier).generate(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
final class ImageGenerationProvider
    extends $NotifierProvider<ImageGeneration, ImageGenerationState> {
  /// 画像生成プロバイダー
  ///
  /// 俳句から画像を生成する状態管理を提供する。
  /// HaikuPromptService を使用してプロンプトを生成し、
  /// ImageGenerationRepository を使用して画像を生成する。
  ///
  /// 使用例:
  /// ```dart
  /// // 状態を監視
  /// final state = ref.watch(imageGenerationProvider);
  ///
  /// // 生成を開始
  /// ref.read(imageGenerationProvider.notifier).generate(
  ///   firstLine: '古池や',
  ///   secondLine: '蛙飛び込む',
  ///   thirdLine: '水の音',
  /// );
  /// ```
  const ImageGenerationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageGenerationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageGenerationHash();

  @$internal
  @override
  ImageGeneration create() => ImageGeneration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageGenerationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageGenerationState>(value),
    );
  }
}

String _$imageGenerationHash() => r'cbb109a8ca65682cd26a2e4816dab645462b5a6a';

/// 画像生成プロバイダー
///
/// 俳句から画像を生成する状態管理を提供する。
/// HaikuPromptService を使用してプロンプトを生成し、
/// ImageGenerationRepository を使用して画像を生成する。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageGenerationProvider);
///
/// // 生成を開始
/// ref.read(imageGenerationProvider.notifier).generate(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```

abstract class _$ImageGeneration extends $Notifier<ImageGenerationState> {
  ImageGenerationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ImageGenerationState, ImageGenerationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ImageGenerationState, ImageGenerationState>,
              ImageGenerationState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
