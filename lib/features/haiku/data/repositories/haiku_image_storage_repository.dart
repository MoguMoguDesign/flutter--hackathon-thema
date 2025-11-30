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
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/shared/data/repositories/storage_repository.dart';

part 'haiku_image_storage_repository.g.dart';

/// 俳句画像専用のFirebase Storageリポジトリ
///
/// 俳句に紐づく画像をFirebase Storageにアップロード・管理します。
/// 画像は `haiku_images/{haikuId}.png` というパスで保存されます。
class HaikuImageStorageRepository extends StorageRepository {
  /// ロガー
  final Logger _logger;

  /// コンストラクタ
  HaikuImageStorageRepository({Logger? logger})
    : _logger = logger ?? Logger(),
      super(basePath: 'haiku_images');

  /// 俳句画像をアップロード
  ///
  /// [haikuId] 俳句のID
  /// [imageData] アップロードする画像データ
  /// 戻り値: アップロードされた画像のダウンロードURL
  Future<String> uploadHaikuImage(String haikuId, Uint8List imageData) async {
    try {
      _logger.d('Uploading haiku image: $haikuId (${imageData.length} bytes)');

      // PNG画像としてメタデータを設定
      final metadata = SettableMetadata(
        contentType: 'image/png',
        customMetadata: {
          'haikuId': haikuId,
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      final fileName = '$haikuId.png';
      final downloadUrl = await upload(fileName, imageData, metadata: metadata);

      _logger.i('Successfully uploaded haiku image: $haikuId -> $downloadUrl');
      return downloadUrl;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to upload haiku image: $haikuId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 俳句画像をダウンロード
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: ダウンロードした画像データ（存在しない場合はnull）
  Future<Uint8List?> downloadHaikuImage(String haikuId) async {
    try {
      _logger.d('Downloading haiku image: $haikuId');

      final fileName = '$haikuId.png';
      final imageData = await download(fileName);

      if (imageData != null) {
        _logger.d(
          'Successfully downloaded haiku image: $haikuId (${imageData.length} bytes)',
        );
      } else {
        _logger.d('Haiku image not found: $haikuId');
      }

      return imageData;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to download haiku image: $haikuId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 俳句画像を削除
  ///
  /// [haikuId] 俳句のID
  Future<void> deleteHaikuImage(String haikuId) async {
    try {
      _logger.d('Deleting haiku image: $haikuId');

      final fileName = '$haikuId.png';
      await delete(fileName);

      _logger.i('Successfully deleted haiku image: $haikuId');
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to delete haiku image: $haikuId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 俳句画像のダウンロードURLを取得
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: ダウンロードURL（存在しない場合はnull）
  Future<String?> getHaikuImageUrl(String haikuId) async {
    try {
      _logger.d('Getting haiku image URL: $haikuId');

      final fileName = '$haikuId.png';
      final downloadUrl = await getDownloadUrl(fileName);

      if (downloadUrl != null) {
        _logger.d('Got haiku image URL: $haikuId -> $downloadUrl');
      } else {
        _logger.d('Haiku image URL not found: $haikuId');
      }

      return downloadUrl;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to get haiku image URL: $haikuId',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 俳句画像が存在するかチェック
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 画像が存在する場合true
  Future<bool> existsHaikuImage(String haikuId) async {
    try {
      final fileName = '$haikuId.png';
      final metadata = await getMetadata(fileName);
      return metadata != null;
    } catch (e) {
      _logger.w('Failed to check haiku image existence: $haikuId', error: e);
      return false;
    }
  }

  /// 全ての俳句画像を一覧取得
  ///
  /// 戻り値: 俳句画像の参照リスト
  Future<List<Reference>> listAllHaikuImages() async {
    try {
      _logger.d('Listing all haiku images');

      final files = await listFiles();

      _logger.d('Found ${files.length} haiku images');
      return files;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to list haiku images',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

/// HaikuImageStorageRepositoryのプロバイダー
@riverpod
HaikuImageStorageRepository haikuImageStorageRepository(Ref ref) {
  return HaikuImageStorageRepository();
}
