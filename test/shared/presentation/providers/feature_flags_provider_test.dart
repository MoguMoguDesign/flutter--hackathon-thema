import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutterhackthema/shared/presentation/providers/feature_flags_provider.dart';

void main() {
  group('FeatureFlags', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have like feature disabled by default', () {
      // Act
      final state = container.read(featureFlagsProvider);

      // Assert
      expect(state.isLikeFeatureEnabled, false);
    });

    test('should enable like feature', () {
      // Arrange
      final notifier = container.read(featureFlagsProvider.notifier);

      // Act
      notifier.enableLikeFeature();
      final state = container.read(featureFlagsProvider);

      // Assert
      expect(state.isLikeFeatureEnabled, true);
    });

    test('should disable like feature', () {
      // Arrange
      final notifier = container.read(featureFlagsProvider.notifier);
      notifier.enableLikeFeature();

      // Act
      notifier.disableLikeFeature();
      final state = container.read(featureFlagsProvider);

      // Assert
      expect(state.isLikeFeatureEnabled, false);
    });

    test('should toggle like feature', () {
      // Arrange
      final notifier = container.read(featureFlagsProvider.notifier);

      // Act & Assert - Toggle from false to true
      notifier.toggleLikeFeature();
      expect(container.read(featureFlagsProvider).isLikeFeatureEnabled, true);

      // Act & Assert - Toggle from true to false
      notifier.toggleLikeFeature();
      expect(container.read(featureFlagsProvider).isLikeFeatureEnabled, false);
    });

    test('isLikeFeatureEnabled provider should return correct value', () {
      // Arrange
      final notifier = container.read(featureFlagsProvider.notifier);

      // Assert - Initially false
      expect(container.read(isLikeFeatureEnabledProvider), false);

      // Act - Enable
      notifier.enableLikeFeature();

      // Assert - Now true
      expect(container.read(isLikeFeatureEnabledProvider), true);
    });
  });

  group('FeatureFlagsState', () {
    test('should create state with given value', () {
      // Act
      const state = FeatureFlagsState(isLikeFeatureEnabled: true);

      // Assert
      expect(state.isLikeFeatureEnabled, true);
    });

    test('should support copyWith', () {
      // Arrange
      const state = FeatureFlagsState(isLikeFeatureEnabled: false);

      // Act
      final newState = state.copyWith(isLikeFeatureEnabled: true);

      // Assert
      expect(newState.isLikeFeatureEnabled, true);
      expect(state.isLikeFeatureEnabled, false); // Original unchanged
    });

    test('copyWith should preserve value if not provided', () {
      // Arrange
      const state = FeatureFlagsState(isLikeFeatureEnabled: true);

      // Act
      final newState = state.copyWith();

      // Assert
      expect(newState.isLikeFeatureEnabled, true);
    });
  });
}
