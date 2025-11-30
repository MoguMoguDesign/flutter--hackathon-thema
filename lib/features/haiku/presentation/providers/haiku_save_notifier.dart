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

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/data/models/save_status.dart';
import 'package:flutterhackthema/features/haiku/data/repositories/haiku_image_storage_repository.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/haiku_save_state.dart';
import 'package:flutterhackthema/features/haiku/service/haiku_image_cache_service.dart';

part 'haiku_save_notifier.g.dart';

/// 俳句保存を管理するNotifier
///
/// ローカルキャッシュへの即座の保存とFirebaseへのバックグラウンド保存を調整します。
@Riverpod(keepAlive: true)
class HaikuSaveNotifier extends _$HaikuSaveNotifier {
  /// ロガー
  late final Logger _logger;

  /// 画像キャッシュサービス
  late final HaikuImageCacheService _cacheService;

  /// 画像ストレージリポジトリ
  late final HaikuImageStorageRepository _storageRepository;

  /// 最大リトライ回数
  static const int _maxRetries = 3;

  /// リトライ間隔の基本値（ミリ秒）
  static const int _baseRetryDelayMs = 1000;

  @override
  HaikuSaveState build() {
    _logger = Logger();
    _cacheService = ref.watch(haikuImageCacheServiceProvider);
    _storageRepository = ref.watch(haikuImageStorageRepositoryProvider);
    return const HaikuSaveState.initial();
  }

  /// 俳句を保存（ローカルキャッシュ優先）
  ///
  /// [haiku] 保存する俳句
  /// [imageData] 俳句に紐づく画像データ
  ///
  /// 処理フロー:
  /// 1. ローカルキャッシュに即座に保存
  /// 2. バックグラウンドでFirebaseにアップロード（リトライあり）
  Future<void> saveHaiku(HaikuModel haiku, Uint8List imageData) async {
    try {
      _logger.d('Starting haiku save: ${haiku.id}');

      // 1. ローカルキャッシュに保存
      state = HaikuSaveState.savingToCache(haiku: haiku);

      final localImagePath = await _cacheService.saveImage(haiku.id, imageData);

      _logger.i('Saved to local cache: $localImagePath');

      // ローカル保存完了状態に更新
      final haikuWithLocalPath = haiku.copyWith(
        localImagePath: localImagePath,
        saveStatus: SaveStatus.localOnly,
      );

      // Provider が既に破棄されていないかチェック
      if (!ref.mounted) return;

      state = HaikuSaveState.cachedLocally(
        haiku: haikuWithLocalPath,
        localImagePath: localImagePath,
      );

      // 2. バックグラウンドでFirebaseに保存（リトライあり）
      await _saveToFirebaseWithRetry(haikuWithLocalPath, imageData);
    } catch (e, stackTrace) {
      _logger.e('Failed to save haiku', error: e, stackTrace: stackTrace);
      // Provider が既に破棄されていないかチェック
      if (ref.mounted) {
        state = HaikuSaveState.error(message: e.toString(), haiku: haiku);
      }
      rethrow;
    }
  }

