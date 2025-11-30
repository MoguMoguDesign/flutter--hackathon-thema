# Implementation Plan: Firebase Storage Image Save Feature

**Issue**: [#55](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/55)
**Branch**: `feature/firebase-image-storage`
**Date**: 2025-11-30
**Investigation**: `docs/investigate/investigate_20251130_firebase_image_storage.md`

---

## 1. Implementation Strategy

### 1.1 Approach: Separate Provider Pattern

Based on the investigation, we will implement using **Option A: Separate Provider**:
- Create new `ImageSaveProvider` for save operations
- Keep `ImageGenerationProvider` focused on generation (Single Responsibility)
- `PreviewPage` will use both providers

### 1.2 Architecture Compliance

```
Feature Layer (lib/features/haiku/)
├── data/
│   └── repositories/
│       └── haiku_image_storage_repository.dart  [NEW]
├── presentation/
│   ├── providers/
│   │   └── image_save_provider.dart             [NEW]
│   ├── state/
│   │   └── image_save_state.dart                [NEW]
│   └── pages/
│       └── preview_page.dart                    [MODIFY]
│
Shared Layer (lib/shared/)
└── data/repositories/
    └── storage_repository.dart                  [BASE CLASS - existing]
```

---

## 2. Detailed Task Breakdown

### Phase 1: Data Layer (Priority: High)

| Task | File | Description | Estimated LOC |
|------|------|-------------|---------------|
| 1.1 | `haiku_image_storage_repository.dart` | Create repository extending StorageRepository | ~80 |
| 1.2 | `haiku_image_storage_repository_test.dart` | Unit tests for repository | ~150 |

### Phase 2: Presentation Layer - State (Priority: High)

| Task | File | Description | Estimated LOC |
|------|------|-------------|---------------|
| 2.1 | `image_save_state.dart` | Freezed state class | ~40 |
| 2.2 | Run `build_runner` | Generate `.freezed.dart` | Auto |

### Phase 3: Presentation Layer - Provider (Priority: High)

| Task | File | Description | Estimated LOC |
|------|------|-------------|---------------|
| 3.1 | `image_save_provider.dart` | @riverpod provider with save logic | ~100 |
| 3.2 | Run `build_runner` | Generate `.g.dart` | Auto |
| 3.3 | `image_save_provider_test.dart` | Provider unit tests | ~150 |

### Phase 4: UI Layer (Priority: Medium)

| Task | File | Description | Estimated LOC |
|------|------|-------------|---------------|
| 4.1 | `preview_page.dart` | Add save button and state handling | ~50 (delta) |
| 4.2 | `preview_page_test.dart` | Widget tests for save functionality | ~100 |

### Phase 5: Verification (Priority: High)

| Task | Description |
|------|-------------|
| 5.1 | Run `fvm flutter analyze` |
| 5.2 | Run `dart format --set-exit-if-changed .` |
| 5.3 | Run `fvm flutter test` |
| 5.4 | Manual integration test |

---

## 3. File Change Plan

### 3.1 New Files to Create

```
lib/features/haiku/data/repositories/
└── haiku_image_storage_repository.dart

lib/features/haiku/presentation/state/
└── image_save_state.dart
└── image_save_state.freezed.dart (generated)

lib/features/haiku/presentation/providers/
└── image_save_provider.dart
└── image_save_provider.g.dart (generated)

test/features/haiku/data/repositories/
└── haiku_image_storage_repository_test.dart

test/features/haiku/presentation/providers/
└── image_save_provider_test.dart
```

### 3.2 Files to Modify

```
lib/features/haiku/presentation/pages/
└── preview_page.dart (add save button)
```

### 3.3 Generated Files (Auto)

```
lib/features/haiku/presentation/state/
└── image_save_state.freezed.dart

lib/features/haiku/presentation/providers/
└── image_save_provider.g.dart
```

---

## 4. Implementation Details

### 4.1 HaikuImageStorageRepository

```dart
// lib/features/haiku/data/repositories/haiku_image_storage_repository.dart

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:flutterhackthema/shared/data/repositories/storage_repository.dart';

/// 俳句画像のFirebase Storageリポジトリ
///
/// 生成された俳句画像をFirebase Storageに保存・取得する機能を提供する。
/// [StorageRepository]を継承し、俳句画像専用のストレージ操作を実装する。
///
/// 使用例:
/// ```dart
/// final repository = HaikuImageStorageRepository();
/// final downloadUrl = await repository.uploadHaikuImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   metadata: HaikuImageMetadata(
///     firstLine: '古池や',
///     secondLine: '蛙飛び込む',
///     thirdLine: '水の音',
///   ),
/// );
/// ```
class HaikuImageStorageRepository extends StorageRepository {
  /// コンストラクタ
  HaikuImageStorageRepository() : super(basePath: 'haiku_images');

  final Logger _logger = Logger();
  final Uuid _uuid = const Uuid();

  /// 俳句画像をアップロードする
  ///
  /// [imageData] 画像のバイナリデータ
  /// [haikuId] 俳句のID(オプション、未指定時はUUID生成)
  /// [userId] ユーザーID(オプション、'anonymous'がデフォルト)
  /// [metadata] 画像メタデータ(俳句内容など)
  ///
  /// Returns: アップロードされた画像のダウンロードURL
  Future<String> uploadHaikuImage({
    required Uint8List imageData,
    String? haikuId,
    String? userId,
    HaikuImageMetadata? metadata,
  }) async {
    final stopwatch = Stopwatch()..start();
    final effectiveHaikuId = haikuId ?? _uuid.v4();
    final effectiveUserId = userId ?? 'anonymous';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '$effectiveUserId/${effectiveHaikuId}_$timestamp.jpg';

    try {
      _logger.i('Uploading haiku image: $fileName');

      final settableMetadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: metadata?.toMap(),
      );

      final downloadUrl = await upload(
        fileName,
        imageData,
        metadata: settableMetadata,
      );

      stopwatch.stop();
      _logger.i(
        'Haiku image uploaded successfully: $fileName '
        '(${stopwatch.elapsedMilliseconds}ms)',
      );

      return downloadUrl;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        'Failed to upload haiku image: $fileName',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

/// 俳句画像のメタデータ
///
/// Firebase Storageに保存する際のカスタムメタデータを定義する。
class HaikuImageMetadata {
  /// コンストラクタ
  const HaikuImageMetadata({
    this.firstLine,
    this.secondLine,
    this.thirdLine,
    this.createdAt,
  });

  /// 上の句
  final String? firstLine;

  /// 中の句
  final String? secondLine;

  /// 下の句
  final String? thirdLine;

  /// 作成日時
  final DateTime? createdAt;

  /// Mapに変換
  Map<String, String>? toMap() {
    final Map<String, String> map = {};
    if (firstLine != null) map['firstLine'] = firstLine!;
    if (secondLine != null) map['secondLine'] = secondLine!;
    if (thirdLine != null) map['thirdLine'] = thirdLine!;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    return map.isEmpty ? null : map;
  }
}
```

### 4.2 ImageSaveState

```dart
// lib/features/haiku/presentation/state/image_save_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_save_state.freezed.dart';

/// 画像保存状態
///
/// Firebase Storageへの画像保存処理の状態を表現する。
/// 初期状態、保存中、成功、エラーの4つの状態を持つ。
///
/// 使用例:
/// ```dart
/// final state = ImageSaveState.saving();
/// state.when(
///   initial: () => print('初期状態'),
///   saving: () => print('保存中...'),
///   success: (url) => print('保存成功: $url'),
///   error: (message) => print('エラー: $message'),
/// );
/// ```
@freezed
class ImageSaveState with _$ImageSaveState {
  /// 初期状態
  ///
  /// 画像保存がまだ開始されていない状態。
  const factory ImageSaveState.initial() = ImageSaveInitial;

  /// 保存中状態
  ///
  /// 画像がFirebase Storageにアップロード中の状態。
  const factory ImageSaveState.saving() = ImageSaveSaving;

  /// 保存成功状態
  ///
  /// 画像保存が成功した状態。
  /// [downloadUrl] アップロードされた画像のダウンロードURL
  const factory ImageSaveState.success(String downloadUrl) = ImageSaveSuccess;

  /// エラー状態
  ///
  /// 画像保存に失敗した状態。
  /// [message] エラーメッセージ
  const factory ImageSaveState.error(String message) = ImageSaveError;
}
```

### 4.3 ImageSaveProvider

```dart
// lib/features/haiku/presentation/providers/image_save_provider.dart

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/haiku_image_storage_repository.dart';
import '../state/image_save_state.dart';

part 'image_save_provider.g.dart';

/// HaikuImageStorageRepositoryのプロバイダー
///
/// [HaikuImageStorageRepository]のインスタンスを提供する。
@riverpod
HaikuImageStorageRepository haikuImageStorageRepository(Ref ref) {
  return HaikuImageStorageRepository();
}

/// 画像保存プロバイダー
///
/// 生成された俳句画像をFirebase Storageに保存する状態管理を提供する。
/// [HaikuImageStorageRepository]を使用してアップロード処理を行う。
///
/// 使用例:
/// ```dart
/// // 状態を監視
/// final state = ref.watch(imageSaveProvider);
///
/// // 保存を実行
/// final url = await ref.read(imageSaveProvider.notifier).saveImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
@riverpod
class ImageSave extends _$ImageSave {
  @override
  ImageSaveState build() {
    return const ImageSaveState.initial();
  }

  /// 画像をFirebase Storageに保存する
  ///
  /// [imageData] 保存する画像データ
  /// [haikuId] 俳句のID(オプション)
  /// [userId] ユーザーID(オプション)
  /// [firstLine] 上の句(メタデータ用)
  /// [secondLine] 中の句(メタデータ用)
  /// [thirdLine] 下の句(メタデータ用)
  ///
  /// Returns: 保存成功時はダウンロードURL、失敗時はnull
  Future<String?> saveImage({
    required Uint8List imageData,
    String? haikuId,
    String? userId,
    String? firstLine,
    String? secondLine,
    String? thirdLine,
  }) async {
    // 画像データの検証
    if (imageData.isEmpty) {
      state = const ImageSaveState.error('画像データが空です');
      return null;
    }

    state = const ImageSaveState.saving();

    try {
      final repository = ref.read(haikuImageStorageRepositoryProvider);

      final metadata = HaikuImageMetadata(
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
        createdAt: DateTime.now(),
      );

      final downloadUrl = await repository.uploadHaikuImage(
        imageData: imageData,
        haikuId: haikuId,
        userId: userId,
        metadata: metadata,
      );

      state = ImageSaveState.success(downloadUrl);
      return downloadUrl;
    } on FirebaseException catch (e) {
      state = ImageSaveState.error(_mapFirebaseError(e));
      return null;
    } catch (e) {
      state = const ImageSaveState.error('予期しないエラーが発生しました');
      return null;
    }
  }

  /// FirebaseExceptionをユーザー向けメッセージに変換
  String _mapFirebaseError(FirebaseException e) {
    return switch (e.code) {
      'permission-denied' => '保存の権限がありません',
      'canceled' => '保存がキャンセルされました',
      'quota-exceeded' => 'ストレージ容量が不足しています',
      'unauthenticated' => '認証が必要です',
      'retry-limit-exceeded' => '接続に失敗しました。再試行してください',
      _ => '保存に失敗しました。再試行してください',
    };
  }

  /// 状態をリセットする
  void reset() {
    state = const ImageSaveState.initial();
  }
}
```

### 4.4 PreviewPage Modifications

```dart
// Changes to lib/features/haiku/presentation/pages/preview_page.dart

// Add import
import '../providers/image_save_provider.dart';

// Inside PreviewPage build method, add:

// Watch save state
final saveState = ref.watch(imageSaveProvider);

// Add save handler
Future<void> handleSave() async {
  if (imageData == null) return;

  final url = await ref.read(imageSaveProvider.notifier).saveImage(
    imageData: imageData,
    firstLine: firstLine,
    secondLine: secondLine,
    thirdLine: thirdLine,
  );

  if (url != null && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('画像を保存しました'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Add save button between regenerate and post buttons
saveState.when(
  initial: () => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: AppOutlinedButton(
      label: '画像を保存',
      leadingIcon: Icons.save,
      onPressed: imageData != null ? handleSave : null,
    ),
  ),
  saving: () => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 24),
    child: CircularProgressIndicator(),
  ),
  success: (_) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(width: 8),
        const Text('保存済み'),
      ],
    ),
  ),
  error: (message) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        Text(message, style: const TextStyle(color: Colors.red)),
        const SizedBox(height: 8),
        AppOutlinedButton(
          label: '再試行',
          leadingIcon: Icons.refresh,
          onPressed: handleSave,
        ),
      ],
    ),
  ),
),
```

---

## 5. Test Strategy

### 5.1 Unit Tests

#### haiku_image_storage_repository_test.dart

```dart
// Test cases:
// 1. uploadHaikuImage - success with all parameters
// 2. uploadHaikuImage - success with minimal parameters
// 3. uploadHaikuImage - handles Firebase exceptions
// 4. uploadHaikuImage - generates UUID when haikuId is null
// 5. HaikuImageMetadata - toMap with all fields
// 6. HaikuImageMetadata - toMap with partial fields
// 7. HaikuImageMetadata - toMap returns null when empty
```

#### image_save_provider_test.dart

```dart
// Test cases:
// 1. initial state is ImageSaveState.initial
// 2. saveImage - success flow (initial -> saving -> success)
// 3. saveImage - error flow (initial -> saving -> error)
// 4. saveImage - empty image data returns error immediately
// 5. saveImage - Firebase permission denied error mapped correctly
// 6. saveImage - Firebase quota exceeded error mapped correctly
// 7. reset - returns to initial state
// 8. Provider correctly passes metadata to repository
```

### 5.2 Widget Tests

#### preview_page_test.dart (additions)

```dart
// Test cases:
// 1. Save button is displayed when image is available
// 2. Save button is disabled when no image
// 3. Loading indicator shown during save
// 4. Success message shown after save
// 5. Error message shown on save failure
// 6. Retry button appears on error
```

### 5.3 Test Patterns

Following existing patterns from:
- `storage_repository_test.dart` - Mockito with @GenerateMocks
- `haiku_provider_test.dart` - ProviderContainer with overrides
- `haiku_repository_test.dart` - FakeFirebaseFirestore for Firebase tests

---

## 6. Tech Stack Verification

| Package | Required | Installed | Status |
|---------|----------|-----------|--------|
| hooks_riverpod | ^3.0.3 | ^3.0.3 | OK |
| riverpod_annotation | ^3.0.3 | ^3.0.3 | OK |
| go_router | ^16.2.4 | ^16.2.4 | OK |
| freezed_annotation | ^3.1.0 | ^3.1.0 | OK |
| firebase_storage | ^13.0.4 | ^13.0.4 | OK |
| mockito | ^5.5.0 | ^5.5.0 | OK |
| uuid | ^4.5.2 | ^4.5.2 | OK |
| logger | ^2.6.2 | ^2.6.2 | OK |

All required packages are already installed.

---

## 7. Risk Analysis

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Firebase rules block upload | Medium | High | Test with anonymous user; document rule requirements |
| Large image upload timeout | Low | Medium | Implement progress indicator in future iteration |
| State race condition | Low | Low | Use proper Riverpod state management |
| Memory issues with large images | Low | Medium | Images already in memory from generation |

### Countermeasures

1. **Firebase Rules**: Document required rules in README; test with current rules first
2. **Upload Timeout**: Accept current behavior; plan progress indicator for v2
3. **Error Handling**: Comprehensive error mapping with user-friendly messages
4. **Testing**: Use mocks to test all error scenarios

---

## 8. Implementation Order

### Step-by-Step Execution

```
1. [Data Layer]
   ├── Create haiku_image_storage_repository.dart
   └── Create haiku_image_storage_repository_test.dart

