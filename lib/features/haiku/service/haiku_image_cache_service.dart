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

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'haiku_image_cache_service.g.dart';

/// 俳句画像のローカルキャッシュを管理するサービス
///
/// Firebaseへの保存前に画像をローカルファイルシステムに一時保存し、
/// 高速な画像読み込みを提供します。
class HaikuImageCacheService {
  /// ロガー
  final Logger _logger;

  /// コンストラクタ
  HaikuImageCacheService({Logger? logger}) : _logger = logger ?? Logger();

  /// キャッシュディレクトリ名
  static const String _cacheDirectoryName = 'haiku_image_cache';

  /// キャッシュディレクトリを取得
  ///
  /// アプリケーション固有の一時ディレクトリ内にキャッシュフォルダを作成します。
  Future<Directory> _getCacheDirectory() async {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory('${tempDir.path}/$_cacheDirectoryName');

    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
      _logger.d('Created cache directory: ${cacheDir.path}');
    }

    return cacheDir;
  }

  /// 画像データをローカルキャッシュに保存
  ///
  /// [haikuId] 俳句のID（ファイル名として使用）
  /// [imageData] 保存する画像データ
  /// 戻り値: 保存されたファイルのパス
  ///
  /// Web環境ではローカルキャッシュは使用せず、ダミーパスを返します。
  Future<String> saveImage(String haikuId, Uint8List imageData) async {
    // Web環境ではpath_providerが使えないため、ダミーパスを返す
    if (kIsWeb) {
      _logger.d('Web環境: ローカルキャッシュをスキップ (${imageData.length} bytes)');
      return 'web://$haikuId.png';
    }

    try {
      final cacheDir = await _getCacheDirectory();
      final filePath = '${cacheDir.path}/$haikuId.png';
      final file = File(filePath);

      await file.writeAsBytes(imageData);
      _logger.d('Saved image to cache: $filePath (${imageData.length} bytes)');

      return filePath;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to save image to cache',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// ローカルキャッシュから画像データを読み込み
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 画像データ（存在しない場合はnull）
  ///
  /// Web環境では常にnullを返します（キャッシュなし）。
  Future<Uint8List?> loadImage(String haikuId) async {
    // Web環境ではキャッシュを使用しない
    if (kIsWeb) {
      _logger.d('Web環境: キャッシュ読み込みをスキップ');
      return null;
    }

    try {
      final cacheDir = await _getCacheDirectory();
      final filePath = '${cacheDir.path}/$haikuId.png';
      final file = File(filePath);

      if (!await file.exists()) {
        _logger.d('Cache miss: $filePath');
        return null;
      }

      final imageData = await file.readAsBytes();
      _logger.d(
        'Loaded image from cache: $filePath (${imageData.length} bytes)',
      );

      return imageData;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to load image from cache',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// ローカルキャッシュから画像ファイルのパスを取得
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: ファイルパス（存在しない場合はnull）
  ///
  /// Web環境では常にnullを返します。
  Future<String?> getImagePath(String haikuId) async {
    // Web環境ではファイルパスが存在しない
    if (kIsWeb) {
      return null;
    }

    try {
      final cacheDir = await _getCacheDirectory();
      final filePath = '${cacheDir.path}/$haikuId.png';
      final file = File(filePath);

      if (!await file.exists()) {
        return null;
      }

      return filePath;
    } catch (e, stackTrace) {
      _logger.e('Failed to get image path', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// 特定の俳句のキャッシュ画像を削除
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 削除に成功した場合true
  ///
  /// Web環境では常にtrueを返します（何もしない）。
  Future<bool> deleteImage(String haikuId) async {
    // Web環境では何もしない
    if (kIsWeb) {
      _logger.d('Web環境: キャッシュ削除をスキップ');
      return true;
    }

    try {
      final cacheDir = await _getCacheDirectory();
      final filePath = '${cacheDir.path}/$haikuId.png';
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        _logger.d('Deleted cached image: $filePath');
        return true;
      }

      _logger.d('Cache file not found: $filePath');
      return false;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to delete cached image',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// すべてのキャッシュ画像を削除
  ///
  /// アプリ起動時や容量削減のために使用します。
  /// 戻り値: 削除されたファイル数
  ///
  /// Web環境では常に0を返します（何もしない）。
  Future<int> clearAllCache() async {
    // Web環境では何もしない
    if (kIsWeb) {
      _logger.d('Web環境: キャッシュクリアをスキップ');
      return 0;
    }

    try {
      final cacheDir = await _getCacheDirectory();

      if (!await cacheDir.exists()) {
        _logger.d('Cache directory does not exist');
        return 0;
      }

      final files = await cacheDir.list().toList();
      int deletedCount = 0;

      for (final file in files) {
        if (file is File) {
          await file.delete();
          deletedCount++;
        }
      }

      _logger.i('Cleared cache: $deletedCount files deleted');
      return deletedCount;
    } catch (e, stackTrace) {
      _logger.e('Failed to clear cache', error: e, stackTrace: stackTrace);
      return 0;
    }
  }

  /// キャッシュディレクトリのサイズを取得（バイト単位）
  ///
  /// 戻り値: キャッシュディレクトリの合計サイズ
  ///
  /// Web環境では常に0を返します。
  Future<int> getCacheSize() async {
    // Web環境ではキャッシュサイズは0
    if (kIsWeb) {
      return 0;
    }

    try {
      final cacheDir = await _getCacheDirectory();

      if (!await cacheDir.exists()) {
        return 0;
      }

      final files = await cacheDir.list(recursive: true).toList();
      int totalSize = 0;

      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          totalSize += stat.size;
        }
      }

      _logger.d(
        'Cache size: $totalSize bytes (${(totalSize / 1024 / 1024).toStringAsFixed(2)} MB)',
      );
      return totalSize;
    } catch (e, stackTrace) {
      _logger.e('Failed to get cache size', error: e, stackTrace: stackTrace);
      return 0;
    }
  }

  /// キャッシュされている画像の数を取得
  ///
  /// 戻り値: キャッシュファイル数
  ///
  /// Web環境では常に0を返します。
  Future<int> getCacheCount() async {
    // Web環境ではキャッシュ数は0
    if (kIsWeb) {
      return 0;
    }

    try {
      final cacheDir = await _getCacheDirectory();

      if (!await cacheDir.exists()) {
        return 0;
      }

      final files = await cacheDir.list().toList();
      final count = files.whereType<File>().length;

      _logger.d('Cache count: $count files');
      return count;
    } catch (e, stackTrace) {
      _logger.e('Failed to get cache count', error: e, stackTrace: stackTrace);
      return 0;
    }
  }
}

/// HaikuImageCacheServiceのプロバイダー
@riverpod
HaikuImageCacheService haikuImageCacheService(Ref ref) {
  return HaikuImageCacheService();
}
