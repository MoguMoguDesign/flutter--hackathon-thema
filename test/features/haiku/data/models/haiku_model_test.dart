import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/data/models/save_status.dart';

void main() {
  group('HaikuModel', () {
    test('fromJson creates valid HaikuModel', () {
      // Arrange
      final json = {
        'id': 'test-id',
        'firstLine': '古池や',
        'secondLine': '蛙飛び込む',
        'thirdLine': '水の音',
        'createdAt': DateTime(2025, 1, 1).toIso8601String(),
        'imageUrl': 'https://example.com/image.png',
        'userId': 'user-123',
      };

      // Act
      final haiku = HaikuModel.fromJson(json);

      // Assert
      expect(haiku.id, equals('test-id'));
      expect(haiku.firstLine, equals('古池や'));
      expect(haiku.secondLine, equals('蛙飛び込む'));
      expect(haiku.thirdLine, equals('水の音'));
      expect(haiku.imageUrl, equals('https://example.com/image.png'));
      expect(haiku.userId, equals('user-123'));
    });

    test('toJson creates valid JSON', () {
      // Arrange
      final haiku = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
      );

      // Act
      final json = haiku.toJson();

      // Assert
      expect(json['id'], equals('test-id'));
      expect(json['firstLine'], equals('古池や'));
      expect(json['secondLine'], equals('蛙飛び込む'));
      expect(json['thirdLine'], equals('水の音'));
    });

    test('fromJson with optional fields as null', () {
      // Arrange
      final json = {
        'id': 'test-id',
        'firstLine': '古池や',
        'secondLine': '蛙飛び込む',
        'thirdLine': '水の音',
        'createdAt': DateTime(2025, 1, 1).toIso8601String(),
      };

      // Act
      final haiku = HaikuModel.fromJson(json);

      // Assert
      expect(haiku.imageUrl, isNull);
      expect(haiku.userId, isNull);
    });

    test('copyWith creates new instance with updated values', () {
      // Arrange
      final original = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
      );

      // Act
      final updated = original.copyWith(
        imageUrl: 'https://example.com/new-image.png',
      );

      // Assert
      expect(updated.id, equals(original.id));
      expect(updated.firstLine, equals(original.firstLine));
      expect(updated.imageUrl, equals('https://example.com/new-image.png'));
      expect(original.imageUrl, isNull); // 元のオブジェクトは変更されない
    });

    test('equality works correctly', () {
      // Arrange
      final haiku1 = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
      );

      final haiku2 = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
      );

      // Assert
      expect(haiku1, equals(haiku2));
      expect(haiku1.hashCode, equals(haiku2.hashCode));
    });

    test('localImagePath field works correctly', () {
      // Arrange & Act
      final haiku = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        localImagePath: '/path/to/local/image.png',
      );

      // Assert
      expect(haiku.localImagePath, equals('/path/to/local/image.png'));
    });

    test('saveStatus field works correctly', () {
      // Arrange & Act
      final haiku = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        saveStatus: SaveStatus.localOnly,
      );

      // Assert
      expect(haiku.saveStatus, equals(SaveStatus.localOnly));
    });

    test('copyWith updates localImagePath correctly', () {
      // Arrange
      final original = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
      );

      // Act
      final updated = original.copyWith(localImagePath: '/new/path/image.png');

      // Assert
      expect(updated.localImagePath, equals('/new/path/image.png'));
      expect(original.localImagePath, isNull);
    });

    test('copyWith updates saveStatus correctly', () {
      // Arrange
      final original = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        saveStatus: SaveStatus.localOnly,
      );

      // Act
      final updated = original.copyWith(saveStatus: SaveStatus.saved);

      // Assert
      expect(updated.saveStatus, equals(SaveStatus.saved));
      expect(original.saveStatus, equals(SaveStatus.localOnly));
    });

    test('localImagePath and saveStatus are excluded from JSON', () {
      // Arrange
      final haiku = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        localImagePath: '/path/to/local.png',
        saveStatus: SaveStatus.localOnly,
      );

      // Act
      final json = haiku.toJson();

      // Assert
      expect(json.containsKey('localImagePath'), isFalse);
      expect(json.containsKey('saveStatus'), isFalse);
    });

    test('equality includes localImagePath and saveStatus', () {
      // Arrange
      final haiku1 = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        localImagePath: '/path/to/local.png',
        saveStatus: SaveStatus.localOnly,
      );

      final haiku2 = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        localImagePath: '/path/to/local.png',
        saveStatus: SaveStatus.localOnly,
      );

      final haiku3 = HaikuModel(
        id: 'test-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        localImagePath: '/different/path.png',
        saveStatus: SaveStatus.saved,
      );

      // Assert
      expect(haiku1, equals(haiku2));
      expect(haiku1.hashCode, equals(haiku2.hashCode));
      expect(haiku1, isNot(equals(haiku3)));
    });
  });
}
