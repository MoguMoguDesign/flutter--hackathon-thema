# Investigation Report: Issue #68 - Haiku List Sort by Date

## Investigation Summary

- **Issue**: #68 - みんなの投稿一覧を投稿日時の降順で表示する
- **Branch**: `feature/haiku-list-sort-by-date`
- **Date**: 2025-12-01
- **Status**: Investigation Complete - Implementation Recommended

---

## 1. Issue Overview

### Requirement
Display haiku posts in descending order by creation date (newest first) in the public haiku list page.

### Background
- Current implementation does not specify sort order for Firestore queries
- Social applications typically display newest content first
- Users expect to see latest posts at the top

---

## 2. Current Implementation Analysis

### 2.1 Provider Layer (`haiku_provider.dart`)

**Location**: `lib/features/haiku/presentation/providers/haiku_provider.dart:40-43`

```dart
@riverpod
Stream<List<HaikuModel>> haikuListStream(Ref ref) {
  final repository = ref.watch(haikuRepositoryProvider);
  return repository.watchAll();  // No query parameter passed
}
```

**Issue**: `watchAll()` is called without any query parameter, resulting in default Firestore ordering.

### 2.2 Repository Layer (`firestore_repository.dart`)

**Location**: `lib/shared/data/repositories/firestore_repository.dart:128-138`

```dart
Stream<List<T>> watchAll({Query<Map<String, dynamic>>? query}) {
  final targetQuery = query ?? collection;
  return targetQuery.snapshots().map(
    (snapshot) => snapshot.docs
        .map(
          (doc) => fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>),
        )
        .toList(),
  );
}
```

**Good News**: The `watchAll()` method already accepts an optional `query` parameter.

### 2.3 Data Model (`haiku_model.dart`)

**Location**: `lib/features/haiku/data/models/haiku_model.dart:41`

```dart
/// 作成日時
final DateTime createdAt;
```

**Good News**: `HaikuModel` already has a `createdAt` field that can be used for sorting.

---

## 3. Solution Analysis

### Recommended Approach

Modify `haikuListStreamProvider` to pass a sorted query:

```dart
@riverpod
Stream<List<HaikuModel>> haikuListStream(Ref ref) {
  final repository = ref.watch(haikuRepositoryProvider);
  final query = repository.collection.orderBy('createdAt', descending: true);
  return repository.watchAll(query: query);
}
```

### Why This Approach

1. **Minimal Change**: Only one line of code needs modification
2. **Firestore-side Sorting**: Sorting happens on the server, not client
3. **Existing Infrastructure**: Leverages existing `watchAll(query:)` parameter
4. **Architecture Compliance**: Stays within Feature layer, no cross-feature dependencies

---

## 4. Architecture Compliance

### Layer Analysis

| Component | Layer | Compliance |
|-----------|-------|------------|
| `haikuListStreamProvider` | Feature (presentation/providers) | OK |
| `HaikuRepository` | Feature (data/repositories) | OK |
| `FirestoreRepository` | Shared (data/repositories) | OK |
| `HaikuModel` | Feature (data/models) | OK |

### Dependency Direction

```
App Layer
  ↓
Feature Layer (haiku)
  - haiku_provider.dart
  - haiku_repository.dart
  ↓
Shared Layer
  - firestore_repository.dart
```

**Result**: Dependencies flow correctly (Feature → Shared). No Feature-to-Feature dependencies.

---

## 5. Firestore Index Consideration

### Single Field Index

For a simple `orderBy('createdAt', descending: true)` query on a single field, Firestore automatically creates the necessary index. No manual index configuration is required.

### Potential Future Consideration

If compound queries are needed in the future (e.g., filter by user + sort by date), a composite index would need to be configured in `firestore.indexes.json`.

---

## 6. Test Strategy

### Current Test Coverage

- `haiku_provider_test.dart`: Tests `HaikuNotifier` (save functionality)
- No existing tests for `haikuListStreamProvider`

### Recommended Test Approach

1. **Unit Test**: Mock `HaikuRepository.watchAll(query:)` to verify correct query is passed
2. **Verification**: Ensure `orderBy('createdAt', descending: true)` is applied

### Test Implementation

```dart
test('haikuListStreamProvider uses descending order by createdAt', () {
  // Verify that watchAll is called with appropriate orderBy query
  // Use verify() to check the query parameter
});
```

---

## 7. Risk Assessment

| Risk | Level | Mitigation |
|------|-------|------------|
| Breaking existing functionality | Low | Change is additive, existing data unaffected |
| Firestore index issues | Low | Single field sort uses automatic indexes |
| Performance impact | None | Server-side sorting is efficient |
| Missing `createdAt` in old data | Low | All `HaikuModel` instances have required `createdAt` field |

---

## 8. Verification Commands

```bash
# Static analysis
fvm flutter analyze  # Passed - No issues found

# Tests
fvm flutter test     # Passed - 219 tests passed, 12 skipped

# Format check
dart format --set-exit-if-changed .
```

---

## 9. Implementation Recommendation

### Files to Modify

1. **`lib/features/haiku/presentation/providers/haiku_provider.dart`**
   - Modify `haikuListStreamProvider` to pass sorted query

### Files to Add (Optional)

1. **Test file updates** in `test/features/haiku/presentation/providers/haiku_provider_test.dart`
   - Add test for `haikuListStreamProvider` sort order

### Estimated Effort

- Code change: ~5 lines
- Test addition: ~20 lines
- Total: Low complexity, minimal risk

---

## 10. Conclusion

```
status: COMPLETED
next: PLAN
branch: feature/haiku-list-sort-by-date
architecture_layer: Feature
test_coverage_required: comprehensive
details: "Investigation complete. feature/haiku-list-sort-by-date branch created.
         Simple modification to haikuListStreamProvider required.
         Existing infrastructure (watchAll with query parameter) supports the change.
         Implementation recommended."
```
