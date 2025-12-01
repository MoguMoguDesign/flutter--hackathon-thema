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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_generation_state.freezed.dart';

/// 画像生成状態
///
/// 画像生成の進行状態を表現する。
/// 初期状態、生成中、成功、エラーの4つの状態を持つ。
/// Firebase Functions経由で画像を生成し、URLを受け取る。
///
/// 使用例:
/// ```dart
/// final state = ImageGenerationState.loading(0.5);
/// state.when(
///   initial: () => print('初期状態'),
///   loading: (progress) => print('生成中: ${progress * 100}%'),
///   success: (imageUrl) => print('成功: $imageUrl'),
///   error: (message) => print('エラー: $message'),
/// );
/// ```
@freezed
class ImageGenerationState with _$ImageGenerationState {
  /// 初期状態
  ///
  /// 画像生成がまだ開始されていない状態。
  const factory ImageGenerationState.initial() = ImageGenerationInitial;

  /// 生成中状態
  ///
  /// 画像生成が進行中の状態。
  /// [progress] 進捗率（0.0 - 1.0）
  const factory ImageGenerationState.loading(double progress) =
      ImageGenerationLoading;

  /// 生成成功状態
  ///
  /// 画像生成が成功した状態。
  /// [imageUrl] Firebase Storageに保存された画像のURL
  const factory ImageGenerationState.success(String imageUrl) =
      ImageGenerationSuccess;

  /// エラー状態
  ///
  /// 画像生成に失敗した状態。
  /// [message] エラーメッセージ
  const factory ImageGenerationState.error(String message) =
      ImageGenerationError;
}
