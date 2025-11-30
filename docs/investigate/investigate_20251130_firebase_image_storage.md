# Investigation Report: Firebase Storage Image Save Feature

**Issue**: [#55](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/55)
**Branch**: `feature/firebase-image-storage`
**Date**: 2025-11-30
**Status**: Investigation Complete

---

## 1. Overview

### 1.1 Feature Request Summary
Add functionality to save generated haiku images (currently displayed in preview) to Firebase Storage, enabling persistent storage and later retrieval.

### 1.2 Current State
- `ImageGenerationProvider` generates images and holds them in memory as `Uint8List`
- `ImageGenerationState.success(Uint8List)` stores generated image data
- `PreviewPage` displays the generated image with options to regenerate or post
- No mechanism exists to persist images to cloud storage
- `firebase_storage: ^13.0.4` is already added as a dependency

---

## 2. Architecture Analysis

### 2.1 Three-Layer Architecture Compliance

**Target Layer**: Feature Layer (`lib/features/haiku/`)

The implementation should follow the existing three-layer architecture:

```
App Layer (app/)
    |
    v
Feature Layer (features/haiku/)
    |
    ├── data/
    │   ├── models/
    │   └── repositories/  <-- NEW: haiku_image_storage_repository.dart
    |
    ├── presentation/
    │   ├── providers/     <-- MODIFY: Add save functionality
    │   ├── state/         <-- NEW: image_save_state.dart
    │   ├── pages/         <-- MODIFY: preview_page.dart
    │   └── widgets/
    |
    └── service/
        |
        v
Shared Layer (shared/)
    └── data/repositories/storage_repository.dart  <-- BASE CLASS (existing)
```

### 2.2 Dependency Direction
- Feature Layer depends on Shared Layer (correct direction)
- No Feature-to-Feature dependencies introduced
- Shared `StorageRepository` base class provides upload/download abstractions

### 2.3 Existing Patterns to Follow

**Repository Pattern** (`lib/features/haiku/data/repositories/haiku_repository.dart`):
- Extends base repository class
- Uses Logger for operation tracking
- Implements `create()`, `fromFirestore()`, `toFirestore()` methods
- Follows Japanese documentation conventions

**Provider Pattern** (`lib/features/haiku/presentation/providers/image_generation_provider.dart`):
- Uses `@riverpod` annotation
- Extends `_$ClassName` for code generation
- Returns Freezed state classes
- Provides error mapping for user-friendly messages

**State Pattern** (`lib/features/haiku/presentation/state/image_generation_state.dart`):
- Uses `@freezed` annotation
- Factory constructors for each state variant
- Japanese documentation comments

---

## 3. Key Files Analysis

### 3.1 Existing Files to Leverage

| File | Purpose | Usage |
|------|---------|-------|
| `lib/shared/data/repositories/storage_repository.dart` | Base class for Storage operations | Extend for haiku image storage |
| `lib/features/haiku/presentation/providers/image_generation_provider.dart` | Image generation state | Integrate save functionality |
| `lib/features/haiku/presentation/state/image_generation_state.dart` | Generation states | Reference for new save state |
| `lib/features/haiku/data/models/haiku_model.dart` | Haiku data model | Already has `imageUrl` field |
| `lib/features/haiku/presentation/pages/preview_page.dart` | Preview UI | Add save button |
| `lib/shared/service/firebase_service.dart` | Firebase instance provider | Already supports Storage |

### 3.2 StorageRepository Base Class Analysis

```dart
// Key methods available:
abstract class StorageRepository {
  Future<String> upload(String fileName, Uint8List data, {SettableMetadata? metadata});
  Future<Uint8List?> download(String fileName);
  Future<void> delete(String fileName);
  Future<String?> getDownloadUrl(String fileName);
  Future<List<Reference>> listFiles({String? path});
  Future<FullMetadata?> getMetadata(String fileName);
}
```

The base class provides:
- Upload with automatic download URL retrieval
- Optional metadata support (content type, custom metadata)
- Error handling for `object-not-found`
- Test-friendly architecture via `FirebaseService`

### 3.3 HaikuModel Analysis

```dart
class HaikuModel {
  final String id;
  final String firstLine;
  final String secondLine;
  final String thirdLine;
  final DateTime createdAt;
  final String? imageUrl;      // <-- Already exists!
  final String? userId;
  // ...
}
```

The `imageUrl` field already exists, which means:
- No model changes needed
- Save flow can update this field after upload

### 3.4 PreviewPage Analysis

Current flow:
1. Display generated image (`Image.memory(imageData)`)
2. "Regenerate" button -> reset state and navigate to GeneratingRoute
3. "Post to Mya-ku" button -> show snackbar and navigate to list

Enhancement needed:
- Add "Save" button between regenerate and post
- Show loading indicator during upload
- Handle success/error states

---

## 4. Proposed Implementation

### 4.1 New Files to Create

| File | Type | Purpose |
|------|------|---------|
| `lib/features/haiku/data/repositories/haiku_image_storage_repository.dart` | Repository | Haiku-specific storage operations |
| `lib/features/haiku/presentation/state/image_save_state.dart` | State | Upload status tracking |
| `lib/features/haiku/presentation/providers/image_save_provider.dart` | Provider | Save operation orchestration |

### 4.2 Files to Modify

| File | Changes |
|------|---------|
| `lib/features/haiku/presentation/pages/preview_page.dart` | Add save button and loading state |
| `lib/shared/shared.dart` (optional) | Export loading indicator if needed |

### 4.3 Storage Path Strategy

Recommended path structure:
```
haiku_images/
  └── {userId or anonymous}/
      └── {haikuId}_{timestamp}.jpg
```

Example: `haiku_images/user123/abc456_1701350400000.jpg`

### 4.4 State Management Design

```dart
@freezed
class ImageSaveState with _$ImageSaveState {
  const factory ImageSaveState.initial() = ImageSaveInitial;
  const factory ImageSaveState.saving() = ImageSaveSaving;
  const factory ImageSaveState.success(String downloadUrl) = ImageSaveSuccess;
  const factory ImageSaveState.error(String message) = ImageSaveError;
}
```

### 4.5 Provider Design

```dart
@riverpod
class ImageSave extends _$ImageSave {
  @override
  ImageSaveState build() => const ImageSaveState.initial();

  Future<String?> saveImage({
    required Uint8List imageData,
    required String haikuId,
    String? userId,
    Map<String, String>? metadata,
  }) async {
    // Implementation
  }
}
```

---

## 5. Test Strategy

### 5.1 Unit Tests Required

| Test File | Coverage |
|-----------|----------|
| `test/features/haiku/data/repositories/haiku_image_storage_repository_test.dart` | Repository upload/download |
| `test/features/haiku/presentation/providers/image_save_provider_test.dart` | Provider state transitions |

### 5.2 Widget Tests Required

| Test File | Coverage |
|-----------|----------|
| `test/features/haiku/presentation/pages/preview_page_test.dart` (extend) | Save button UI, loading states |

### 5.3 Test Patterns to Follow

From `test/shared/data/repositories/storage_repository_test.dart`:
- Use Mockito with `@GenerateMocks`
- Mock `FirebaseStorage`, `Reference`, `UploadTask`
- Test success and error scenarios

From `test/features/haiku/presentation/providers/haiku_provider_test.dart`:
- Use `ProviderContainer` with `overrides`
- Test initial state, success state, error handling
- Verify correct data passed to repository

---

## 6. Technical Considerations

### 6.1 Firebase Storage Security Rules
Current rules may need update to allow authenticated uploads:
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /haiku_images/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### 6.2 Image Metadata
Recommended metadata to store:
- `contentType`: MIME type (image/jpeg, image/png)
- `haikuFirstLine`, `haikuSecondLine`, `haikuThirdLine`: Haiku content
- `createdAt`: Timestamp

### 6.3 Error Handling
Error cases to handle:
- Network unavailable
- Storage quota exceeded
- Permission denied
- Invalid image data (empty/corrupted)

### 6.4 Performance Considerations
- Image data is already in memory (`Uint8List`)
- No additional processing needed before upload
- Consider progress indicator for large images (use `UploadTask.snapshotEvents`)

---

## 7. Verification Results

### 7.1 Static Analysis
```bash
$ fvm flutter analyze
No issues found!
```

### 7.2 Test Execution
```bash
$ fvm flutter test
All tests passing (144+ tests)
```

### 7.3 Dependencies
- `firebase_storage: ^13.0.4` - Already installed
- No new dependencies required

---

## 8. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Firebase rules block upload | Medium | High | Update security rules before deployment |
| Large image upload timeout | Low | Medium | Implement progress indicator, retry logic |
| State management complexity | Low | Low | Follow existing patterns |

---

## 9. Recommendations

### 9.1 Implementation Approach
1. **Create Repository First**: `HaikuImageStorageRepository` extending `StorageRepository`
2. **Add State Class**: `ImageSaveState` with Freezed
3. **Create Provider**: `ImageSaveProvider` with `@riverpod`
4. **Update UI**: Modify `PreviewPage` to add save button
5. **Write Tests**: Unit tests for repository and provider, widget tests for UI

### 9.2 Suggested Implementation Order
1. Repository (data layer) - Independent, testable
2. State class (presentation layer) - Required for provider
3. Provider (presentation layer) - Depends on repository and state
4. UI changes (presentation layer) - Depends on provider
5. Tests - Throughout implementation

### 9.3 Integration with Existing Flow
Option A (Recommended): **Separate Provider**
- Create new `ImageSaveProvider`
- Keep `ImageGenerationProvider` focused on generation
- Preview page uses both providers

Option B: **Extend Existing Provider**
- Add `saveImage()` method to `ImageGenerationProvider`
- Add new state variants
- More coupled, harder to test

---

## 10. Conclusion

The implementation is straightforward and aligns well with existing architecture:

- **Architecture Compliance**: Follows three-layer architecture, uses Shared layer appropriately
- **Pattern Consistency**: Matches existing repository, provider, and state patterns
- **Test Coverage**: Clear test strategy using existing patterns
- **Risk Level**: Low - uses established Firebase Storage base class
- **Dependencies**: No new packages needed

**Recommendation**: Proceed to PLAN phase with Option A (Separate Provider approach)

---

## 11. Output Summary

```
status: COMPLETED
next: PLAN
branch: feature/firebase-image-storage
architecture_layer: Feature
test_coverage_required: comprehensive
details: "Investigation complete. feature/firebase-image-storage branch created from main. Implementation strategy established. Ready for detailed planning."
```

---

## Appendix: Related Files Reference

### Existing Files
- `/lib/shared/data/repositories/storage_repository.dart`
- `/lib/features/haiku/presentation/providers/image_generation_provider.dart`
- `/lib/features/haiku/presentation/state/image_generation_state.dart`
- `/lib/features/haiku/presentation/pages/preview_page.dart`
- `/lib/features/haiku/data/models/haiku_model.dart`
- `/lib/features/haiku/data/repositories/haiku_repository.dart`
- `/lib/shared/service/firebase_service.dart`

### Test Files
- `/test/shared/data/repositories/storage_repository_test.dart`
- `/test/features/haiku/presentation/providers/haiku_provider_test.dart`
- `/test/features/haiku/data/repositories/haiku_repository_test.dart`
