// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/features/haiku/presentation/state/image_generation_state.dart';
import 'package:flutterhackthema/features/haiku/service/haiku_prompt_service.dart';
import 'package:flutterhackthema/shared/data/repositories/image_generation_repository.dart';
import 'package:flutterhackthema/shared/service/gemini_api_exception.dart';

part 'image_generation_provider.g.dart';

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
@riverpod
class ImageGeneration extends _$ImageGeneration {
  @override
  ImageGenerationState build() {
    return const ImageGenerationState.initial();
  }

  /// 俳句から画像を生成する
  ///
  /// [firstLine] 上の句
  /// [secondLine] 中の句
  /// [thirdLine] 下の句
  Future<void> generate({
    required String firstLine,
    required String secondLine,
    required String thirdLine,
  }) async {
    state = const ImageGenerationState.loading(0);

    try {
      // プロンプト生成
      const promptService = HaikuPromptService();
      final prompt = promptService.generatePrompt(
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
      );

      state = const ImageGenerationState.loading(0.3);

      // 画像生成
      final repository = ref.read(imageGenerationRepositoryProvider);
      final result = await repository.generateImage(prompt: prompt);

      state = ImageGenerationState.success(result.imageData);
    } on GeminiApiException catch (e) {
      state = ImageGenerationState.error(_mapErrorMessage(e));
    } catch (e) {
      state = const ImageGenerationState.error('予期しないエラーが発生しました');
    }
  }

  /// 例外をユーザー向けメッセージに変換する
  String _mapErrorMessage(GeminiApiException e) {
    return switch (e) {
      NetworkException() => 'ネットワーク接続を確認してください',
      TimeoutException() => '生成に時間がかかりすぎました。再試行してください',
      ApiErrorException() => '画像生成に失敗しました。再試行してください',
      InvalidResponseException() => '予期しないエラーが発生しました',
      ApiKeyMissingException() => 'APIキーが設定されていません。環境変数を確認してください',
    };
  }

  /// 状態をリセットする
  ///
  /// 初期状態に戻す。
  void reset() {
    state = const ImageGenerationState.initial();
  }
}
