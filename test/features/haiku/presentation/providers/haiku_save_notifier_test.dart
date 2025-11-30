import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/data/models/save_status.dart';
import 'package:flutterhackthema/features/haiku/data/repositories/haiku_image_storage_repository.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/haiku_save_notifier.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/haiku_save_state.dart';
import 'package:flutterhackthema/features/haiku/service/haiku_image_cache_service.dart';

/// テスト用のHaikuImageCacheService実装
class MockHaikuImageCacheService extends HaikuImageCacheService {
  final Map<String, Uint8List> _cache = {};
  final List<String> saveCalls = [];
  final List<String> loadCalls = [];
  final List<String> deleteCalls = [];

  Exception? saveException;
  Exception? loadException;
  Exception? deleteException;

  @override
  Future<String> saveImage(String haikuId, Uint8List imageData) async {
    saveCalls.add(haikuId);
    if (saveException != null) throw saveException!;

    _cache[haikuId] = imageData;
    return '/cache/$haikuId.png';
  }

  @override
  Future<Uint8List?> loadImage(String haikuId) async {
    loadCalls.add(haikuId);
    if (loadException != null) throw loadException!;

    return _cache[haikuId];
  }

  @override
  Future<bool> deleteImage(String haikuId) async {
    deleteCalls.add(haikuId);
    if (deleteException != null) throw deleteException!;

    _cache.remove(haikuId);
    return true;
  }
}

/// テスト用のHaikuImageStorageRepository実装
class MockHaikuImageStorageRepository extends HaikuImageStorageRepository {
  final List<String> uploadCalls = [];
  final List<String> downloadCalls = [];
  final List<String> deleteCalls = [];

  Exception? uploadException;
  Exception? downloadException;
  Exception? deleteException;

  int uploadAttempts = 0;
  int failUntilAttempt = 0; // この回数までアップロード失敗

  @override
  Future<String> uploadHaikuImage(String haikuId, Uint8List imageData) async {
    uploadCalls.add(haikuId);
    uploadAttempts++;

    if (uploadException != null && uploadAttempts <= failUntilAttempt) {
      throw uploadException!;
    }

    return 'https://firebase.storage/$haikuId.png';
  }

  @override
  Future<Uint8List?> downloadHaikuImage(String haikuId) async {
    downloadCalls.add(haikuId);
    if (downloadException != null) throw downloadException!;

    return Uint8List.fromList([1, 2, 3, 4, 5]);
  }

  @override
  Future<void> deleteHaikuImage(String haikuId) async {
    deleteCalls.add(haikuId);
    if (deleteException != null) throw deleteException!;
  }
}

