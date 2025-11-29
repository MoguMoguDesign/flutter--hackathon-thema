import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';

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
  });
}
