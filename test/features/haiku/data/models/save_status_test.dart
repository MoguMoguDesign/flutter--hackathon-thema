import 'package:flutter_test/flutter_test.dart';
import 'package:flutterhackthema/features/haiku/data/models/save_status.dart';

void main() {
  group('SaveStatus', () {
    test('has all expected values', () {
      // Assert
      expect(SaveStatus.values.length, equals(4));
      expect(SaveStatus.values, contains(SaveStatus.localOnly));
      expect(SaveStatus.values, contains(SaveStatus.saving));
      expect(SaveStatus.values, contains(SaveStatus.saved));
      expect(SaveStatus.values, contains(SaveStatus.failed));
    });
  });

  group('SaveStatusExtension', () {
    test('isSaved returns true only for saved status', () {
      // Assert
      expect(SaveStatus.saved.isSaved, isTrue);
      expect(SaveStatus.localOnly.isSaved, isFalse);
      expect(SaveStatus.saving.isSaved, isFalse);
      expect(SaveStatus.failed.isSaved, isFalse);
    });

    test('isSaving returns true only for saving status', () {
      // Assert
      expect(SaveStatus.saving.isSaving, isTrue);
      expect(SaveStatus.localOnly.isSaving, isFalse);
      expect(SaveStatus.saved.isSaving, isFalse);
      expect(SaveStatus.failed.isSaving, isFalse);
    });

    test('isFailed returns true only for failed status', () {
      // Assert
      expect(SaveStatus.failed.isFailed, isTrue);
      expect(SaveStatus.localOnly.isFailed, isFalse);
      expect(SaveStatus.saving.isFailed, isFalse);
      expect(SaveStatus.saved.isFailed, isFalse);
    });

    test('isLocalOnly returns true only for localOnly status', () {
      // Assert
      expect(SaveStatus.localOnly.isLocalOnly, isTrue);
      expect(SaveStatus.saving.isLocalOnly, isFalse);
      expect(SaveStatus.saved.isLocalOnly, isFalse);
      expect(SaveStatus.failed.isLocalOnly, isFalse);
    });

    test('needsSave returns true for all statuses except saved', () {
      // Assert
      expect(SaveStatus.localOnly.needsSave, isTrue);
      expect(SaveStatus.saving.needsSave, isTrue);
      expect(SaveStatus.failed.needsSave, isTrue);
      expect(SaveStatus.saved.needsSave, isFalse);
    });

    test('displayText returns correct Japanese text', () {
      // Assert
      expect(SaveStatus.localOnly.displayText, equals('保存待ち'));
      expect(SaveStatus.saving.displayText, equals('保存中'));
      expect(SaveStatus.saved.displayText, equals('保存完了'));
      expect(SaveStatus.failed.displayText, equals('保存失敗'));
    });
  });
}
