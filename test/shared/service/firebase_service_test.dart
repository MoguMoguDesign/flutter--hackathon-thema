import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:flutterhackthema/shared/service/firebase_service.dart';

import 'firebase_service_test.mocks.dart';

@GenerateMocks([FirebaseStorage])
void main() {
  group('FirebaseService', () {
    late FakeFirebaseFirestore fakeFirestore;
    late MockFirebaseStorage mockStorage;

    setUp(() {
      // FakeFirebaseFirestore インスタンスを作成
      fakeFirestore = FakeFirebaseFirestore();
      mockStorage = MockFirebaseStorage();

      // テスト用のインスタンスを設定
      FirebaseService.testFirestore = fakeFirestore;
      FirebaseService.testStorage = mockStorage;
    });

    tearDown(() {
      // テスト後にリセット
      FirebaseService.resetForTesting();
    });

    group('firestore', () {
      test('returns FirebaseFirestore instance', () {
        // Act
        final firestore = FirebaseService.firestore;

        // Assert
        expect(firestore, isA<FirebaseFirestore>());
        expect(firestore, equals(fakeFirestore));
      });

      test('returns same instance on multiple calls', () {
        // Act
        final firestore1 = FirebaseService.firestore;
        final firestore2 = FirebaseService.firestore;

        // Assert
        expect(firestore1, equals(firestore2));
        expect(firestore1, same(firestore2));
      });

      test('can perform basic Firestore operations', () async {
        // Arrange
        final firestore = FirebaseService.firestore;
        const testData = {'name': 'Test User', 'age': 25};

        // Act - Create document
        final docRef = await firestore.collection('users').add(testData);

        // Assert - Read document
        final snapshot = await docRef.get();
        expect(snapshot.exists, isTrue);
        expect(snapshot.data()?['name'], equals('Test User'));
        expect(snapshot.data()?['age'], equals(25));
      });

      test('supports real-time updates with FakeFirestore', () async {
        // Arrange
        final firestore = FirebaseService.firestore;
        final collection = firestore.collection('messages');

        // Act - Add a document first
        await collection.add({'text': 'Hello'});

        // Listen to snapshots
        final snapshot = await collection.snapshots().first;

        // Assert
        expect(snapshot.docs, hasLength(1));
        expect(snapshot.docs.first.data()['text'], equals('Hello'));
      });
    });

    group('storage', () {
      test('returns FirebaseStorage instance', () {
        // Act
        final storage = FirebaseService.storage;

        // Assert
        expect(storage, isA<FirebaseStorage>());
        expect(storage, equals(mockStorage));
      });

      test('returns same instance on multiple calls', () {
        // Act
        final storage1 = FirebaseService.storage;
        final storage2 = FirebaseService.storage;

        // Assert
        expect(storage1, equals(storage2));
        expect(storage1, same(storage2));
      });
    });

    group('resetForTesting', () {
      test('resets test instances to null', () {
        // Arrange
        expect(FirebaseService.testFirestore, equals(fakeFirestore));
        expect(FirebaseService.testStorage, equals(mockStorage));

        // Act
        FirebaseService.resetForTesting();

        // Assert
        expect(FirebaseService.testFirestore, isNull);
        expect(FirebaseService.testStorage, isNull);
      });
    });
  });
}
