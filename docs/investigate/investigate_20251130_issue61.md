# Investigation Report: Firebase Storage Image Display Issue

## Issue Reference
- **Issue**: [#61](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/61)
- **Title**: Firebase Storageの画像がみんなの投稿一覧で表示されない
- **Branch**: `fix/firebase-storage-image-display`
- **Date**: 2025-11-30

---

## 1. Problem Summary

みんなの投稿一覧(`HaikuListPage`)で、Firestoreから俳句データは正常に取得できているが、`imageUrl`フィールドに保存されているFirebase Storageの画像URLが表示されない。画像読み込みに失敗し、フォールバックカード（俳句テキスト表示）が表示される。

---

## 2. Investigation Scope

### 2.1 Affected Files

| File | Location | Description |
|------|----------|-------------|
| `haiku_card.dart` | `lib/features/haiku/presentation/widgets/` | 俳句カードウィジェット（画像表示） |
| `haiku_detail_page.dart` | `lib/features/haiku/presentation/pages/` | 俳句詳細画面（画像表示） |
| `haiku_list_page.dart` | `lib/features/haiku/presentation/pages/` | みんなの投稿一覧画面 |
| `haiku_model.dart` | `lib/features/haiku/data/models/` | 俳句データモデル |
| `haiku_image_storage_repository.dart` | `lib/features/haiku/data/repositories/` | 画像ストレージリポジトリ |
| `storage_repository.dart` | `lib/shared/data/repositories/` | 共通ストレージリポジトリ基底クラス |
| `haiku_provider.dart` | `lib/features/haiku/presentation/providers/` | 俳句プロバイダー |
| `storage.rules` | Project root | Firebase Storage セキュリティルール |
| `firestore.rules` | Project root | Firestore セキュリティルール |

### 2.2 Related Tests

- `test/features/haiku/data/models/haiku_model_test.dart`
- `test/features/haiku/data/repositories/haiku_repository_test.dart`
- `test/features/haiku/data/repositories/haiku_image_storage_repository_test.dart`
- `test/features/haiku/presentation/providers/haiku_provider_test.dart`
- `test/features/haiku/presentation/providers/haiku_detail_provider_test.dart`

**Note**: `haiku_card_test.dart` does not exist and needs to be created.

---

## 3. Current Implementation Analysis

### 3.1 Image Loading in HaikuCard

```dart
// lib/features/haiku/presentation/widgets/haiku_card.dart:60-81
child: haiku.imageUrl != null
    ? Image.network(
        haiku.imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(...),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackCard();  // No error logging!
        },
      )
    : _buildFallbackCard(),
```

**Issues**:
- No error logging in `errorBuilder` - cannot identify the exact cause
- No caching mechanism for images

### 3.2 Firebase Storage Security Rules

```javascript
// storage.rules:7-9
match /{allPaths=**} {
  allow read, write: if request.auth != null;
}
```

**Issues**:
- All paths require authentication for read/write
- Images in `haiku_images/` path are not publicly readable
- Users viewing "Everyone's Posts" list cannot access images without authentication

### 3.3 Firestore Security Rules

```javascript
// firestore.rules:7-9
match /{document=**} {
  allow read, write: if request.auth != null;
}
```

**Issues**:
- Same authentication requirement
- The haiku data might be accessible if users are authenticated, but this needs verification

### 3.4 Image Upload Flow

The upload flow is correct:

1. `HaikuImageStorageRepository.uploadHaikuImage()` creates image in `haiku_images/{userId}/{haikuId}_{timestamp}.jpg`
2. `StorageRepository.upload()` returns HTTPS download URL via `getDownloadURL()`
3. URL is saved to Firestore `haikus` collection in `imageUrl` field

---

## 4. Root Cause Analysis

### 4.1 Primary Cause: Firebase Storage Security Rules (High Probability)

The most likely cause is the Firebase Storage security rules requiring authentication for all read operations.

**Evidence**:
- `storage.rules` line 9: `allow read, write: if request.auth != null;`
- Images uploaded to `haiku_images/` path
- Download URL format is correct (HTTPS from `getDownloadURL()`)
- Fallback card is displayed (errorBuilder is triggered)

**Expected Behavior**:
- Users on HaikuListPage should see images regardless of authentication status
- The "Everyone's Posts" feature implies public visibility

### 4.2 Secondary Causes (Lower Probability)

| Cause | Probability | Description |
|-------|-------------|-------------|
| CORS Configuration | Medium | Web platform may have CORS issues |
| Invalid URL Format | Low | `getDownloadURL()` returns valid HTTPS URLs |
| Network Errors | Low | Would require logging to verify |
| Authentication State | Medium | User might not be authenticated when viewing |

---

## 5. Architecture Compliance Check

### 5.1 Three-Layer Architecture

| Check | Status | Notes |
|-------|--------|-------|
| App Layer (routing, DI) | OK | Proper go_router usage |
| Feature Layer (haiku) | OK | Proper data/presentation/service structure |
| Shared Layer | OK | StorageRepository in shared layer |
| Feature-to-Feature deps | OK | No direct dependencies between features |

### 5.2 Riverpod Patterns

| Check | Status | Notes |
|-------|--------|-------|
| @riverpod annotation | OK | All providers use @riverpod |
| Code generation | OK | `.g.dart` files properly generated |
| Provider placement | OK | Feature providers in correct location |
| HookConsumerWidget | OK | Proper usage in pages |

### 5.3 Code Quality

| Check | Status | Notes |
|-------|--------|-------|
| Static Analysis | OK | `fvm flutter analyze` - No issues found |
| Tests | OK | All 155+ tests passing |
| Format | OK | Code properly formatted |

---

## 6. Recommended Solutions

### 6.1 Priority: High

#### Solution 1: Update Firebase Storage Security Rules

**File**: `storage.rules`

```javascript
rules_version = '2';

service firebase.storage {
  match /b/{bucket}/o {
    // Haiku images: public read, authenticated write
    match /haiku_images/{allPaths=**} {
      allow read: if true;  // Public read for haiku images
      allow write: if request.auth != null;  // Authenticated write only
    }

    // Default: authenticated users only
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

**Rationale**:
- "Everyone's Posts" is a public feature
- Images should be viewable by all users
- Write access still requires authentication

#### Solution 2: Add Error Logging

**File**: `lib/features/haiku/presentation/widgets/haiku_card.dart`

```dart
import 'package:logger/logger.dart';

// In HaikuCard class:
static final Logger _logger = Logger();

// In errorBuilder:
errorBuilder: (context, error, stackTrace) {
  _logger.e(
    'Failed to load haiku image',
    error: error,
    stackTrace: stackTrace,
  );
  _logger.i('ImageURL: ${haiku.imageUrl}');
  return _buildFallbackCard();
},
```

**Rationale**:
- Identify exact error cause (403, 404, CORS, etc.)
- Essential for debugging production issues

### 6.2 Priority: Medium

#### Solution 3: CORS Configuration for Web

Create `cors.json` in project root:

```json
[
  {
    "origin": ["*"],
    "method": ["GET"],
    "maxAgeSeconds": 3600
  }
]
```

Apply with:
```bash
gsutil cors set cors.json gs://[YOUR-BUCKET-NAME]
```

#### Solution 4: Use cached_network_image Package

**File**: `pubspec.yaml`

```yaml
dependencies:
  cached_network_image: ^3.3.0
```

**File**: `lib/features/haiku/presentation/widgets/haiku_card.dart`

```dart
import 'package:cached_network_image/cached_network_image.dart';

// Replace Image.network with:
CachedNetworkImage(
  imageUrl: haiku.imageUrl!,
  fit: BoxFit.cover,
  placeholder: (context, url) => const Center(
    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
  ),
  errorWidget: (context, url, error) {
    _logger.e('Failed to load image: $url', error: error);
    return _buildFallbackCard();
  },
)
```

**Benefits**:
- Automatic caching
- Better error information
- Improved performance

### 6.3 Priority: Low

#### Solution 5: Add Widget Tests for HaikuCard

Create `test/features/haiku/presentation/widgets/haiku_card_test.dart`:

```dart
testWidgets('HaikuCard displays image when imageUrl is provided', ...);
testWidgets('HaikuCard displays fallback when imageUrl is null', ...);
testWidgets('HaikuCard displays fallback when image fails to load', ...);
```

---

## 7. Impact Analysis

### 7.1 Changes Required

| File | Change Type | Impact |
|------|-------------|--------|
| `storage.rules` | Modify | Firebase Console deployment required |
| `haiku_card.dart` | Modify | Add logging |
| `haiku_detail_page.dart` | Modify | Add logging |
| `pubspec.yaml` | Modify | Add cached_network_image (optional) |
| `haiku_card_test.dart` | Create | New test file |

### 7.2 Risk Assessment

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| Security exposure | Low | Only haiku images are public, not user data |
| Breaking changes | Low | Backward compatible changes |
| Test failures | Low | Adding new tests, not modifying existing |

---

## 8. Verification Steps

### 8.1 Before Fix

1. Open app and navigate to HaikuListPage
2. Verify images show fallback (haiku text)
3. Check browser DevTools Network tab (Web) for 403/401 errors
4. Check Flutter logs for any error messages

### 8.2 After Fix

1. Deploy updated `storage.rules` to Firebase
2. Verify images load correctly in HaikuListPage
3. Verify images load correctly in HaikuDetailPage
4. Check logs for any remaining errors
5. Run all tests: `fvm flutter test`
6. Run static analysis: `fvm flutter analyze`

---

## 9. Conclusion

### 9.1 Root Cause

**Firebase Storage Security Rules** are the most likely root cause. The current rules require authentication for all read operations, preventing public access to haiku images in "Everyone's Posts" list.

### 9.2 Recommended Action

1. **Immediate**: Update `storage.rules` to allow public read for `haiku_images/`
2. **Immediate**: Add error logging to identify exact errors
3. **Short-term**: Add widget tests for HaikuCard
4. **Optional**: Consider `cached_network_image` for better caching

### 9.3 Next Phase

**Status**: `COMPLETED`
**Next**: `PLAN`
**Architecture Layer**: Feature (haiku)
**Test Coverage Required**: Comprehensive (widget tests for HaikuCard)

---

## 10. Appendix

### 10.1 Existing Test Coverage

| Test File | Test Count | Coverage |
|-----------|------------|----------|
| haiku_model_test.dart | 6 | Model serialization |
| haiku_repository_test.dart | 10+ | CRUD operations |
| haiku_image_storage_repository_test.dart | 5+ | Upload operations |
| haiku_provider_test.dart | 5+ | State management |
| haiku_detail_provider_test.dart | 5+ | Detail fetching |

### 10.2 Missing Tests

- `haiku_card_test.dart` - Image loading states
- `haiku_list_page_test.dart` - List rendering
- Integration tests for image loading flow

### 10.3 Static Analysis Results

```
No issues found! (ran in 1.9s)
```

### 10.4 Test Results

```
All 155+ tests passing
```
