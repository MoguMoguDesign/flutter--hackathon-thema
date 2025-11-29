import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_generation_state.freezed.dart';

/// 画像生成状態
///
/// 画像生成の進行状態を表現する。
/// 初期状態、生成中、成功、エラーの4つの状態を持つ。
///
/// 使用例:
/// ```dart
/// final state = ImageGenerationState.loading(0.5);
/// state.when(
///   initial: () => print('初期状態'),
///   loading: (progress) => print('生成中: ${progress * 100}%'),
///   success: (imageData) => print('成功'),
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
  /// [imageData] 生成された画像データ
  const factory ImageGenerationState.success(Uint8List imageData) =
      ImageGenerationSuccess;

  /// エラー状態
  ///
  /// 画像生成に失敗した状態。
  /// [message] エラーメッセージ
  const factory ImageGenerationState.error(String message) =
      ImageGenerationError;
}
