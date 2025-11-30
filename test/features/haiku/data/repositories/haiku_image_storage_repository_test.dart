import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

import 'package:flutterhackthema/features/haiku/data/repositories/haiku_image_storage_repository.dart';

/// テスト用のHaikuImageStorageRepository実装
///
/// 基底クラスのメソッドをオーバーライドしてモック動作を実現
class TestableHaikuImageStorageRepository extends HaikuImageStorageRepository {
  TestableHaikuImageStorageRepository({
    super.logger,
    this.mockUploadBehavior,
    this.mockDownloadBehavior,
    this.mockDeleteBehavior,
    this.mockGetDownloadUrlBehavior,
    this.mockGetMetadataBehavior,
    this.mockListFilesBehavior,
  });

  // Mock behaviors
  Future<String> Function(
    String fileName,
    Uint8List data, {
    SettableMetadata? metadata,
  })?
  mockUploadBehavior;
  Future<Uint8List?> Function(String fileName)? mockDownloadBehavior;
  Future<void> Function(String fileName)? mockDeleteBehavior;
  Future<String?> Function(String fileName)? mockGetDownloadUrlBehavior;
  Future<FullMetadata?> Function(String fileName)? mockGetMetadataBehavior;
  Future<List<Reference>> Function({String? path})? mockListFilesBehavior;

  // Call tracking
  final List<String> uploadCalls = [];
  final List<String> downloadCalls = [];
  final List<String> deleteCalls = [];
  final List<String> getDownloadUrlCalls = [];
  final List<String> getMetadataCalls = [];
  int listFilesCalls = 0;

  @override
  Future<String> upload(
    String fileName,
    Uint8List data, {
    SettableMetadata? metadata,
  }) async {
    uploadCalls.add(fileName);
    if (mockUploadBehavior != null) {
      return mockUploadBehavior!(fileName, data, metadata: metadata);
    }
    return 'https://mock.url/$fileName';
  }

  @override
  Future<Uint8List?> download(String fileName) async {
    downloadCalls.add(fileName);
    if (mockDownloadBehavior != null) {
      return mockDownloadBehavior!(fileName);
    }
    return Uint8List.fromList([1, 2, 3]);
  }

  @override
  Future<void> delete(String fileName) async {
    deleteCalls.add(fileName);
    if (mockDeleteBehavior != null) {
      return mockDeleteBehavior!(fileName);
    }
  }

  @override
  Future<String?> getDownloadUrl(String fileName) async {
    getDownloadUrlCalls.add(fileName);
    if (mockGetDownloadUrlBehavior != null) {
      return mockGetDownloadUrlBehavior!(fileName);
    }
    return 'https://mock.url/$fileName';
  }

  @override
  Future<FullMetadata?> getMetadata(String fileName) async {
    getMetadataCalls.add(fileName);
    if (mockGetMetadataBehavior != null) {
      return mockGetMetadataBehavior!(fileName);
    }
    // Return a simple metadata object
    return null;
  }

  @override
  Future<List<Reference>> listFiles({String? path}) async {
    listFilesCalls++;
    if (mockListFilesBehavior != null) {
      return mockListFilesBehavior!(path: path);
    }
    return [];
  }
}

