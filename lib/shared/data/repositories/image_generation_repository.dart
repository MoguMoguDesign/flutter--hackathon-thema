import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/shared/models/image_generation_result.dart';
import 'package:flutterhackthema/shared/service/gemini_service.dart';
// Web用のサービスは条件付きインポート
import 'image_generation_repository_web.dart'
    if (dart.library.io) 'image_generation_repository_stub.dart'
    as web;

part 'image_generation_repository.g.dart';

/// 画像生成リポジトリ
///
/// 画像生成サービスへのアクセスを抽象化する。
/// GeminiService を使用して画像を生成し、結果を
/// ImageGenerationResult として返す。
///
/// 使用例:
/// ```dart
/// final repository = ref.watch(imageGenerationRepositoryProvider);
/// final result = await repository.generateImage(prompt: '浮世絵風の富士山');
/// ```
class ImageGenerationRepository {
  /// 画像生成リポジトリを作成する
  ///
  /// [geminiService] Gemini API サービス
  ImageGenerationRepository({required GeminiService geminiService})
    : _geminiService = geminiService;

  final GeminiService _geminiService;

  /// 指定されたプロンプトから画像を生成する
  ///
  /// [prompt] 画像生成のプロンプト
  /// [aspectRatio] アスペクト比（デフォルト: 4:5）
  ///
  /// Returns: [ImageGenerationResult] 生成結果
  ///
  /// Throws: [GeminiApiException] エラー発生時
  Future<ImageGenerationResult> generateImage({
    required String prompt,
    String aspectRatio = '4:5',
  }) async {
    if (kIsWeb) {
      // Web環境ではdart:htmlを使用したサービスを使用
      return web.generateImageWeb(prompt: prompt, aspectRatio: aspectRatio);
    }

    // モバイル/デスクトップ環境では通常のサービスを使用
    final result = await _geminiService.generateImage(
      prompt: prompt,
      aspectRatio: aspectRatio,
    );

    final imageData = base64.decode(result.base64Data);

    return ImageGenerationResult(
      imageData: imageData,
      mimeType: result.mimeType,
    );
  }
}

/// 画像生成リポジトリのプロバイダー
///
/// アプリケーション全体で共有される ImageGenerationRepository インスタンスを提供する。
@riverpod
ImageGenerationRepository imageGenerationRepository(Ref ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return ImageGenerationRepository(geminiService: geminiService);
}
