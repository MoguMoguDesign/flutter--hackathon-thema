import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterhackthema/features/nickname/service/user_id_service.dart';

void main() {
  group('UserIdService', () {
    late UserIdService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      service = UserIdService();
    });

    test('初回呼び出し時にUUIDを生成する', () async {
      final String userId = await service.getUserId();

      expect(userId, isNotEmpty);
      expect(
        userId,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });

    test('既存のIDを返す（2回目以降は同じIDを返す）', () async {
      final String userId1 = await service.getUserId();
      final String userId2 = await service.getUserId();

      expect(userId1, equals(userId2));
    });

    test('UUID v4形式が正しい', () async {
      final String userId = await service.getUserId();

      // UUIDv4の形式: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
      // yは8, 9, a, bのいずれか
      expect(userId, matches(RegExp(r'^[0-9a-f-]{36}$')));
      expect(userId.split('-').length, equals(5));
      expect(userId[14], equals('4')); // バージョン番号
    });

    test('clearUserId()でIDを削除できる', () async {
      await service.getUserId();
      final bool result = await service.clearUserId();

      expect(result, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('user_id'), isNull);
    });

    test('clearUserId()後に再度getUserId()を呼ぶと新しいIDが生成される', () async {
      final String userId1 = await service.getUserId();
      await service.clearUserId();
      final String userId2 = await service.getUserId();

      expect(userId1, isNot(equals(userId2)));
      expect(userId2, isNotEmpty);
    });
  });
}
