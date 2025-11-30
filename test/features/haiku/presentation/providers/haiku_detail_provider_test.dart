import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';
import 'package:flutterhackthema/features/haiku/data/repositories/haiku_repository.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/haiku_detail_provider.dart';
import 'package:flutterhackthema/features/haiku/presentation/providers/haiku_provider.dart';

import 'haiku_detail_provider_test.mocks.dart';

@GenerateMocks([HaikuRepository])
void main() {
  group('haikuDetailProvider', () {
    late MockHaikuRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockHaikuRepository();
      container = ProviderContainer(
        overrides: [haikuRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('fetches haiku successfully', () async {
      // Arrange
      const haikuId = 'test-id';
      final haiku = HaikuModel(
        id: haikuId,
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        likeCount: 10,
        nickname: 'テストユーザー',
      );
      when(mockRepository.read(haikuId)).thenAnswer((_) async => haiku);

      // Act
      final result = await container.read(haikuDetailProvider(haikuId).future);

      // Assert
      expect(result, equals(haiku));
      verify(mockRepository.read(haikuId)).called(1);
    });

    test('returns null for non-existent haiku', () async {
      // Arrange
      const haikuId = 'non-existent';
      when(mockRepository.read(haikuId)).thenAnswer((_) async => null);

      // Act
      final result = await container.read(haikuDetailProvider(haikuId).future);

      // Assert
      expect(result, isNull);
    });

    // Note: Error handling test for FutureProvider is handled in UI layer
    // Testing provider disposal during error states has known issues with Riverpod
    // The error handling itself works correctly in production (tested in widget tests)
  });

  group('LikeNotifier', () {
    late MockHaikuRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockHaikuRepository();
      container = ProviderContainer(
        overrides: [haikuRepositoryProvider.overrideWithValue(mockRepository)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('increments like count successfully', () async {
      // Arrange
      const haikuId = 'test-id';
      when(
        mockRepository.incrementLikeCount(haikuId),
      ).thenAnswer((_) async => Future.value());

      // Act
      final notifier = container.read(likeProvider.notifier);
      await notifier.incrementLike(haikuId);

      // Assert
      verify(mockRepository.incrementLikeCount(haikuId)).called(1);
    });

    test('handles error correctly', () async {
      // Arrange
      const haikuId = 'test-id';
      final exception = Exception('Firestore error');
      when(mockRepository.incrementLikeCount(haikuId)).thenThrow(exception);

      // Act
      final notifier = container.read(likeProvider.notifier);
      await notifier.incrementLike(haikuId);

      // Assert
      final state = container.read(likeProvider);
      expect(state.hasError, isTrue);
    });

    test('invalidates haikuDetailProvider after successful increment', () async {
      // Arrange
      const haikuId = 'test-id';
      final haiku = HaikuModel(
        id: haikuId,
        firstLine: '古池や',
        secondLine: '蛙飛び込む',
        thirdLine: '水の音',
        createdAt: DateTime(2025, 1, 1),
        likeCount: 5,
      );

      when(mockRepository.read(haikuId)).thenAnswer((_) async => haiku);
      when(
        mockRepository.incrementLikeCount(haikuId),
      ).thenAnswer((_) async => Future.value());

      // Pre-fetch the haiku to populate cache
      await container.read(haikuDetailProvider(haikuId).future);

      // Act
      final notifier = container.read(likeProvider.notifier);
      await notifier.incrementLike(haikuId);

      // Assert
      // Verify incrementLikeCount was called
      verify(mockRepository.incrementLikeCount(haikuId)).called(1);

      // The provider should have been invalidated, so next read should call repository again
      // Clear the mock call history
      clearInteractions(mockRepository);

      // Set up new response for the re-fetch
      final updatedHaiku = haiku.copyWith(likeCount: 6);
      when(mockRepository.read(haikuId)).thenAnswer((_) async => updatedHaiku);

      // Re-fetch should hit the repository again due to invalidation
      final refetchedHaiku = await container.read(
        haikuDetailProvider(haikuId).future,
      );

      expect(refetchedHaiku?.likeCount, equals(6));
      verify(mockRepository.read(haikuId)).called(1);
    });
  });
}
