import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/data/models/haiku.dart';

void main() {
  group('Haiku', () {
    test('should create Haiku instance with required fields', () {
      // Arrange
      final now = DateTime.now();

      // Act
      final haiku = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(haiku.id, 'haiku-id-123');
      expect(haiku.userId, 'user-id-123');
      expect(haiku.authorNickname, '俳句太郎');
      expect(haiku.text, '古池や蛙飛びこむ水の音');
      expect(haiku.firstLine, '古池や');
      expect(haiku.secondLine, '蛙飛びこむ');
      expect(haiku.thirdLine, '水の音');
      expect(haiku.imageUrl, 'https://example.com/haiku.jpg');
      expect(haiku.createdAt, now);
      expect(haiku.updatedAt, now);
      expect(haiku.tags, []);
      expect(haiku.seasonWord, isNull);
    });

    test('should create Haiku instance with optional fields', () {
      // Arrange
      final now = DateTime.now();

      // Act
      final haiku = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
        tags: ['春', '自然'],
        seasonWord: '蛙',
      );

      // Assert
      expect(haiku.tags, ['春', '自然']);
      expect(haiku.seasonWord, '蛙');
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final now = DateTime(2025, 1, 1);
      final haiku = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
        tags: ['春'],
      );

      // Act
      final json = haiku.toJson();

      // Assert
      expect(json['id'], 'haiku-id-123');
      expect(json['userId'], 'user-id-123');
      expect(json['authorNickname'], '俳句太郎');
      expect(json['text'], '古池や蛙飛びこむ水の音');
      expect(json['firstLine'], '古池や');
      expect(json['secondLine'], '蛙飛びこむ');
      expect(json['thirdLine'], '水の音');
      expect(json['imageUrl'], 'https://example.com/haiku.jpg');
      expect(json['tags'], ['春']);
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final now = DateTime(2025, 1, 1);
      final json = {
        'id': 'haiku-id-123',
        'userId': 'user-id-123',
        'authorNickname': '俳句太郎',
        'text': '古池や蛙飛びこむ水の音',
        'firstLine': '古池や',
        'secondLine': '蛙飛びこむ',
        'thirdLine': '水の音',
        'imageUrl': 'https://example.com/haiku.jpg',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'tags': ['春', '自然'],
        'seasonWord': '蛙',
      };

      // Act
      final haiku = Haiku.fromJson(json);

      // Assert
      expect(haiku.id, 'haiku-id-123');
      expect(haiku.userId, 'user-id-123');
      expect(haiku.authorNickname, '俳句太郎');
      expect(haiku.text, '古池や蛙飛びこむ水の音');
      expect(haiku.tags, ['春', '自然']);
      expect(haiku.seasonWord, '蛙');
    });

    test('should support copyWith', () {
      // Arrange
      final now = DateTime.now();
      final haiku = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
      );

      // Act
      final updatedHaiku = haiku.copyWith(
        text: '夏草や兵どもが夢の跡',
        tags: ['夏', '歴史'],
      );

      // Assert
      expect(updatedHaiku.id, 'haiku-id-123');
      expect(updatedHaiku.text, '夏草や兵どもが夢の跡');
      expect(updatedHaiku.tags, ['夏', '歴史']);
    });

    test('should support equality comparison', () {
      // Arrange
      final now = DateTime.now();
      final haiku1 = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
      );
      final haiku2 = Haiku(
        id: 'haiku-id-123',
        userId: 'user-id-123',
        authorNickname: '俳句太郎',
        text: '古池や蛙飛びこむ水の音',
        firstLine: '古池や',
        secondLine: '蛙飛びこむ',
        thirdLine: '水の音',
        imageUrl: 'https://example.com/haiku.jpg',
        createdAt: now,
        updatedAt: now,
      );
      final haiku3 = Haiku(
        id: 'haiku-id-456',
        userId: 'user-id-456',
        authorNickname: '俳句花子',
        text: '夏草や兵どもが夢の跡',
        firstLine: '夏草や',
        secondLine: '兵どもが',
        thirdLine: '夢の跡',
        imageUrl: 'https://example.com/haiku2.jpg',
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(haiku1, haiku2);
      expect(haiku1, isNot(haiku3));
    });
  });
}