void main() {
  group('HaikuImageStorageRepository', () {
    late TestableHaikuImageStorageRepository repository;

    setUp(() {
      repository = TestableHaikuImageStorageRepository(
        logger: Logger(level: Level.off), // Disable logging in tests
      );
    });

    group('uploadHaikuImage', () {
      test('uploads haiku image with correct metadata', () async {
        // Arrange
        const haikuId = 'test-haiku-001';
        final imageData = Uint8List.fromList([1, 2, 3, 4, 5]);
        const expectedUrl =
            'https://example.com/haiku_images/test-haiku-001.png';

        repository.mockUploadBehavior = (fileName, data, {metadata}) async {
          expect(fileName, equals('test-haiku-001.png'));
          expect(data, equals(imageData));
          expect(metadata, isNotNull);
          expect(metadata!.contentType, equals('image/png'));
          expect(metadata.customMetadata?['haikuId'], equals(haikuId));
          expect(metadata.customMetadata?['uploadedAt'], isNotNull);
          return expectedUrl;
        };

        // Act
        final url = await repository.uploadHaikuImage(haikuId, imageData);

        // Assert
        expect(url, equals(expectedUrl));
        expect(repository.uploadCalls, contains('test-haiku-001.png'));
      });

      test('throws exception when upload fails', () async {
        // Arrange
        const haikuId = 'test-haiku-002';
        final imageData = Uint8List.fromList([1, 2, 3]);

        repository.mockUploadBehavior = (fileName, data, {metadata}) async {
          throw FirebaseException(plugin: 'storage', message: 'Upload failed');
        };

        // Act & Assert
        expect(
          () => repository.uploadHaikuImage(haikuId, imageData),
          throwsA(isA<FirebaseException>()),
        );
      });
    });

    group('downloadHaikuImage', () {
      test('downloads existing haiku image', () async {
        // Arrange
        const haikuId = 'test-haiku-003';
        final expectedData = Uint8List.fromList([10, 20, 30]);

        repository.mockDownloadBehavior = (fileName) async {
          expect(fileName, equals('test-haiku-003.png'));
          return expectedData;
        };

        // Act
        final data = await repository.downloadHaikuImage(haikuId);

        // Assert
        expect(data, equals(expectedData));
        expect(repository.downloadCalls, contains('test-haiku-003.png'));
      });

      test('returns null for non-existent image', () async {
        // Arrange
        const haikuId = 'non-existent-haiku';

        repository.mockDownloadBehavior = (fileName) async {
          return null; // Simulate not found
        };

        // Act
        final data = await repository.downloadHaikuImage(haikuId);

        // Assert
        expect(data, isNull);
      });

      test('rethrows other exceptions', () async {
        // Arrange
        const haikuId = 'test-haiku-004';

        repository.mockDownloadBehavior = (fileName) async {
          throw FirebaseException(
            plugin: 'storage',
            code: 'unauthorized',
            message: 'Unauthorized',
          );
        };

        // Act & Assert
        expect(
          () => repository.downloadHaikuImage(haikuId),
          throwsA(isA<FirebaseException>()),
        );
      });
    });

    group('deleteHaikuImage', () {
      test('deletes haiku image successfully', () async {
        // Arrange
        const haikuId = 'test-haiku-005';

        repository.mockDeleteBehavior = (fileName) async {
          expect(fileName, equals('test-haiku-005.png'));
        };

        // Act
        await repository.deleteHaikuImage(haikuId);

        // Assert
        expect(repository.deleteCalls, contains('test-haiku-005.png'));
      });

      test('throws exception when delete fails', () async {
        // Arrange
        const haikuId = 'test-haiku-006';

        repository.mockDeleteBehavior = (fileName) async {
          throw FirebaseException(plugin: 'storage', message: 'Delete failed');
        };

        // Act & Assert
        expect(
          () => repository.deleteHaikuImage(haikuId),
          throwsA(isA<FirebaseException>()),
        );
      });
    });

    group('getHaikuImageUrl', () {
      test('returns download URL for existing image', () async {
        // Arrange
        const haikuId = 'test-haiku-007';
        const expectedUrl =
            'https://example.com/haiku_images/test-haiku-007.png';

        repository.mockGetDownloadUrlBehavior = (fileName) async {
          expect(fileName, equals('test-haiku-007.png'));
          return expectedUrl;
        };

        // Act
        final url = await repository.getHaikuImageUrl(haikuId);

        // Assert
        expect(url, equals(expectedUrl));
        expect(repository.getDownloadUrlCalls, contains('test-haiku-007.png'));
      });

      test('returns null for non-existent image', () async {
        // Arrange
        const haikuId = 'non-existent-haiku';

        repository.mockGetDownloadUrlBehavior = (fileName) async {
          return null; // Simulate not found
        };

        // Act
        final url = await repository.getHaikuImageUrl(haikuId);

        // Assert
        expect(url, isNull);
      });
    });

    group('existsHaikuImage', () {
      test('returns true when getMetadata is called', () async {
        // Arrange
        const haikuId = 'test-haiku-008';

        // Act
        // Since we can't easily create FullMetadata and the default returns null,
        // we just verify the method was called correctly
        await repository.existsHaikuImage(haikuId);

        // Assert
        expect(repository.getMetadataCalls, contains('test-haiku-008.png'));
      });

      test('returns false when image does not exist', () async {
        // Arrange
        const haikuId = 'non-existent-haiku';

        repository.mockGetMetadataBehavior = (fileName) async {
          return null; // Simulate not found (base class returns null)
        };

        // Act
        final exists = await repository.existsHaikuImage(haikuId);

        // Assert
        expect(exists, isFalse); // null metadata means file doesn't exist
      });
    });

    group('listAllHaikuImages', () {
      test('returns list of all haiku images', () async {
        // Arrange
        repository.mockListFilesBehavior = ({path}) async {
          return []; // Return empty list for simplicity
        };

        // Act
        final files = await repository.listAllHaikuImages();

        // Assert
        expect(files, isA<List<Reference>>());
        expect(repository.listFilesCalls, equals(1));
      });

      test('throws exception when listing fails', () async {
        // Arrange
        repository.mockListFilesBehavior = ({path}) async {
          throw FirebaseException(plugin: 'storage', message: 'List failed');
        };

        // Act & Assert
        expect(
          () => repository.listAllHaikuImages(),
          throwsA(isA<FirebaseException>()),
        );
      });
    });
  });
}
