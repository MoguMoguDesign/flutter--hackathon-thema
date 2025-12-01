import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutterhackthema/shared/service/firebase_functions_exception.dart';
import 'package:flutterhackthema/shared/service/firebase_functions_service.dart';

import 'firebase_functions_service_test.mocks.dart';

@GenerateMocks([FirebaseFunctions, HttpsCallable, HttpsCallableResult])
void main() {
  group('FirebaseFunctionsService', () {
    late MockFirebaseFunctions mockFunctions;
    late MockHttpsCallable mockCallable;
    late MockHttpsCallableResult<Map<String, dynamic>> mockResult;
    late FirebaseFunctionsService service;

    setUp(() {
      mockFunctions = MockFirebaseFunctions();
      mockCallable = MockHttpsCallable();
      mockResult = MockHttpsCallableResult<Map<String, dynamic>>();

      service = FirebaseFunctionsService(functions: mockFunctions);
    });

    tearDown(() {
      FirebaseFunctionsService.testFunctions = null;
    });

    group('generateAndSaveImage', () {
      test('returns image URL on success', () async {
        // Arrange
        const expectedUrl = 'https://storage.googleapis.com/bucket/image.jpg';
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(
          mockCallable.call<Map<String, dynamic>>(any),
        ).thenAnswer((_) async => mockResult);
        when(
          mockResult.data,
        ).thenReturn({'success': true, 'imageUrl': expectedUrl});

        // Act
        final result = await service.generateAndSaveImage(
          prompt: 'Test prompt',
          firstLine: '古池や',
          secondLine: '蛙飛び込む',
          thirdLine: '水の音',
        );

        // Assert
        expect(result, equals(expectedUrl));
        verify(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).called(1);
      });

      test('passes all parameters to callable', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(
          mockCallable.call<Map<String, dynamic>>(any),
        ).thenAnswer((_) async => mockResult);
        when(mockResult.data).thenReturn({
          'success': true,
          'imageUrl': 'https://example.com/image.jpg',
        });

        // Act
        await service.generateAndSaveImage(
          prompt: 'Test prompt',
          haikuId: 'haiku-123',
          firstLine: '上五',
          secondLine: '中七',
          thirdLine: '下五',
        );

        // Assert
        final captured =
            verify(
                  mockCallable.call<Map<String, dynamic>>(captureAny),
                ).captured.single
                as Map<String, dynamic>;
        expect(captured['prompt'], equals('Test prompt'));
        expect(captured['haikuId'], equals('haiku-123'));
        expect(captured['firstLine'], equals('上五'));
        expect(captured['secondLine'], equals('中七'));
        expect(captured['thirdLine'], equals('下五'));
      });

      test('throws FunctionsException when success is false', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(
          mockCallable.call<Map<String, dynamic>>(any),
        ).thenAnswer((_) async => mockResult);
        when(mockResult.data).thenReturn({'success': false, 'imageUrl': null});

        // Act & Assert
        expect(
          () => service.generateAndSaveImage(prompt: 'Test prompt'),
          throwsA(isA<FunctionsException>()),
        );
      });

      test('throws FunctionsException when imageUrl is null', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(
          mockCallable.call<Map<String, dynamic>>(any),
        ).thenAnswer((_) async => mockResult);
        when(mockResult.data).thenReturn({'success': true, 'imageUrl': null});

        // Act & Assert
        expect(
          () => service.generateAndSaveImage(prompt: 'Test prompt'),
          throwsA(isA<FunctionsException>()),
        );
      });

      test('maps unauthenticated error correctly', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(mockCallable.call<Map<String, dynamic>>(any)).thenThrow(
          FirebaseFunctionsException(
            code: 'unauthenticated',
            message: 'Unauthenticated',
          ),
        );

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('認証が必要です'));
          expect(e.code, equals('unauthenticated'));
        }
      });

      test('maps permission-denied error correctly', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(mockCallable.call<Map<String, dynamic>>(any)).thenThrow(
          FirebaseFunctionsException(
            code: 'permission-denied',
            message: 'Permission denied',
          ),
        );

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('アクセス権限がありません'));
        }
      });

      test('maps deadline-exceeded error correctly', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(mockCallable.call<Map<String, dynamic>>(any)).thenThrow(
          FirebaseFunctionsException(
            code: 'deadline-exceeded',
            message: 'Timeout',
          ),
        );

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('タイムアウト'));
        }
      });

      test('maps internal error correctly', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(mockCallable.call<Map<String, dynamic>>(any)).thenThrow(
          FirebaseFunctionsException(
            code: 'internal',
            message: 'Internal error',
          ),
        );

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('サーバーエラー'));
        }
      });

      test('maps unknown error correctly', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(mockCallable.call<Map<String, dynamic>>(any)).thenThrow(
          FirebaseFunctionsException(
            code: 'unknown-error',
            message: 'Unknown error',
          ),
        );

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('画像生成に失敗しました'));
        }
      });

      test('handles unexpected exceptions', () async {
        // Arrange
        when(
          mockFunctions.httpsCallable(
            'generate_and_save_image',
            options: anyNamed('options'),
          ),
        ).thenReturn(mockCallable);
        when(
          mockCallable.call<Map<String, dynamic>>(any),
        ).thenThrow(Exception('Network error'));

        // Act & Assert
        try {
          await service.generateAndSaveImage(prompt: 'Test prompt');
          fail('Expected FunctionsException');
        } on FunctionsException catch (e) {
          expect(e.message, contains('予期しないエラー'));
        }
      });
    });

    group('testFunctions', () {
      test('can set test functions instance', () {
        // Arrange
        FirebaseFunctionsService.testFunctions = mockFunctions;

        // Assert
        expect(FirebaseFunctionsService.testFunctions, equals(mockFunctions));
      });
    });
  });

  group('FunctionsException', () {
    test('toString returns formatted message', () {
      // Arrange
      const exception = FunctionsException(
        'Test error message',
        code: 'test-code',
      );

      // Assert
      expect(exception.toString(), contains('Test error message'));
      expect(exception.toString(), contains('test-code'));
    });

    test('code can be null', () {
      // Arrange
      const exception = FunctionsException('Error without code');

      // Assert
      expect(exception.code, isNull);
      expect(exception.message, equals('Error without code'));
    });
  });
}
