import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterhackthema/features/nickname/data/models/nickname_model.dart';
import 'package:flutterhackthema/features/nickname/data/repositories/nickname_repository.dart';
import 'package:flutterhackthema/features/nickname/service/user_id_service.dart';

@GenerateMocks([UserIdService])
import 'nickname_repository_test.mocks.dart';

void main() {
  group('NicknameRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late MockUserIdService mockUserIdService;
    late NicknameRepository repository;
    const String testUserId = 'test-user-id-123';

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      mockUserIdService = MockUserIdService();

      when(mockUserIdService.getUserId()).thenAnswer((_) async => testUserId);

      repository = NicknameRepository(
        userIdService: mockUserIdService,
        firestore: fakeFirestore,
      );
    });

    group('getNickname', () {
      test('returns null when no nickname is saved', () async {
        final NicknameModel? result = await repository.getNickname();

        expect(result, isNull);
      });

      test('returns saved nickname when one exists', () async {
        // Firestoreにテストデータを追加
        await fakeFirestore.collection('users').doc(testUserId).set({
          'nickname': 'TestUser',
          'updatedAt': Timestamp.now(),
        });

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals('TestUser'));
      });
    });

    group('saveNickname', () {
      test('saves nickname successfully (new)', () async {
        final bool result = await repository.saveNickname('NewUser');

        expect(result, isTrue);

        final doc = await fakeFirestore
            .collection('users')
            .doc(testUserId)
            .get();

        expect(doc.exists, isTrue);
        expect(doc.data()!['nickname'], equals('NewUser'));
      });

      test('saved nickname can be retrieved', () async {
        await repository.saveNickname('SavedUser');

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals('SavedUser'));
      });

      test('overwrites existing nickname', () async {
        await repository.saveNickname('FirstUser');
        await repository.saveNickname('SecondUser');

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals('SecondUser'));
      });

      test('saves empty string', () async {
        await repository.saveNickname('');

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals(''));
      });

      test('saves nickname with special characters', () async {
        const String specialNickname = 'User@123_Test';
        await repository.saveNickname(specialNickname);

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals(specialNickname));
      });

      test('saves nickname with Japanese characters', () async {
        const String japaneseNickname = 'テストユーザー';
        await repository.saveNickname(japaneseNickname);

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals(japaneseNickname));
      });

      test('saves 20 character nickname', () async {
        const String maxLengthNickname = '12345678901234567890';
        await repository.saveNickname(maxLengthNickname);

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNotNull);
        expect(result!.nickname, equals(maxLengthNickname));
        expect(result.nickname.length, equals(20));
      });
    });

    group('clearNickname', () {
      test('clears saved nickname', () async {
        await repository.saveNickname('UserToDelete');
        await repository.clearNickname();

        final NicknameModel? result = await repository.getNickname();

        expect(result, isNull);
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

    group('UserIdService integration', () {
      test('uses correct userId from UserIdService', () async {
        await repository.saveNickname('TestUser');

        // UserIdServiceが呼ばれたことを確認
        verify(mockUserIdService.getUserId()).called(greaterThan(0));

        // 正しいuserIdでドキュメントが作成されたことを確認
        final doc = await fakeFirestore
            .collection('users')
            .doc(testUserId)
            .get();

        expect(doc.exists, isTrue);
      });
    });

    group('fromFirestore and toFirestore', () {
      test('correctly converts model to Firestore format', () async {
        final model = NicknameModel(
          nickname: 'ConversionTest',
          updatedAt: DateTime.now(),
        );

        final Map<String, dynamic> firestoreData = repository.toFirestore(
          model,
        );

        expect(firestoreData['nickname'], equals('ConversionTest'));
        expect(firestoreData['updatedAt'], isA<Timestamp>());
      });

      test('correctly converts Firestore document to model', () async {
        final now = DateTime.now();
        await fakeFirestore.collection('users').doc(testUserId).set({
          'nickname': 'DocumentTest',
          'updatedAt': Timestamp.fromDate(now),
        });

        final doc = await fakeFirestore
            .collection('users')
            .doc(testUserId)
            .get();

        final model = repository.fromFirestore(doc);

        expect(model.nickname, equals('DocumentTest'));
        expect(
          model.updatedAt.millisecondsSinceEpoch,
          closeTo(now.millisecondsSinceEpoch, 1000),
        );
      });
    });
  });
}
