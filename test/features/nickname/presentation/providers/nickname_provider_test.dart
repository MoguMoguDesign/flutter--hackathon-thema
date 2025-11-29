import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterhackthema/features/nickname/presentation/providers/nickname_provider.dart';

void main() {
  group('NicknameRepositoryNotifier', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('provides NicknameRepository instance', () {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      final repository = container.read(nicknameRepositoryProvider);

      expect(repository, isNotNull);
    });
  });

  group('NicknameNotifier', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state returns null when no nickname saved', () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      final String? nickname = await container.read(nicknameProvider.future);

      expect(nickname, isNull);
    });

    test('initial state returns saved nickname when one exists', () async {
      SharedPreferences.setMockInitialValues({'nickname': 'SavedUser'});

      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      final String? nickname = await container.read(nicknameProvider.future);

      expect(nickname, equals('SavedUser'));
    });

    test('setNickname updates state and persists', () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set nickname
      await container.read(nicknameProvider.notifier).setNickname('NewUser');

      // Verify state is updated
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('NewUser'));
    });

    test('setNickname persists to SharedPreferences', () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set nickname
      await container
          .read(nicknameProvider.notifier)
          .setNickname('PersistedUser');

      // Create new container to verify persistence
      final ProviderContainer newContainer = ProviderContainer();
      addTearDown(newContainer.dispose);

      final String? nickname = await newContainer.read(nicknameProvider.future);
      expect(nickname, equals('PersistedUser'));
    });

    test('clearNickname removes nickname and updates state', () async {
      SharedPreferences.setMockInitialValues({'nickname': 'ExistingUser'});

      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Clear nickname
      await container.read(nicknameProvider.notifier).clearNickname();

      // Verify state is null
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, isNull);
    });

    test('clearNickname removes from SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'nickname': 'UserToDelete'});

      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Clear nickname
      await container.read(nicknameProvider.notifier).clearNickname();

      // Verify in SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('nickname'), isNull);
    });

    test('setNickname handles Japanese characters', () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set Japanese nickname
      await container.read(nicknameProvider.notifier).setNickname('テストユーザー');

      // Verify state is updated
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('テストユーザー'));
    });

    test('multiple setNickname calls overwrite previous value', () async {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set multiple nicknames
      await container.read(nicknameProvider.notifier).setNickname('First');
      await container.read(nicknameProvider.notifier).setNickname('Second');
      await container.read(nicknameProvider.notifier).setNickname('Third');

      // Verify final state
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('Third'));
    });
  });
}
