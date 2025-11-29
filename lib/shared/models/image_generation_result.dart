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

import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_generation_result.freezed.dart';

/// 画像生成結果モデル
///
/// Gemini API から返された画像データを保持する。
/// Freezed を使用してイミュータブルなモデルとして実装。
///
/// 使用例:
/// ```dart
/// final result = ImageGenerationResult(
///   imageData: imageBytes,
///   mimeType: 'image/jpeg',
/// );
/// ```
@freezed
sealed class ImageGenerationResult with _$ImageGenerationResult {
  /// 画像生成結果を作成する
  ///
  /// [imageData] 画像のバイナリデータ
  /// [mimeType] 画像のMIMEタイプ（例: 'image/jpeg', 'image/png'）
  const factory ImageGenerationResult({
    /// 画像のバイナリデータ
    required Uint8List imageData,

    /// 画像のMIMEタイプ
    required String mimeType,
  }) = _ImageGenerationResult;
}
