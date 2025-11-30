// Test file for ImageSaveProvider
//
// Test coverage:
// - Initial state
// - saveImage success flow
// - saveImage error flows
// - reset functionality
//
// Dependencies:
// - flutter_test for assertions
// - hooks_riverpod for ProviderContainer
// - mockito for mocking

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterhackthema/features/haiku/data/repositories/haiku_image_storage_repository.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/image_save_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/state/image_save_state.dart';

import 'image_save_provider_test.mocks.dart';

@GenerateMocks([HaikuImageStorageRepository])
void main() {
  group('ImageSaveProvider', () {
    late MockHaikuImageStorageRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockHaikuImageStorageRepository();

      container = ProviderContainer(
        overrides: [
          haikuImageStorageRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is ImageSaveState.initial', () {
      // Act
      final state = container.read(imageSaveProvider);

      // Assert
      expect(state, isA<ImageSaveInitial>());
    });

    test('saveImage succeeds and returns download URL', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3, 4, 5]);
      const expectedUrl = 'https://storage.example.com/image.jpg';

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenAnswer((_) async => expectedUrl);

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(
        imageData: testData,
        haikuId: 'test-haiku-id',
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
      );

      // Assert
      expect(result, equals(expectedUrl));
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveSuccess>());
      expect((state as ImageSaveSuccess).downloadUrl, equals(expectedUrl));
    });

    test('saveImage returns error for empty image data', () async {
      // Arrange
      final emptyData = Uint8List(0);

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: emptyData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('画像データが空です'));

      // Verify repository was never called
      verifyNever(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      );
    });

    test('saveImage handles Firebase permission denied error', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'firebase_storage',
          code: 'permission-denied',
        ),
      );

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('保存の権限がありません'));
    });

    test('saveImage handles Firebase quota exceeded error', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(
        FirebaseException(plugin: 'firebase_storage', code: 'quota-exceeded'),
      );

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('ストレージ容量が不足しています'));
    });

    test('saveImage handles unexpected errors', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(Exception('Unexpected error'));

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('予期しないエラーが発生しました'));
    });

    test('reset returns to initial state', () async {
      // Arrange - first get to a non-initial state
      final testData = Uint8List.fromList([1, 2, 3, 4, 5]);
      const expectedUrl = 'https://storage.example.com/image.jpg';

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenAnswer((_) async => expectedUrl);

      final notifier = container.read(imageSaveProvider.notifier);
      await notifier.saveImage(imageData: testData);

      // Verify we're in success state
      expect(container.read(imageSaveProvider), isA<ImageSaveSuccess>());

      // Act
      notifier.reset();

      // Assert
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveInitial>());
    });

    test('saveImage handles Firebase canceled error', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(
        FirebaseException(plugin: 'firebase_storage', code: 'canceled'),
      );

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('保存がキャンセルされました'));
    });

    test('saveImage handles Firebase unauthenticated error', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(
        FirebaseException(plugin: 'firebase_storage', code: 'unauthenticated'),
      );

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('認証が必要です'));
    });

    test('saveImage handles unknown Firebase error', () async {
      // Arrange
      final testData = Uint8List.fromList([1, 2, 3]);

      when(
        mockRepository.uploadHaikuImage(
          imageData: anyNamed('imageData'),
          haikuId: anyNamed('haikuId'),
          userId: anyNamed('userId'),
          metadata: anyNamed('metadata'),
        ),
      ).thenThrow(
        FirebaseException(
          plugin: 'firebase_storage',
          code: 'unknown-error-code',
        ),
      );

      // Act
      final notifier = container.read(imageSaveProvider.notifier);
      final result = await notifier.saveImage(imageData: testData);

      // Assert
      expect(result, isNull);
      final state = container.read(imageSaveProvider);
      expect(state, isA<ImageSaveError>());
      expect((state as ImageSaveError).message, equals('保存に失敗しました。再試行してください'));
    });
  });
}