2. [State Layer]
   ├── Create image_save_state.dart
   └── Run build_runner (generate .freezed.dart)

3. [Provider Layer]
   ├── Create image_save_provider.dart
   ├── Run build_runner (generate .g.dart)
   └── Create image_save_provider_test.dart

4. [UI Layer]
   ├── Modify preview_page.dart
   └── Add preview_page save button tests

5. [Verification]
   ├── fvm flutter analyze
   ├── dart format --set-exit-if-changed .
   └── fvm flutter test
```

---

## 9. Acceptance Criteria

From Issue #55:

- [x] Plan: Repository design complete
- [x] Plan: Provider design complete
- [x] Plan: State design complete
- [x] Plan: UI changes specified
- [x] Plan: Test strategy defined
- [ ] Impl: Generated image can be uploaded to Firebase Storage
- [ ] Impl: Loading state is displayed during upload
- [ ] Impl: Success message is shown on upload success
- [ ] Impl: Error message is shown on upload failure
- [ ] Impl: Download URL is available after upload
- [ ] Test: Unit tests implemented
- [ ] Test: Widget tests implemented
- [ ] QA: `fvm flutter analyze` passes
- [ ] QA: `fvm flutter test` passes
- [ ] QA: Code formatting applied

---

## 10. Commands Reference

```bash
# Code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (development)
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Static analysis
fvm flutter analyze

