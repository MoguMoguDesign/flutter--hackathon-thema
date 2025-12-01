// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App -> Feature -> Shared)
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

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'firebase_functions_exception.dart';

part 'firebase_functions_service.g.dart';

/// Firebase Functions 呼び出しサービス
///
/// 画像生成 Function への呼び出しを提供する。
/// 認証済みユーザーのみがFunctionを呼び出せる。
///
/// 使用例:
/// ```dart
/// final service = FirebaseFunctionsService();
/// final imageUrl = await service.generateAndSaveImage(
///   prompt: '古池や蛙飛び込む水の音 - 浮世絵風',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
class FirebaseFunctionsService {
  /// コンストラクタ
  ///
  /// [functions] テスト時にモックを注入可能
  FirebaseFunctionsService({FirebaseFunctions? functions})
    : _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  /// テスト用の FirebaseFunctions インスタンス
  @visibleForTesting
  static FirebaseFunctions? testFunctions;

  /// 画像を生成して保存する
  ///
  /// [prompt] 画像生成プロンプト
  /// [haikuId] 俳句ID (オプション)
  /// [firstLine] 上の句
  /// [secondLine] 中の句
  /// [thirdLine] 下の句
  ///
  /// Returns: 生成された画像のURL
  /// Throws: [FunctionsException] 画像生成に失敗した場合
  Future<String> generateAndSaveImage({
    required String prompt,
    String? haikuId,
    String? firstLine,
    String? secondLine,
    String? thirdLine,
  }) async {
    try {
      final callable = _functions.httpsCallable(
        'generate_and_save_image',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 120)),
      );

      final result = await callable.call<Map<String, dynamic>>({
        'prompt': prompt,
        'haikuId': haikuId,
        'firstLine': firstLine,
        'secondLine': secondLine,
        'thirdLine': thirdLine,
      });

      final data = result.data;
      if (data['success'] != true || data['imageUrl'] == null) {
        throw const FunctionsException('画像生成に失敗しました');
      }

      return data['imageUrl'] as String;
    } on FirebaseFunctionsException catch (e) {
      throw FunctionsException(_mapFirebaseError(e), code: e.code);
    } catch (e) {
      if (e is FunctionsException) rethrow;
      throw FunctionsException('予期しないエラー: $e');
    }
  }

  /// FirebaseFunctionsExceptionをユーザー向けメッセージに変換
  String _mapFirebaseError(FirebaseFunctionsException e) {
    return switch (e.code) {
      'unauthenticated' => '認証が必要です。アプリを再起動してください',
      'permission-denied' => 'アクセス権限がありません',
      'resource-exhausted' => 'リクエスト上限に達しました。しばらく待ってから再試行してください',
      'deadline-exceeded' => '処理がタイムアウトしました。再試行してください',
      'internal' => 'サーバーエラーが発生しました',
      'invalid-argument' => '入力内容に問題があります',
      _ => '画像生成に失敗しました。再試行してください',
    };
  }
}

/// FirebaseFunctionsService プロバイダー
///
/// [FirebaseFunctionsService] のインスタンスを提供する。
@riverpod
FirebaseFunctionsService firebaseFunctionsService(Ref ref) {
  return FirebaseFunctionsService(
    functions: FirebaseFunctionsService.testFunctions,
  );
}