  /// Firebaseへの保存（リトライロジック付き）
  ///
  /// [haiku] 保存する俳句
  /// [imageData] 画像データ
  Future<void> _saveToFirebaseWithRetry(
    HaikuModel haiku,
    Uint8List imageData,
  ) async {
    final localImagePath = haiku.localImagePath;
    if (localImagePath == null) {
      throw StateError('Local image path is null');
    }

    state = HaikuSaveState.savingToFirebase(
      haiku: haiku,
      localImagePath: localImagePath,
    );

    int retryCount = 0;
    Exception? lastException;

    while (retryCount < _maxRetries) {
      try {
        _logger.d(
          'Uploading to Firebase (attempt ${retryCount + 1}/$_maxRetries)',
        );

        // 画像をFirebase Storageにアップロード
        final firebaseImageUrl = await _storageRepository.uploadHaikuImage(
          haiku.id,
          imageData,
        );

        _logger.i('Uploaded to Firebase: $firebaseImageUrl');

        // 保存完了状態に更新
        final savedHaiku = haiku.copyWith(saveStatus: SaveStatus.saved);

        // Provider が既に破棄されていないかチェック
        if (!ref.mounted) return;

        state = HaikuSaveState.saved(
          haiku: savedHaiku,
          localImagePath: localImagePath,
          firebaseImageUrl: firebaseImageUrl,
        );

        return; // 成功したら終了
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());
        retryCount++;

        if (retryCount < _maxRetries) {
          // Exponential backoff
          final delayMs = _baseRetryDelayMs * (1 << (retryCount - 1));
          _logger.w(
            'Upload failed, retrying in ${delayMs}ms (attempt $retryCount/$_maxRetries)',
            error: e,
          );
          await Future.delayed(Duration(milliseconds: delayMs));
        }
      }
    }

    // 全てのリトライが失敗
    _logger.e('All retry attempts failed', error: lastException);

    final failedHaiku = haiku.copyWith(saveStatus: SaveStatus.failed);

    // Provider が既に破棄されていないかチェック
    if (ref.mounted) {
      state = HaikuSaveState.error(
        message:
            'Firebase upload failed after $_maxRetries attempts: ${lastException.toString()}',
        haiku: failedHaiku,
        localImagePath: localImagePath,
      );
    }

    throw lastException!;
  }

  /// ローカルキャッシュから俳句画像を読み込み
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 画像データ（存在しない場合はnull）
  Future<Uint8List?> loadFromCache(String haikuId) async {
    try {
      _logger.d('Loading haiku image from cache: $haikuId');
      return await _cacheService.loadImage(haikuId);
    } catch (e, stackTrace) {
      _logger.e('Failed to load from cache', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Firebaseから俳句画像をダウンロード
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 画像データ（存在しない場合はnull）
  Future<Uint8List?> downloadFromFirebase(String haikuId) async {
    try {
      _logger.d('Downloading haiku image from Firebase: $haikuId');

      final imageData = await _storageRepository.downloadHaikuImage(haikuId);

      if (imageData != null) {
        // ダウンロードした画像をキャッシュに保存
        await _cacheService.saveImage(haikuId, imageData);
        _logger.d('Downloaded and cached image: $haikuId');
      }

      return imageData;
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to download from Firebase',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// 俳句画像を読み込み（キャッシュ優先）
  ///
  /// [haikuId] 俳句のID
  /// 戻り値: 画像データ（存在しない場合はnull）
  ///
  /// 処理フロー:
  /// 1. ローカルキャッシュから読み込み
  /// 2. キャッシュになければFirebaseからダウンロード＆キャッシュ
  Future<Uint8List?> loadHaikuImage(String haikuId) async {
    try {
      // 1. キャッシュから読み込み
      final cachedImage = await loadFromCache(haikuId);
      if (cachedImage != null) {
        _logger.d('Loaded from cache: $haikuId');
        return cachedImage;
      }

      // 2. Firebaseからダウンロード
      _logger.d('Cache miss, downloading from Firebase: $haikuId');
      return await downloadFromFirebase(haikuId);
    } catch (e, stackTrace) {
      _logger.e('Failed to load haiku image', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// 俳句画像を削除（ローカルとFirebase両方）
  ///
  /// [haikuId] 俳句のID
  Future<void> deleteHaikuImage(String haikuId) async {
    try {
      _logger.d('Deleting haiku image: $haikuId');

      // ローカルキャッシュから削除
      await _cacheService.deleteImage(haikuId);

      // Firebaseから削除
      await _storageRepository.deleteHaikuImage(haikuId);

      _logger.i('Deleted haiku image: $haikuId');
    } catch (e, stackTrace) {
      _logger.e(
        'Failed to delete haiku image',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// 状態をリセット
  void reset() {
    state = const HaikuSaveState.initial();
  }
}
