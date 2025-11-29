import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/data/repositories/haiku_repository.dart';

/// テスト用のHaikuRepository (FakeFirebaseFirestoreを注入)
class TestHaikuRepository extends HaikuRepository {
  TestHaikuRepository({required FakeFirebaseFirestore fakeFirestore})
    : _fakeFirestore = fakeFirestore;

  final FakeFirebaseFirestore _fakeFirestore;

  @override
  FirebaseFirestore get firestore => _fakeFirestore;
}

void main() {
  group('HaikuRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late TestHaikuRepository repository;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      repository = TestHaikuRepository(fakeFirestore: fakeFirestore);
    });

    group('create', () {
      test('creates haiku with auto-generated ID', () async {
        // Arrange
        final haiku = HaikuModel(
          id: '', // auto-generated
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
          createdAt: DateTime(2025, 1, 1),
        );

        // Act
        final docId = await repository.create(haiku);

        // Assert
        expect(docId, isNotEmpty);

        final doc = await repository.collection.doc(docId).get();
        expect(doc.exists, isTrue);
        expect(doc.data()!['firstLine'], equals('古池や'));
      });

      test('creates haiku with custom ID', () async {
        // Arrange
        const customId = 'custom-haiku-id';
        final haiku = HaikuModel(
          id: customId,
          firstLine: '閑さや',
          secondLine: '岩にしみ入る',
          thirdLine: '蝉の声',
          createdAt: DateTime(2025, 1, 1),
        );

        // Act
        final docId = await repository.create(haiku, docId: customId);

        // Assert
        expect(docId, equals(customId));

        final doc = await repository.collection.doc(customId).get();
        expect(doc.exists, isTrue);
        expect(doc.data()!['secondLine'], equals('岩にしみ入る'));
      });
    });

    group('read', () {
      test('reads existing haiku', () async {
        // Arrange
        const docId = 'test-haiku';
        final haiku = HaikuModel(
          id: docId,
          firstLine: '菜の花や',
          secondLine: '月は東に',
          thirdLine: '日は西に',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(haiku, docId: docId);

        // Act
        final result = await repository.read(docId);

        // Assert
        expect(result, isNotNull);
        expect(result!.id, equals(docId));
        expect(result.firstLine, equals('菜の花や'));
      });

      test('returns null for non-existent haiku', () async {
        // Act
        final result = await repository.read('non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    group('update', () {
      test('updates existing haiku', () async {
        // Arrange
        const docId = 'update-test';
        final original = HaikuModel(
          id: docId,
          firstLine: '雪とけて',
          secondLine: '村いっぱいの',
          thirdLine: '子どもかな',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(original, docId: docId);

        final updated = original.copyWith(
          imageUrl: 'https://example.com/image.png',
        );

        // Act
        await repository.update(docId, updated);

        // Assert
        final result = await repository.read(docId);
        expect(result!.imageUrl, equals('https://example.com/image.png'));
      });
    });

    group('delete', () {
      test('deletes existing haiku', () async {
        // Arrange
        const docId = 'delete-test';
        final haiku = HaikuModel(
          id: docId,
          firstLine: '柿くへば',
          secondLine: '鐘が鳴るなり',
          thirdLine: '法隆寺',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(haiku, docId: docId);

        // Act
        await repository.delete(docId);

        // Assert
        final result = await repository.read(docId);
        expect(result, isNull);
      });
    });

    group('readAll', () {
      test('returns all haikus', () async {
        // Arrange
        final haiku1 = HaikuModel(
          id: 'haiku-1',
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
          createdAt: DateTime(2025, 1, 1),
        );
        final haiku2 = HaikuModel(
          id: 'haiku-2',
          firstLine: '閑さや',
          secondLine: '岩にしみ入る',
          thirdLine: '蝉の声',
          createdAt: DateTime(2025, 1, 2),
        );

        await repository.create(haiku1, docId: 'haiku-1');
        await repository.create(haiku2, docId: 'haiku-2');

        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, hasLength(2));
        expect(results.map((h) => h.firstLine), containsAll(['古池や', '閑さや']));
      });

      test('returns empty list when no haikus exist', () async {
        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, isEmpty);
      });
    });
  });
}
