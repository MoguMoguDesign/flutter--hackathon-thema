import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterhackthema/features/nickname/data/repositories/nickname_repository.dart';
import 'package:flutterhackthema/features/nickname/presentation/providers/nickname_provider.dart';
import 'package:flutterhackthema/features/nickname/service/user_id_service.dart';

import 'nickname_provider_test.mocks.dart';

@GenerateMocks([UserIdService])
void main() {
  group('UserIdService Provider', () {
    test('provides UserIdService instance', () {
      final ProviderContainer container = ProviderContainer();
      addTearDown(container.dispose);

      final userIdService = container.read(userIdServiceProvider);

      expect(userIdService, isNotNull);
      expect(userIdService, isA<UserIdService>());
    });
  });

  group('NicknameRepository Provider', () {
    late MockUserIdService mockUserIdService;

    setUp(() {
      mockUserIdService = MockUserIdService();
      SharedPreferences.setMockInitialValues({});
    });

    test('provides NicknameRepository instance', () {
      final ProviderContainer container = ProviderContainer(
        overrides: [userIdServiceProvider.overrideWithValue(mockUserIdService)],
      );
      addTearDown(container.dispose);

      final repository = container.read(nicknameRepositoryProvider);

      expect(repository, isNotNull);
      expect(repository, isA<NicknameRepository>());
    });

    test('provides same NicknameRepository instance (keepAlive)', () {
      final ProviderContainer container = ProviderContainer(
        overrides: [userIdServiceProvider.overrideWithValue(mockUserIdService)],
      );
      addTearDown(container.dispose);

      final repository1 = container.read(nicknameRepositoryProvider);
      final repository2 = container.read(nicknameRepositoryProvider);

      expect(identical(repository1, repository2), isTrue);
    });
  });

  group('NicknameNotifier', () {
    late FakeFirebaseFirestore fakeFirestore;
    late MockUserIdService mockUserIdService;
    const String testUserId = 'test-user-id';

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      mockUserIdService = MockUserIdService();
      when(mockUserIdService.getUserId()).thenAnswer((_) async => testUserId);
      SharedPreferences.setMockInitialValues({});
    });

    ProviderContainer createContainer() {
      return ProviderContainer(
        overrides: [
          userIdServiceProvider.overrideWithValue(mockUserIdService),
          nicknameRepositoryProvider.overrideWithValue(
            NicknameRepository(
              userIdService: mockUserIdService,
              firestore: fakeFirestore,
            ),
          ),
        ],
      );
    }

    test('initial state returns null when no nickname saved', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      final String? nickname = await container.read(nicknameProvider.future);

      expect(nickname, isNull);
    });

    test('initial state returns saved nickname when one exists', () async {
      // Pre-populate Firestore
      await fakeFirestore.collection('users').doc(testUserId).set({
        'nickname': 'SavedUser',
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      final String? nickname = await container.read(nicknameProvider.future);

      expect(nickname, equals('SavedUser'));
    });

    test('setNickname updates state and persists to Firestore', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set nickname
      await container.read(nicknameProvider.notifier).setNickname('NewUser');

      // Verify state is updated
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('NewUser'));

      // Verify in Firestore
      final doc = await fakeFirestore.collection('users').doc(testUserId).get();
      expect(doc.data()?['nickname'], equals('NewUser'));
    });

    test('setNickname persists to Firestore', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set nickname
      await container
          .read(nicknameProvider.notifier)
          .setNickname('PersistedUser');

      // Create new container to verify persistence
      final ProviderContainer newContainer = createContainer();
      addTearDown(newContainer.dispose);

      final String? nickname = await newContainer.read(nicknameProvider.future);
      expect(nickname, equals('PersistedUser'));
    });

    test('clearNickname removes nickname and updates state', () async {
      // Pre-populate Firestore
      await fakeFirestore.collection('users').doc(testUserId).set({
        'nickname': 'ExistingUser',
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Clear nickname
      await container.read(nicknameProvider.notifier).clearNickname();

      // Verify state is null
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, isNull);
    });

    test('clearNickname removes from Firestore', () async {
      // Pre-populate Firestore
      await fakeFirestore.collection('users').doc(testUserId).set({
        'nickname': 'UserToDelete',
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Clear nickname
      await container.read(nicknameProvider.notifier).clearNickname();

      // Verify in Firestore
      final doc = await fakeFirestore.collection('users').doc(testUserId).get();
      expect(doc.exists, isFalse);
    });

    test('setNickname handles Japanese characters', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      // Set Japanese nickname
      await container.read(nicknameProvider.notifier).setNickname('テストユーザー');

      // Verify state is updated
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('テストユーザー'));

      // Verify in Firestore
      final doc = await fakeFirestore.collection('users').doc(testUserId).get();
      expect(doc.data()?['nickname'], equals('テストユーザー'));
    });

    test('multiple setNickname calls overwrite previous value', () async {
      final ProviderContainer container = createContainer();
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

      // Verify in Firestore
      final doc = await fakeFirestore.collection('users').doc(testUserId).get();
      expect(doc.data()?['nickname'], equals('Third'));
    });

    test('setNickname updates updatedAt timestamp', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Wait for initial build
      await container.read(nicknameProvider.future);

      final beforeTime = DateTime.now();

      // Set nickname
      await container.read(nicknameProvider.notifier).setNickname('TestUser');

      final afterTime = DateTime.now();

      // Verify updatedAt in Firestore
      final doc = await fakeFirestore.collection('users').doc(testUserId).get();
      final updatedAt = (doc.data()?['updatedAt'] as Timestamp).toDate();

      expect(
        updatedAt.isAfter(beforeTime.subtract(const Duration(seconds: 1))),
        isTrue,
      );
      expect(
        updatedAt.isBefore(afterTime.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('provider keeps state alive (keepAlive: true)', () async {
      final ProviderContainer container = createContainer();
      addTearDown(container.dispose);

      // Initial read
      await container.read(nicknameProvider.future);

      // Set nickname
      await container.read(nicknameProvider.notifier).setNickname('KeepAlive');

      // Read again without rebuild
      final AsyncValue<String?> state = container.read(nicknameProvider);
      expect(state.value, equals('KeepAlive'));
    });
  });
}
