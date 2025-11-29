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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/shared/constants/api_config.dart';
import 'package:flutterhackthema/shared/service/gemini_api_exception.dart';

part 'gemini_service.g.dart';

/// CORS プロキシ URL（Flutter Web用）
/// POST リクエストに対応したプロキシを使用
const String _corsProxyUrl = 'https://api.allorigins.win/raw?url=';

/// Gemini API 画像生成結果
///
/// API から返された画像データを保持する。
typedef GeminiImageResult = ({String base64Data, String mimeType});

/// Gemini API クライアントサービス
///
/// 画像生成 API へのアクセスを提供する。
/// HTTP クライアントをコンストラクタで受け取ることで、テスト時にモック可能。
///
/// 使用例:
/// ```dart
/// final service = GeminiService();
/// final result = await service.generateImage(prompt: '浮世絵風の富士山');
/// final imageBytes = base64.decode(result.base64Data);
/// ```
class GeminiService {
  /// Gemini サービスを作成する
  ///
  /// [httpClient] HTTP クライアント。テスト時にモックを注入可能。
  GeminiService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// 指定されたプロンプトから画像を生成する
  ///
  /// [prompt] 画像生成のプロンプト
  /// [aspectRatio] アスペクト比（デフォルト: 4:5）
  ///
  /// Returns: 生成された画像のbase64データとMIMEタイプ
  ///
  /// Throws:
  /// - [ApiKeyMissingException] API キーが設定されていない場合
  /// - [NetworkException] ネットワークエラー発生時
  /// - [TimeoutException] タイムアウト発生時（60秒）
  /// - [ApiErrorException] API がエラーを返した場合
  /// - [InvalidResponseException] レスポンス形式が不正な場合
  Future<GeminiImageResult> generateImage({
    required String prompt,
    String aspectRatio = '4:5',
  }) async {
    // API キーの設定を確認
    _validateApiKey();

    // 元のAPI URL
    final apiUrl =
        '${ApiConfig.geminiBaseUrl}/models/${ApiConfig.geminiImageModel}:'
        'streamGenerateContent?key=${ApiConfig.geminiApiKey}';

    // Flutter Webの場合はCORSプロキシを経由
    final urlString = kIsWeb
        ? '$_corsProxyUrl${Uri.encodeComponent(apiUrl)}'
        : apiUrl;
    final url = Uri.parse(urlString);

    final requestBody = {
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': prompt},
          ],
        },
      ],
      'generationConfig': {
        'responseModalities': ['IMAGE', 'TEXT'],
        'imageConfig': {'aspectRatio': aspectRatio},
      },
    };

    try {
      final response = await _httpClient
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(requestBody),
          )
          .timeout(
            Duration(seconds: ApiConfig.requestTimeoutSeconds),
            onTimeout: () => throw const TimeoutException(),
          );

      if (response.statusCode != 200) {
        throw ApiErrorException(
          'API returned status code ${response.statusCode}: ${response.body}',
        );
      }

      return _parseResponse(response.body);
    } on TimeoutException {
      rethrow;
    } on GeminiApiException {
      rethrow;
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (e is GeminiApiException) rethrow;
      throw NetworkException('Unexpected error: $e');
    }
  }

  /// API レスポンスをパースして画像データを抽出する
  GeminiImageResult _parseResponse(String responseBody) {
    try {
      // streamGenerateContent は配列形式で返される
      final dynamic jsonResponse = json.decode(responseBody);

      List<dynamic> candidates;
      if (jsonResponse is List) {
        // ストリーミングレスポンス形式
        if (jsonResponse.isEmpty) {
          throw const InvalidResponseException('Empty response array');
        }
        final firstItem = jsonResponse[0] as Map<String, dynamic>;
        candidates = firstItem['candidates'] as List<dynamic>? ?? [];
      } else if (jsonResponse is Map<String, dynamic>) {
        // 通常レスポンス形式
        candidates = jsonResponse['candidates'] as List<dynamic>? ?? [];
      } else {
        throw const InvalidResponseException('Unexpected response format');
      }

      if (candidates.isEmpty) {
        throw const InvalidResponseException('No candidates in response');
      }

      final content =
          (candidates[0] as Map<String, dynamic>)['content']
              as Map<String, dynamic>?;
      if (content == null) {
        throw const InvalidResponseException('No content in candidate');
      }

      final parts = content['parts'] as List<dynamic>?;
      if (parts == null || parts.isEmpty) {
        throw const InvalidResponseException('No parts in content');
      }

      // 画像データを探す
      for (final part in parts) {
        final partMap = part as Map<String, dynamic>;
        final inlineData = partMap['inlineData'] as Map<String, dynamic>?;
        if (inlineData != null) {
          final mimeType = inlineData['mimeType'] as String? ?? 'image/jpeg';
          final data = inlineData['data'] as String?;
          if (data != null) {
            return (base64Data: data, mimeType: mimeType);
          }
        }
      }

      throw const InvalidResponseException('No image data found in response');
    } on FormatException catch (e) {
      throw InvalidResponseException('Failed to parse JSON: ${e.message}');
    }
  }

  /// リソースを解放する
  void dispose() {
    _httpClient.close();
  }

  /// API キーの設定を確認する
  ///
  /// API キーが設定されていない場合は [ApiKeyMissingException] をスローする。
  void _validateApiKey() {
    if (!ApiConfig.hasGeminiApiKey) {
      throw const ApiKeyMissingException();
    }
  }
}

/// Gemini サービスのプロバイダー
///
/// アプリケーション全体で共有される GeminiService インスタンスを提供する。
@riverpod
GeminiService geminiService(Ref ref) {
  final service = GeminiService();
  ref.onDispose(service.dispose);
  return service;
}
