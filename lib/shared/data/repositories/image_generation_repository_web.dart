// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutterhackthema/shared/constants/api_config.dart';
import 'package:flutterhackthema/shared/models/image_generation_result.dart';
import 'package:flutterhackthema/shared/service/gemini_api_exception.dart';

/// Web専用の画像生成関数
///
/// dart:html の XMLHttpRequest を使用してCORS問題を回避
Future<ImageGenerationResult> generateImageWeb({
  required String prompt,
  String aspectRatio = '4:5',
}) async {
  final url =
      '${ApiConfig.geminiBaseUrl}/models/${ApiConfig.geminiImageModel}:'
      'streamGenerateContent?key=${ApiConfig.geminiApiKey}';

  final requestBody = json.encode({
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
  });

  try {
    final completer = Completer<String>();

    final request = html.HttpRequest();
    request.open('POST', url);
    request.setRequestHeader('Content-Type', 'application/json');

    request.onLoad.listen((event) {
      if (request.status == 200) {
        completer.complete(request.responseText ?? '');
      } else {
        completer.completeError(
          ApiErrorException(
            'API returned status ${request.status}: ${request.responseText}',
          ),
        );
      }
    });

    request.onError.listen((event) {
      completer.completeError(const NetworkException('Network error occurred'));
    });

    request.onTimeout.listen((event) {
      completer.completeError(const TimeoutException());
    });

    request.send(requestBody);

    final responseText = await completer.future.timeout(
      Duration(seconds: ApiConfig.requestTimeoutSeconds),
      onTimeout: () => throw const TimeoutException(),
    );

    return _parseResponse(responseText);
  } catch (e) {
    if (e is GeminiApiException) rethrow;
    throw NetworkException('Unexpected error: $e');
  }
}

/// API レスポンスをパースして画像データを抽出する
ImageGenerationResult _parseResponse(String responseBody) {
  try {
    final dynamic jsonResponse = json.decode(responseBody);

    List<dynamic> candidates;
    if (jsonResponse is List) {
      if (jsonResponse.isEmpty) {
        throw const InvalidResponseException('Empty response array');
      }
      final firstItem = jsonResponse[0] as Map<String, dynamic>;
      candidates = firstItem['candidates'] as List<dynamic>? ?? [];
    } else if (jsonResponse is Map<String, dynamic>) {
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

    for (final part in parts) {
      final partMap = part as Map<String, dynamic>;
      final inlineData = partMap['inlineData'] as Map<String, dynamic>?;
      if (inlineData != null) {
        final mimeType = inlineData['mimeType'] as String? ?? 'image/jpeg';
        final data = inlineData['data'] as String?;
        if (data != null) {
          final imageData = base64.decode(data);
          return ImageGenerationResult(
            imageData: imageData,
            mimeType: mimeType,
          );
        }
      }
    }

    throw const InvalidResponseException('No image data found in response');
  } on FormatException catch (e) {
    throw InvalidResponseException('Failed to parse JSON: ${e.message}');
  }
}
