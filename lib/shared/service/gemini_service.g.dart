// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Gemini サービスのプロバイダー
///
/// アプリケーション全体で共有される GeminiService インスタンスを提供する。

@ProviderFor(geminiService)
const geminiServiceProvider = GeminiServiceProvider._();

/// Gemini サービスのプロバイダー
///
/// アプリケーション全体で共有される GeminiService インスタンスを提供する。

final class GeminiServiceProvider
    extends $FunctionalProvider<GeminiService, GeminiService, GeminiService>
    with $Provider<GeminiService> {
  /// Gemini サービスのプロバイダー
  ///
  /// アプリケーション全体で共有される GeminiService インスタンスを提供する。
  const GeminiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geminiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geminiServiceHash();

  @$internal
  @override
  $ProviderElement<GeminiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GeminiService create(Ref ref) {
    return geminiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeminiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeminiService>(value),
    );
  }
}

String _$geminiServiceHash() => r'988be11e3c9d604051194d12fa1880a4668bb93f';
