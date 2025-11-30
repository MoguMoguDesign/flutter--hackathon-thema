import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/service/haiku_image_cache_service.dart';
import 'package:logger/logger.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

// Mock implementation of PathProviderPlatform for testing
class FakePathProviderPlatform extends PathProviderPlatform {
  final String tempPath;

  FakePathProviderPlatform(this.tempPath);

  @override
  Future<String?> getTemporaryPath() async {
    return tempPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return tempPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return tempPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return tempPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return tempPath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return [tempPath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return [tempPath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return tempPath;
  }
}

void main() {
  late HaikuImageCacheService service;
  late Directory testDir;

  setUp(() async {
    // Create a temporary test directory
    testDir = await Directory.systemTemp.createTemp('haiku_cache_test_');

    // Set up the fake path provider
    PathProviderPlatform.instance = FakePathProviderPlatform(testDir.path);

    // Create the service with a test logger
    service = HaikuImageCacheService(
      logger: Logger(
        printer: PrettyPrinter(methodCount: 0),
        level: Level.off, // Disable logging during tests
      ),
    );
  });

  tearDown(() async {
    // Clean up test directory
    if (await testDir.exists()) {
      await testDir.delete(recursive: true);
    }
  });

  group('HaikuImageCacheService', () {
    test('saveImage saves image data to cache', () async {
      // Arrange
      const haikuId = 'test-haiku-001';
      final imageData = Uint8List.fromList([1, 2, 3, 4, 5]);

      // Act
      final filePath = await service.saveImage(haikuId, imageData);

      // Assert
      expect(filePath, isNotEmpty);
      final file = File(filePath);
      expect(await file.exists(), isTrue);
      final savedData = await file.readAsBytes();
      expect(savedData, equals(imageData));
    });

    test('loadImage loads existing cached image', () async {
      // Arrange
      const haikuId = 'test-haiku-002';
      final originalData = Uint8List.fromList([10, 20, 30, 40, 50]);
      await service.saveImage(haikuId, originalData);

      // Act
      final loadedData = await service.loadImage(haikuId);

      // Assert
      expect(loadedData, isNotNull);
      expect(loadedData, equals(originalData));
    });

    test('loadImage returns null for non-existent image', () async {
      // Arrange
      const haikuId = 'non-existent-haiku';

      // Act
      final loadedData = await service.loadImage(haikuId);

      // Assert
      expect(loadedData, isNull);
    });

    test('getImagePath returns path for existing image', () async {
      // Arrange
      const haikuId = 'test-haiku-003';
      final imageData = Uint8List.fromList([1, 2, 3]);
      await service.saveImage(haikuId, imageData);

      // Act
      final path = await service.getImagePath(haikuId);

      // Assert
      expect(path, isNotNull);
      expect(await File(path!).exists(), isTrue);
    });

    test('getImagePath returns null for non-existent image', () async {
      // Arrange
      const haikuId = 'non-existent-haiku';

      // Act
      final path = await service.getImagePath(haikuId);

      // Assert
      expect(path, isNull);
    });

    test('deleteImage deletes existing cached image', () async {
      // Arrange
      const haikuId = 'test-haiku-004';
      final imageData = Uint8List.fromList([1, 2, 3]);
      final filePath = await service.saveImage(haikuId, imageData);

      // Act
      final deleted = await service.deleteImage(haikuId);

      // Assert
      expect(deleted, isTrue);
      expect(await File(filePath).exists(), isFalse);
    });

    test('deleteImage returns false for non-existent image', () async {
      // Arrange
      const haikuId = 'non-existent-haiku';

      // Act
      final deleted = await service.deleteImage(haikuId);

      // Assert
      expect(deleted, isFalse);
    });

    test('clearAllCache deletes all cached images', () async {
      // Arrange
      await service.saveImage('haiku-1', Uint8List.fromList([1, 2, 3]));
      await service.saveImage('haiku-2', Uint8List.fromList([4, 5, 6]));
      await service.saveImage('haiku-3', Uint8List.fromList([7, 8, 9]));

      // Act
      final deletedCount = await service.clearAllCache();

      // Assert
      expect(deletedCount, equals(3));
      expect(await service.getCacheCount(), equals(0));
    });

    test('getCacheSize returns correct total size', () async {
      // Arrange
      final data1 = Uint8List.fromList(List.filled(100, 1));
      final data2 = Uint8List.fromList(List.filled(200, 2));
      await service.saveImage('haiku-1', data1);
      await service.saveImage('haiku-2', data2);

      // Act
      final size = await service.getCacheSize();

      // Assert
      expect(size, equals(300)); // 100 + 200 bytes
    });

    test('getCacheSize returns 0 for empty cache', () async {
      // Act
      final size = await service.getCacheSize();

      // Assert
      expect(size, equals(0));
    });

    test('getCacheCount returns correct number of cached images', () async {
      // Arrange
      await service.saveImage('haiku-1', Uint8List.fromList([1]));
      await service.saveImage('haiku-2', Uint8List.fromList([2]));
      await service.saveImage('haiku-3', Uint8List.fromList([3]));

      // Act
      final count = await service.getCacheCount();

      // Assert
      expect(count, equals(3));
    });

    test('getCacheCount returns 0 for empty cache', () async {
      // Act
      final count = await service.getCacheCount();

      // Assert
      expect(count, equals(0));
    });

    test('multiple operations work correctly in sequence', () async {
      // Arrange
      const haikuId = 'test-haiku-sequence';
      final imageData = Uint8List.fromList([1, 2, 3, 4, 5]);

      // Act & Assert - Save
      final filePath = await service.saveImage(haikuId, imageData);
      expect(await File(filePath).exists(), isTrue);

      // Act & Assert - Load
      final loadedData = await service.loadImage(haikuId);
      expect(loadedData, equals(imageData));

      // Act & Assert - Get path
      final path = await service.getImagePath(haikuId);
      expect(path, equals(filePath));

      // Act & Assert - Get count
      final count = await service.getCacheCount();
      expect(count, equals(1));

      // Act & Assert - Delete
      final deleted = await service.deleteImage(haikuId);
      expect(deleted, isTrue);
      expect(await File(filePath).exists(), isFalse);
    });
  });
}
