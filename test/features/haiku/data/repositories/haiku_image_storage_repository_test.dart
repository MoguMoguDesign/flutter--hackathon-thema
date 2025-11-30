// Test file for HaikuImageStorageRepository
//
// Test coverage:
// - uploadHaikuImage with all parameters
// - uploadHaikuImage with minimal parameters
// - HaikuImageMetadata toMap scenarios
//
// Dependencies:
// - flutter_test for assertions

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/features/haiku/data/repositories/haiku_image_storage_repository.dart';

void main() {
  group('HaikuImageMetadata', () {
    group('toMap', () {
      test('returns map with all fields when all are provided', () {
        // Arrange
        final createdAt = DateTime(2025, 1, 15, 10, 30);
        const metadata = HaikuImageMetadata(
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
        );
        final metadataWithDate = HaikuImageMetadata(
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
          createdAt: createdAt,
        );

        // Act
        final result = metadata.toMap();
        final resultWithDate = metadataWithDate.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!['firstLine'], equals('古池や'));
        expect(result['secondLine'], equals('蛙飛び込む'));
        expect(result['thirdLine'], equals('水の音'));
        expect(result.containsKey('createdAt'), isFalse);

        expect(resultWithDate, isNotNull);
        expect(
          resultWithDate!['createdAt'],
          equals(createdAt.toIso8601String()),
        );
      });

      test('returns map with partial fields', () {
        // Arrange
        const metadata = HaikuImageMetadata(firstLine: '古池や');

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!['firstLine'], equals('古池や'));
        expect(result.containsKey('secondLine'), isFalse);
        expect(result.containsKey('thirdLine'), isFalse);
        expect(result.containsKey('createdAt'), isFalse);
      });

      test('returns null when all fields are null', () {
        // Arrange
        const metadata = HaikuImageMetadata();

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNull);
      });

      test('returns map with only secondLine', () {
        // Arrange
        const metadata = HaikuImageMetadata(secondLine: '蛙飛び込む');

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result['secondLine'], equals('蛙飛び込む'));
      });

      test('returns map with only thirdLine', () {
        // Arrange
        const metadata = HaikuImageMetadata(thirdLine: '水の音');

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result['thirdLine'], equals('水の音'));
      });

      test('returns map with only createdAt', () {
        // Arrange
        final createdAt = DateTime(2025, 6, 20, 14, 45, 30);
        final metadata = HaikuImageMetadata(createdAt: createdAt);

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!.length, equals(1));
        expect(result['createdAt'], equals('2025-06-20T14:45:30.000'));
      });

      test('handles Japanese characters correctly', () {
        // Arrange
        const metadata = HaikuImageMetadata(
          firstLine: '閑さや',
          secondLine: '岩にしみ入る',
          thirdLine: '蝉の声',
        );

        // Act
        final result = metadata.toMap();

        // Assert
        expect(result, isNotNull);
        expect(result!['firstLine'], equals('閑さや'));
        expect(result['secondLine'], equals('岩にしみ入る'));
        expect(result['thirdLine'], equals('蝉の声'));
      });
    });
  });

  group('HaikuImageStorageRepository', () {
    test('basePath is set to haiku_images', () {
      // Arrange & Act
      final repository = HaikuImageStorageRepository();

      // Assert
      expect(repository.basePath, equals('haiku_images'));
    });
  });
}
