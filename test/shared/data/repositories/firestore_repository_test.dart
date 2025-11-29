import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/shared/data/repositories/firestore_repository.dart';

/// テスト用のデータモデル
class TestModel {
  const TestModel({required this.id, required this.name, required this.value});

  final String id;
  final String name;
  final int value;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'value': value};
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as String,
      name: json['name'] as String,
      value: json['value'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestModel &&
        other.id == id &&
        other.name == name &&
        other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ value.hashCode;
}

/// テスト用のリポジトリ実装
class TestRepository extends FirestoreRepository<TestModel> {
  TestRepository({required this.fakeFirestore})
    : super(collectionPath: 'test_collection');

  final FakeFirebaseFirestore fakeFirestore;

  @override
  FirebaseFirestore get firestore => fakeFirestore;

  @override
  TestModel fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TestModel.fromJson(data);
  }

  @override
  Map<String, dynamic> toFirestore(TestModel data) {
    return data.toJson();
  }
}

void main() {
  group('FirestoreRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late TestRepository repository;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      repository = TestRepository(fakeFirestore: fakeFirestore);
    });

    group('create', () {
      test('creates document with auto-generated ID', () async {
        // Arrange
        const testModel = TestModel(id: 'test-1', name: 'Test Item', value: 42);

        // Act
        final docId = await repository.create(testModel);

        // Assert
        expect(docId, isNotEmpty);

        final snapshot = await repository.collection.doc(docId).get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data()!['name'], equals('Test Item'));
      });

      test('creates document with specified ID', () async {
        // Arrange
        const testModel = TestModel(
          id: 'custom-id',
          name: 'Custom ID Item',
          value: 100,
        );

        // Act
        final docId = await repository.create(testModel, docId: 'custom-id');

        // Assert
        expect(docId, equals('custom-id'));

        final snapshot = await repository.collection.doc('custom-id').get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data()!['value'], equals(100));
      });
    });

    group('read', () {
      test('returns model when document exists', () async {
        // Arrange
        const testModel = TestModel(
          id: 'read-test',
          name: 'Read Test',
          value: 50,
        );
        await repository.create(testModel, docId: 'read-test');

        // Act
        final result = await repository.read('read-test');

        // Assert
        expect(result, isNotNull);
        expect(result, equals(testModel));
      });

      test('returns null when document does not exist', () async {
        // Act
        final result = await repository.read('non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    group('update', () {
      test('updates existing document', () async {
        // Arrange
        const original = TestModel(
          id: 'update-test',
          name: 'Original',
          value: 10,
        );
        await repository.create(original, docId: 'update-test');

        const updated = TestModel(
          id: 'update-test',
          name: 'Updated',
          value: 20,
        );

        // Act
        await repository.update('update-test', updated);

        // Assert
        final result = await repository.read('update-test');
        expect(result, equals(updated));
      });
    });

    group('delete', () {
      test('deletes existing document', () async {
        // Arrange
        const testModel = TestModel(
          id: 'delete-test',
          name: 'To Delete',
          value: 99,
        );
        await repository.create(testModel, docId: 'delete-test');

        // Act
        await repository.delete('delete-test');

        // Assert
        final result = await repository.read('delete-test');
        expect(result, isNull);
      });
    });

    group('readAll', () {
      test('returns all documents in collection', () async {
        // Arrange
        const model1 = TestModel(id: '1', name: 'Item 1', value: 1);
        const model2 = TestModel(id: '2', name: 'Item 2', value: 2);
        const model3 = TestModel(id: '3', name: 'Item 3', value: 3);

        await repository.create(model1, docId: '1');
        await repository.create(model2, docId: '2');
        await repository.create(model3, docId: '3');

        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, hasLength(3));
        expect(results, containsAll([model1, model2, model3]));
      });

      test('returns empty list when collection is empty', () async {
        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, isEmpty);
      });
    });

    group('watchAll', () {
      test('emits updates when documents change', () async {
        // Arrange
        const model1 = TestModel(id: '1', name: 'Item 1', value: 1);

        // Act
        final stream = repository.watchAll();

        // Assert
        expect(
          stream,
          emitsInOrder([
            [], // Initial empty state
            [model1], // After adding model1
          ]),
        );

        // Trigger changes
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create(model1, docId: '1');
      });
    });

    group('watch', () {
      test('emits updates when specific document changes', () async {
        // Arrange
        const original = TestModel(
          id: 'watch-test',
          name: 'Original',
          value: 1,
        );
        const updated = TestModel(id: 'watch-test', name: 'Updated', value: 2);

        // Act
        final stream = repository.watch('watch-test');

        // Assert
        expect(
          stream,
          emitsInOrder([
            null, // Document doesn't exist initially
            original, // After creating
            updated, // After updating
          ]),
        );

        // Trigger changes
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.create(original, docId: 'watch-test');
        await Future.delayed(const Duration(milliseconds: 10));
        await repository.update('watch-test', updated);
      });
    });
  });
}
