import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/posts/data/models/post.dart';

void main() {
  group('Post', () {
    test('fromJson creates valid Post', () {
      // Arrange
      final json = {
        'id': 'test-id',
        'nickname': 'テストユーザー',
        'haiku': '古池や\n蛙飛び込む\n水の音',
        'imageUrl': 'https://example.com/image.png',
        'createdAt': DateTime(2025, 1, 1).toIso8601String(),
        'likeCount': 10,
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.id, equals('test-id'));
      expect(post.nickname, equals('テストユーザー'));
      expect(post.haiku, equals('古池や\n蛙飛び込む\n水の音'));
      expect(post.imageUrl, equals('https://example.com/image.png'));
      expect(post.createdAt, equals(DateTime(2025, 1, 1)));
      expect(post.likeCount, equals(10));
    });

    test('toJson creates valid JSON', () {
      // Arrange
      final post = Post(
        id: 'test-id',
        nickname: 'テストユーザー',
        haiku: '古池や\n蛙飛び込む\n水の音',
        imageUrl: 'https://example.com/image.png',
        createdAt: DateTime(2025, 1, 1),
        likeCount: 10,
      );

      // Act
      final json = post.toJson();

      // Assert
      expect(json['id'], equals('test-id'));
      expect(json['nickname'], equals('テストユーザー'));
      expect(json['haiku'], equals('古池や\n蛙飛び込む\n水の音'));
      expect(json['imageUrl'], equals('https://example.com/image.png'));
      expect(json['createdAt'], equals(DateTime(2025, 1, 1).toIso8601String()));
      expect(json['likeCount'], equals(10));
    });

    test('fromJson with default likeCount', () {
      // Arrange
      final json = {
        'id': 'test-id',
        'nickname': 'テストユーザー',
        'haiku': '古池や\n蛙飛び込む\n水の音',
        'imageUrl': 'https://example.com/image.png',
        'createdAt': DateTime(2025, 1, 1).toIso8601String(),
      };

      // Act
      final post = Post.fromJson(json);

      // Assert
      expect(post.likeCount, equals(0)); // デフォルト値
    });

    test('creates Post with default likeCount', () {
      // Arrange & Act
      final post = Post(
        id: 'test-id',
        nickname: 'テストユーザー',
        haiku: '古池や\n蛙飛び込む\n水の音',
        imageUrl: 'https://example.com/image.png',
        createdAt: DateTime(2025, 1, 1),
      );

      // Assert
      expect(post.likeCount, equals(0)); // デフォルト値
    });

    test('creates Post with const constructor', () {
      // Arrange & Act
      final post = Post(
        id: 'test-id',
        nickname: 'テストユーザー',
        haiku: '古池や\n蛙飛び込む\n水の音',
        imageUrl: 'https://example.com/image.png',
        createdAt: DateTime(2025, 1, 1),
        likeCount: 10,
      );

      // Assert
      expect(post.id, equals('test-id'));
      expect(post.likeCount, equals(10));
    });

    test('JSON roundtrip preserves data', () {
      // Arrange
      final original = Post(
        id: 'test-id',
        nickname: 'テストユーザー',
        haiku: '古池や\n蛙飛び込む\n水の音',
        imageUrl: 'https://example.com/image.png',
        createdAt: DateTime(2025, 1, 1),
        likeCount: 10,
      );

      // Act
      final json = original.toJson();
      final restored = Post.fromJson(json);

      // Assert
      expect(restored.id, equals(original.id));
      expect(restored.nickname, equals(original.nickname));
      expect(restored.haiku, equals(original.haiku));
      expect(restored.imageUrl, equals(original.imageUrl));
      expect(restored.createdAt, equals(original.createdAt));
      expect(restored.likeCount, equals(original.likeCount));
    });
  });
}
