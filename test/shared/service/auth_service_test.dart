import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterhackthema/shared/service/auth_service.dart';

import 'auth_service_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential])
void main() {
  group('AuthService', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late MockUserCredential mockUserCredential;
    late AuthService authService;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();
      mockUserCredential = MockUserCredential();

      authService = AuthService(firebaseAuth: mockFirebaseAuth);
    });

    tearDown(() {
      AuthService.testAuth = null;
    });

    group('currentUser', () {
      test('returns null when not authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final user = authService.currentUser;

        // Assert
        expect(user, isNull);
      });

      test('returns user when authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final user = authService.currentUser;

        // Assert
        expect(user, equals(mockUser));
      });
    });

    group('isAuthenticated', () {
      test('returns false when not authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final result = authService.isAuthenticated;

        // Assert
        expect(result, isFalse);
      });

      test('returns true when authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final result = authService.isAuthenticated;

        // Assert
        expect(result, isTrue);
      });
    });

    group('currentUserId', () {
      test('returns null when not authenticated', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final userId = authService.currentUserId;

        // Assert
        expect(userId, isNull);
      });

      test('returns uid when authenticated', () {
        // Arrange
        const expectedUid = 'test-uid-123';
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.uid).thenReturn(expectedUid);

        // Act
        final userId = authService.currentUserId;

        // Assert
        expect(userId, equals(expectedUid));
      });
    });

    group('ensureAuthenticated', () {
      test('returns existing user when already authenticated', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final user = await authService.ensureAuthenticated();

        // Assert
        expect(user, equals(mockUser));
        verifyNever(mockFirebaseAuth.signInAnonymously());
      });

      test('signs in anonymously when not authenticated', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        when(
          mockFirebaseAuth.signInAnonymously(),
        ).thenAnswer((_) async => mockUserCredential);
        when(mockUserCredential.user).thenReturn(mockUser);

        // Act
        final user = await authService.ensureAuthenticated();

        // Assert
        expect(user, equals(mockUser));
        verify(mockFirebaseAuth.signInAnonymously()).called(1);
      });

      test(
        'throws FirebaseAuthException when sign in returns null user',
        () async {
          // Arrange
          when(mockFirebaseAuth.currentUser).thenReturn(null);
          when(
            mockFirebaseAuth.signInAnonymously(),
          ).thenAnswer((_) async => mockUserCredential);
          when(mockUserCredential.user).thenReturn(null);

          // Act & Assert
          expect(
            () => authService.ensureAuthenticated(),
            throwsA(isA<FirebaseAuthException>()),
          );
        },
      );

      test('propagates FirebaseAuthException on auth failure', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);
        when(mockFirebaseAuth.signInAnonymously()).thenThrow(
          FirebaseAuthException(
            code: 'operation-not-allowed',
            message: 'Anonymous auth is not enabled',
          ),
        );

        // Act & Assert
        expect(
          () => authService.ensureAuthenticated(),
          throwsA(isA<FirebaseAuthException>()),
        );
      });
    });

    group('signOut', () {
      test('calls FirebaseAuth.signOut', () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});

        // Act
        await authService.signOut();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
      });
    });

    group('authStateChanges', () {
      test('returns auth state changes stream', () {
        // Arrange
        final stream = Stream<User?>.value(mockUser);
        when(mockFirebaseAuth.authStateChanges()).thenAnswer((_) => stream);

        // Act
        final result = authService.authStateChanges();

        // Assert
        expect(result, isA<Stream<User?>>());
        verify(mockFirebaseAuth.authStateChanges()).called(1);
      });
    });

    group('testAuth', () {
      test('can set test auth instance', () {
        // Arrange
        AuthService.testAuth = mockFirebaseAuth;

        // Assert
        expect(AuthService.testAuth, equals(mockFirebaseAuth));
      });

      test('testAuth is used when creating AuthService via provider', () {
        // Arrange
        AuthService.testAuth = mockFirebaseAuth;
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final service = AuthService(firebaseAuth: AuthService.testAuth);

        // Assert
        expect(service.currentUser, equals(mockUser));
      });
    });
  });
}
