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

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/haiku_image_storage_repository.dart';
import '../state/image_save_state.dart';

part 'image_save_provider.g.dart';

/// HaikuImageStorageRepositoryのプロバイダー
///
/// [HaikuImageStorageRepository]のインスタンスを提供する。
@riverpod
HaikuImageStorageRepository haikuImageStorageRepository(Ref ref) {
  return HaikuImageStorageRepository();
}

/// 画像保存プロバイダー
///
/// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
/// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageSaveProvider);
///
/// // 保存を実行
/// final url = await ref.read(imageSaveProvider.notifier).saveImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
@riverpod
class ImageSave extends _$ImageSave {
  @override
  ImageSaveState build() {
    return const ImageSaveState.initial();
  }

  /// 画像をFirebase Storageに保存する
  ///
  /// [imageData] 保存する画像データ
  /// [haikuId] 俳句のID(オプション)
  /// [userId] ユーザーID(オプション)
  /// [firstLine] 上の句(メタデータ用)
  /// [secondLine] 中の句(メタデータ用)
  /// [thirdLine] 下の句(メタデータ用)
  ///
  /// Returns: 保存成功時はダウンロードURL、失敗時はnull
  Future<String?> saveImage({
    required Uint8List imageData,
    String? haikuId,
    String? userId,
    String? firstLine,
    String? secondLine,
    String? thirdLine,
  }) async {
    // 画像データの検証
    if (imageData.isEmpty) {
      state = const ImageSaveState.error('画像データが空です');
      return null;
    }

    state = const ImageSaveState.saving();

    try {
      final repository = ref.read(haikuImageStorageRepositoryProvider);

      final metadata = HaikuImageMetadata(
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
        createdAt: DateTime.now(),
      );

      final downloadUrl = await repository.uploadHaikuImage(
        imageData: imageData,
        haikuId: haikuId,
        userId: userId,
        metadata: metadata,
      );

      state = ImageSaveState.success(downloadUrl);
      return downloadUrl;
    } on FirebaseException catch (e) {
      state = ImageSaveState.error(_mapFirebaseError(e));
      return null;
    } catch (e) {
      state = const ImageSaveState.error('予期しないエラーが発生しました');
      return null;
    }
  }

  /// FirebaseExceptionをユーザー向けメッセージに変換
  String _mapFirebaseError(FirebaseException e) {
    return switch (e.code) {
      'permission-denied' => '保存の権限がありません',
      'canceled' => '保存がキャンセルされました',
      'quota-exceeded' => 'ストレージ容量が不足しています',
      'unauthenticated' => '認証が必要です',
      'retry-limit-exceeded' => '接続に失敗しました。再試行してください',
      _ => '保存に失敗しました。再試行してください',
    };
  }

  /// 投稿中状態に設定する
  ///
  /// Firebase Functionsで画像は既に保存済みのため、
  /// 投稿処理中のUI表示のみに使用。
  void setPosting() {
    state = const ImageSaveState.saving();
  }

  /// 状態をリセットする
  void reset() {
    state = const ImageSaveState.initial();
  }
}
