import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/user/data/models/user.dart';

void main() {
  group('User', () {
    test('should create User instance with required fields', () {
      // Arrange
      final now = DateTime.now();

      // Act
      final user = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(user.id, 'test-id-123');
      expect(user.nickname, '俳句太郎');
      expect(user.createdAt, now);
      expect(user.updatedAt, now);
      expect(user.profileImageUrl, isNull);
      expect(user.bio, isNull);
    });

    test('should create User instance with optional fields', () {
      // Arrange
      final now = DateTime.now();

      // Act
      final user = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
        profileImageUrl: 'https://example.com/avatar.jpg',
        bio: 'よろしくお願いします',
      );

      // Assert
      expect(user.profileImageUrl, 'https://example.com/avatar.jpg');
      expect(user.bio, 'よろしくお願いします');
    });

    test('should serialize to JSON correctly', () {
      // Arrange
      final now = DateTime(2025);
      final user = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
      );

      // Act
      final json = user.toJson();

      // Assert
      expect(json['id'], 'test-id-123');
      expect(json['nickname'], '俳句太郎');
      expect(json['createdAt'], now.toIso8601String());
      expect(json['updatedAt'], now.toIso8601String());
    });

    test('should deserialize from JSON correctly', () {
      // Arrange
      final now = DateTime(2025);
      final json = {
        'id': 'test-id-123',
        'nickname': '俳句太郎',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.id, 'test-id-123');
      expect(user.nickname, '俳句太郎');
      expect(user.createdAt, now);
      expect(user.updatedAt, now);
    });

    test('should support copyWith', () {
      // Arrange
      final now = DateTime.now();
      final user = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
      );

      // Act
      final updatedUser = user.copyWith(nickname: '俳句花子');

      // Assert
      expect(updatedUser.id, 'test-id-123');
      expect(updatedUser.nickname, '俳句花子');
      expect(updatedUser.createdAt, now);
    });

    test('should support equality comparison', () {
      // Arrange
      final now = DateTime.now();
      final user1 = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
      );
      final user2 = User(
        id: 'test-id-123',
        nickname: '俳句太郎',
        createdAt: now,
        updatedAt: now,
      );
      final user3 = User(
        id: 'test-id-456',
        nickname: '俳句花子',
        createdAt: now,
        updatedAt: now,
      );

      // Assert
      expect(user1, user2);
      expect(user1, isNot(user3));
    });
  });
}
