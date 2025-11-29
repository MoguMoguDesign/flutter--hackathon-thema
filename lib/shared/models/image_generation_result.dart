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
