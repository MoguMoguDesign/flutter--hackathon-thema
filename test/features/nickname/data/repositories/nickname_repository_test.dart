import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterhackthema/features/nickname/data/repositories/nickname_repository.dart';

void main() {
  group('NicknameRepository', () {
    late NicknameRepository repository;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      repository = NicknameRepository();
    });

    group('getNickname', () {
      test('returns null when no nickname is saved', () async {
        final String? nickname = await repository.getNickname();

        expect(nickname, isNull);
      });

      test('returns saved nickname when one exists', () async {
        SharedPreferences.setMockInitialValues({'nickname': 'TestUser'});
        repository = NicknameRepository();

        final String? nickname = await repository.getNickname();

        expect(nickname, equals('TestUser'));
      });
    });

    group('saveNickname', () {
      test('saves nickname successfully', () async {
        final bool result = await repository.saveNickname('NewUser');

        expect(result, isTrue);
      });

      test('saved nickname can be retrieved', () async {
        await repository.saveNickname('SavedUser');

        final String? nickname = await repository.getNickname();

        expect(nickname, equals('SavedUser'));
      });

      test('overwrites existing nickname', () async {
        await repository.saveNickname('FirstUser');
        await repository.saveNickname('SecondUser');

        final String? nickname = await repository.getNickname();

        expect(nickname, equals('SecondUser'));
      });

      test('saves empty string', () async {
        await repository.saveNickname('');

        final String? nickname = await repository.getNickname();

        expect(nickname, equals(''));
      });

      test('saves nickname with special characters', () async {
        const String specialNickname = 'User@123_Test';
        await repository.saveNickname(specialNickname);

        final String? nickname = await repository.getNickname();

        expect(nickname, equals(specialNickname));
      });

      test('saves nickname with Japanese characters', () async {
        const String japaneseNickname = 'テストユーザー';
        await repository.saveNickname(japaneseNickname);

        final String? nickname = await repository.getNickname();

        expect(nickname, equals(japaneseNickname));
      });
    });

    group('clearNickname', () {
      test('clears saved nickname', () async {
        await repository.saveNickname('UserToDelete');
        await repository.clearNickname();

        final String? nickname = await repository.getNickname();

        expect(nickname, isNull);
      });

      test('returns true when clearing existing nickname', () async {
        await repository.saveNickname('ExistingUser');

        final bool result = await repository.clearNickname();

        expect(result, isTrue);
      });

      test('returns true when clearing non-existent nickname', () async {
        final bool result = await repository.clearNickname();

        expect(result, isTrue);
      });
    });
  });
}
