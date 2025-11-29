import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/shared/service/firebase_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Firebase初期化（テスト用）
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'test-api-key',
        appId: 'test-app-id',
        messagingSenderId: 'test-sender-id',
        projectId: 'test-project',
      ),
    );
  });

  group('FirebaseService', () {
    test('firestore returns FirebaseFirestore instance', () {
      // Act
      final firestore = FirebaseService.firestore;

      // Assert
      expect(firestore, isA<FirebaseFirestore>());
      expect(firestore, equals(FirebaseFirestore.instance));
    });

    test('storage returns FirebaseStorage instance', () {
      // Act
      final storage = FirebaseService.storage;

      // Assert
      expect(storage, isA<FirebaseStorage>());
      expect(storage, equals(FirebaseStorage.instance));
    });

    test('firestore getter returns same instance on multiple calls', () {
      // Act
      final firestore1 = FirebaseService.firestore;
      final firestore2 = FirebaseService.firestore;

      // Assert
      expect(firestore1, equals(firestore2));
    });

    test('storage getter returns same instance on multiple calls', () {
      // Act
      final storage1 = FirebaseService.storage;
      final storage2 = FirebaseService.storage;

      // Assert
      expect(storage1, equals(storage2));
    });
  });
}