# Format code
dart format --set-exit-if-changed .

# Run all tests
fvm flutter test

# Run specific test
fvm flutter test test/features/haiku/data/repositories/haiku_image_storage_repository_test.dart

# Run with coverage
fvm flutter test --coverage
```

---

## 11. Output Summary

```
status: SUCCESS
next: IMPLEMENT
details: "Flutter implementation plan creation complete. Comprehensive coverage supported. Details recorded in plan_20251130_firebase_image_storage.md. Moving to implementation phase."
```

---

## Appendix: File Templates

### A. Test File Header Template

```dart
// Test file for [Component Name]
//
// Test coverage:
// - [List of test scenarios]
//
// Dependencies:
// - mockito for mocking
// - flutter_test for assertions

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Imports...

@GenerateMocks([/* Dependencies */])
void main() {
  group('[Component Name]', () {
    late Mock/* Dependency */ mock/* Dependency */;

    setUp(() {
      // Setup mocks
    });

    tearDown(() {
      // Cleanup
    });

    // Tests...
  });
}
```

### B. Provider File Header Template

```dart
// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:riverpod_annotation/riverpod_annotation.dart';

part '[filename].g.dart';

/// [Japanese documentation]
@riverpod
class [ClassName] extends _$[ClassName] {
  @override
  [StateType] build() {
    return const [StateType].initial();
  }

  // Methods...
}
```