void main() {
  group('HaikuSaveNotifier', () {
    late ProviderContainer container;
    late MockHaikuImageCacheService mockCacheService;
    late MockHaikuImageStorageRepository mockStorageRepository;

    setUp(() {
      mockCacheService = MockHaikuImageCacheService();
      mockStorageRepository = MockHaikuImageStorageRepository();

      container = ProviderContainer(
        overrides: [
          haikuImageCacheServiceProvider.overrideWithValue(mockCacheService),
          haikuImageStorageRepositoryProvider.overrideWithValue(
            mockStorageRepository,
          ),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is Initial', () {
      final notifier = container.read(haikuSaveProvider.notifier);
      final state = container.read(haikuSaveProvider);

      expect(state.maybeWhen(initial: () => true, orElse: () => false), isTrue);
      expect(notifier, isNotNull);
    });

    group('saveHaiku', () {
      test('saves to cache and Firebase successfully', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-001',
          userId: 'user-001',
          imageUrl: '',
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3, 4, 5]);

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        await notifier.saveHaiku(haiku, imageData);

        // Assert
        final state = container.read(haikuSaveProvider);
        expect(
          state.maybeWhen(
            saved: (haiku, localPath, firebasePath) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(mockCacheService.saveCalls, contains('test-haiku-001'));
        expect(mockStorageRepository.uploadCalls, contains('test-haiku-001'));

        state.whenOrNull(
          saved: (haiku, localImagePath, firebaseImageUrl) {
            expect(localImagePath, equals('/cache/test-haiku-001.png'));
            expect(firebaseImageUrl, contains('firebase.storage'));
            expect(haiku.saveStatus, equals(SaveStatus.saved));
          },
        );
      });

      test('transitions through correct states', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-002',
          userId: 'user-002',
          imageUrl: '',
          firstLine: '春の海',
          secondLine: 'ひねもすのたり',
          thirdLine: 'のたりかな',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3]);

        final states = <String>[];
        container.listen(haikuSaveProvider, (previous, next) {
          next.when(
            initial: () => states.add('initial'),
            savingToCache: (_) => states.add('savingToCache'),
            cachedLocally: (haiku, localPath) => states.add('cachedLocally'),
            savingToFirebase: (haiku, localPath) =>
                states.add('savingToFirebase'),
            saved: (haiku, localPath, firebasePath) => states.add('saved'),
            error: (haiku, localPath, firebasePath) => states.add('error'),
          );
        }, fireImmediately: true);

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        await notifier.saveHaiku(haiku, imageData);

        // Assert
        expect(states, contains('initial'));
        expect(states, contains('savingToCache'));
        expect(states, contains('cachedLocally'));
        expect(states, contains('savingToFirebase'));
        expect(states.last, equals('saved'));
      });

      test('retries on Firebase upload failure and succeeds', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-003',
          userId: 'user-003',
          imageUrl: '',
          firstLine: '夏草や',
          secondLine: '兵どもが',
          thirdLine: '夢の跡',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3]);

        // 最初の2回失敗、3回目で成功
        mockStorageRepository.uploadException = Exception('Upload failed');
        mockStorageRepository.failUntilAttempt = 2;

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        await notifier.saveHaiku(haiku, imageData);

        // Assert
        final state = container.read(haikuSaveProvider);
        expect(
          state.maybeWhen(
            saved: (haiku, localPath, firebasePath) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(mockStorageRepository.uploadAttempts, equals(3));
      });

      test('throws error after max retries', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-004',
          userId: 'user-004',
          imageUrl: '',
          firstLine: '閑さや',
          secondLine: '岩にしみ入る',
          thirdLine: '蝉の声',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3]);

        // すべての試行で失敗
        mockStorageRepository.uploadException = Exception(
          'Upload always fails',
        );
        mockStorageRepository.failUntilAttempt = 10;

        // Act & Assert
        final notifier = container.read(haikuSaveProvider.notifier);
        await expectLater(
          () => notifier.saveHaiku(haiku, imageData),
          throwsException,
        );

        final state = container.read(haikuSaveProvider);
        expect(
          state.maybeWhen(
            error: (haiku, localPath, firebasePath) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(mockStorageRepository.uploadAttempts, equals(3)); // max retries
      });

      test('handles cache save error', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-005',
          userId: 'user-005',
          imageUrl: '',
          firstLine: '柿くへば',
          secondLine: '鐘が鳴るなり',
          thirdLine: '法隆寺',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3]);

        mockCacheService.saveException = Exception('Cache save failed');

        // Act & Assert
        final notifier = container.read(haikuSaveProvider.notifier);
        await expectLater(
          () => notifier.saveHaiku(haiku, imageData),
          throwsException,
        );

        final state = container.read(haikuSaveProvider);
        expect(
          state.maybeWhen(
            error: (haiku, localPath, firebasePath) => true,
            orElse: () => false,
          ),
          isTrue,
        );
      });
    });

    group('loadHaikuImage', () {
      test('loads from cache when available', () async {
        // Arrange
        const haikuId = 'test-haiku-006';
        final cachedData = Uint8List.fromList([10, 20, 30]);
        mockCacheService._cache[haikuId] = cachedData;

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        final result = await notifier.loadHaikuImage(haikuId);

        // Assert
        expect(result, equals(cachedData));
        expect(mockCacheService.loadCalls, contains(haikuId));
        expect(
          mockStorageRepository.downloadCalls,
          isEmpty,
        ); // Firebase not called
      });

      test('downloads from Firebase when cache misses', () async {
        // Arrange
        const haikuId = 'test-haiku-007';

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        final result = await notifier.loadHaikuImage(haikuId);

        // Assert
        expect(result, isNotNull);
        expect(mockCacheService.loadCalls, contains(haikuId));
        expect(mockStorageRepository.downloadCalls, contains(haikuId));
        expect(
          mockCacheService.saveCalls,
          contains(haikuId),
        ); // Downloaded data cached
      });

      test('returns null when both cache and Firebase fail', () async {
        // Arrange
        const haikuId = 'test-haiku-008';
        mockStorageRepository.downloadException = Exception('Download failed');

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        final result = await notifier.loadHaikuImage(haikuId);

        // Assert
        expect(result, isNull);
      });
    });

    group('deleteHaikuImage', () {
      test('deletes from both cache and Firebase', () async {
        // Arrange
        const haikuId = 'test-haiku-009';

        // Act
        final notifier = container.read(haikuSaveProvider.notifier);
        await notifier.deleteHaikuImage(haikuId);

        // Assert
        expect(mockCacheService.deleteCalls, contains(haikuId));
        expect(mockStorageRepository.deleteCalls, contains(haikuId));
      });

      test('throws exception when deletion fails', () async {
        // Arrange
        const haikuId = 'test-haiku-010';
        mockCacheService.deleteException = Exception('Delete failed');

        // Act & Assert
        final notifier = container.read(haikuSaveProvider.notifier);
        await expectLater(
          () => notifier.deleteHaikuImage(haikuId),
          throwsException,
        );
      });
    });

    group('reset', () {
      test('resets state to initial', () async {
        // Arrange
        final haiku = HaikuModel(
          id: 'test-haiku-011',
          userId: 'user-011',
          imageUrl: '',
          firstLine: '五月雨を',
          secondLine: '集めて早し',
          thirdLine: '最上川',
          createdAt: DateTime.now(),
        );
        final imageData = Uint8List.fromList([1, 2, 3]);

        final notifier = container.read(haikuSaveProvider.notifier);
        await notifier.saveHaiku(haiku, imageData);

        expect(
          container
              .read(haikuSaveProvider)
              .maybeWhen(
                saved: (haiku, localPath, firebasePath) => true,
                orElse: () => false,
              ),
          isTrue,
        );

        // Act
        notifier.reset();

        // Assert
        expect(
          container
              .read(haikuSaveProvider)
              .maybeWhen(initial: () => true, orElse: () => false),
          isTrue,
        );
      });
    });

    group('HaikuSaveStateExtension', () {
      test('isCached returns correct values', () {
        expect(const HaikuSaveState.initial().isCached, isFalse);
        expect(
          HaikuSaveState.savingToCache(
            haiku: HaikuModel(
              id: 'test',
              userId: 'user',
              imageUrl: '',
              firstLine: 'first',
              secondLine: 'second',
              thirdLine: 'third',
              createdAt: DateTime.now(),
            ),
          ).isCached,
          isFalse,
        );
        expect(
          HaikuSaveState.cachedLocally(
            haiku: HaikuModel(
              id: 'test',
              userId: 'user',
              imageUrl: '',
              firstLine: 'first',
              secondLine: 'second',
              thirdLine: 'third',
              createdAt: DateTime.now(),
            ),
            localImagePath: '/cache/test.png',
          ).isCached,
          isTrue,
        );
      });

      test('isSaved returns correct values', () {
        expect(const HaikuSaveState.initial().isSaved, isFalse);
        expect(
          HaikuSaveState.saved(
            haiku: HaikuModel(
              id: 'test',
              userId: 'user',
              imageUrl: '',
              firstLine: 'first',
              secondLine: 'second',
              thirdLine: 'third',
              createdAt: DateTime.now(),
            ),
            localImagePath: '/cache/test.png',
            firebaseImageUrl: 'https://firebase.storage/test.png',
          ).isSaved,
          isTrue,
        );
      });

      test('isError returns correct values', () {
        expect(const HaikuSaveState.initial().isError, isFalse);
        expect(
          const HaikuSaveState.error(message: 'Error occurred').isError,
          isTrue,
        );
      });

      test('isProcessing returns correct values', () {
        expect(const HaikuSaveState.initial().isProcessing, isFalse);
        expect(
          HaikuSaveState.savingToCache(
            haiku: HaikuModel(
              id: 'test',
              userId: 'user',
              imageUrl: '',
              firstLine: 'first',
              secondLine: 'second',
              thirdLine: 'third',
              createdAt: DateTime.now(),
            ),
          ).isProcessing,
          isTrue,
        );
      });
    });
  });
}
