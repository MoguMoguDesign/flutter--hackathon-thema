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
import 'package:flutterhackthema/shared/service/firebase_functions_exception.dart';
import 'package:flutterhackthema/shared/service/firebase_functions_service.dart';

part 'image_generation_provider.g.dart';

/// 画像生成プロバイダー
///
/// 俳句から画像を生成する状態管理を提供する。
/// HaikuPromptService を使用してプロンプトを生成し、
/// FirebaseFunctionsService を使用して画像を生成・保存する。
/// 生成された画像はFirebase Storageに保存され、URLが返される。
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
  /// Firebase Functions経由でGemini APIを呼び出し、
  /// 生成された画像をFirebase Storageに保存してURLを取得する。
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

      // Firebase Functions経由で画像生成・保存
      final functionsService = ref.read(firebaseFunctionsServiceProvider);
      final imageUrl = await functionsService.generateAndSaveImage(
        prompt: prompt,
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
      );

      state = ImageGenerationState.success(imageUrl);
    } on FunctionsException catch (e) {
      state = ImageGenerationState.error(e.message);
    } catch (e) {
      state = const ImageGenerationState.error('予期しないエラーが発生しました');
    }
  }

  /// 状態をリセットする
  ///
  /// 初期状態に戻す。
  void reset() {
    state = const ImageGenerationState.initial();
  }
}
