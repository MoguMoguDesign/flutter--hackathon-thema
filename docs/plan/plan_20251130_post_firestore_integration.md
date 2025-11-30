# 実装計画書: 投稿機能の改善 - Firebase Storage画像保存とFirestore連携

## 概要

**Issue**: [#57](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/57)
**ブランチ**: `feature/post-with-firestore-integration`
**調査結果**: `docs/investigate/investigate_20251130_post_firestore_integration.md`
**作成日**: 2025-11-30

---

## 1. 実装戦略

### 全体方針

Firebase Storage画像保存とFirestore連携を統合し、投稿フローを簡素化する。現在分離している「画像を保存」と「投稿する」機能を1つのボタンに統合し、ユーザー体験を向上させる。

### 実装順序

```
Phase 1: Provider修正 (haiku_provider.dart)
    ↓
Phase 2: UI修正 (preview_page.dart)
    ↓
Phase 3: テスト修正 (haiku_provider_test.dart)
    ↓
Phase 4: コード生成・検証
```

---

## 2. タスクブレイクダウン

### Phase 1: Provider修正

| Task ID | タスク | 優先度 | 見積もり |
|---------|--------|--------|----------|
| P1-1 | `saveHaiku()`に`imageUrl`パラメータを追加 | 高 | 小 |
| P1-2 | `HaikuModel`作成時に`imageUrl`を設定 | 高 | 小 |
| P1-3 | コード生成(`build_runner`) | 高 | 小 |

### Phase 2: UI修正

| Task ID | タスク | 優先度 | 見積もり |
|---------|--------|--------|----------|
| P2-1 | `handleSave()`関数を削除 | 高 | 小 |
| P2-2 | `_SaveButtonSection`ウィジェットの使用箇所を削除 | 高 | 小 |
| P2-3 | `_SaveButtonSection`クラス定義を削除 | 高 | 小 |
| P2-4 | `handlePost()`を非同期関数に変更 | 高 | 中 |
| P2-5 | Firebase Storage保存処理を統合 | 高 | 中 |
| P2-6 | Firestore保存処理を統合 | 高 | 中 |
| P2-7 | エラーハンドリングの実装 | 高 | 中 |
| P2-8 | ローディング状態の表示 | 中 | 小 |

### Phase 3: テスト修正

| Task ID | タスク | 優先度 | 見積もり |
|---------|--------|--------|----------|
| P3-1 | 既存テストの`imageUrl`パラメータ対応 | 高 | 小 |
| P3-2 | `saveHaiku with imageUrl succeeds`テスト追加 | 高 | 小 |
| P3-3 | `saveHaiku creates HaikuModel with imageUrl`テスト追加 | 高 | 小 |
| P3-4 | モック再生成 | 高 | 小 |

### Phase 4: 検証

| Task ID | タスク | 優先度 | 見積もり |
|---------|--------|--------|----------|
| P4-1 | `fvm flutter pub run build_runner build` | 必須 | - |
| P4-2 | `fvm flutter analyze` | 必須 | - |
| P4-3 | `dart format --set-exit-if-changed .` | 必須 | - |
| P4-4 | `fvm flutter test` | 必須 | - |

---

## 3. ファイル変更計画

### 修正ファイル

| ファイル | 変更種別 | 変更内容 |
|----------|----------|----------|
| `lib/features/haiku/presentation/providers/haiku_provider.dart` | 修正 | `saveHaiku()`に`imageUrl`パラメータ追加 |
| `lib/features/haiku/presentation/pages/preview_page.dart` | 修正 | `handlePost()`統合、ボタン削除 |
| `test/features/haiku/presentation/providers/haiku_provider_test.dart` | 修正 | テストケース追加・更新 |

### 自動生成ファイル

| ファイル | 生成タイミング |
|----------|---------------|
| `lib/features/haiku/presentation/providers/haiku_provider.g.dart` | Phase 4後 |
| `test/features/haiku/presentation/providers/haiku_provider_test.mocks.dart` | Phase 3後 |

### 削除コード

| ファイル | 削除対象 | 行番号目安 |
|----------|----------|-----------|
| `preview_page.dart` | `handleSave()`関数 | 101-121 |
| `preview_page.dart` | `_SaveButtonSection`使用箇所 | 167-171 |
| `preview_page.dart` | `_SaveButtonSection`クラス | 200-270 |

---

## 4. 詳細実装仕様

### 4.1 haiku_provider.dart の修正

#### Before
```dart
Future<String> saveHaiku({
  required String firstLine,
  required String secondLine,
  required String thirdLine,
}) async {
  // ...
  final haiku = HaikuModel(
    id: '',
    firstLine: firstLine,
    secondLine: secondLine,
    thirdLine: thirdLine,
    createdAt: DateTime.now(),
    likeCount: 0,
    nickname: nickname,
  );
  // ...
}
```

#### After
```dart
/// 俳句をFirestoreに保存
///
/// [firstLine] 上の句
/// [secondLine] 真ん中の行
/// [thirdLine] 下の句
/// [imageUrl] AI生成画像のFirebase Storage URL(オプション)
///
/// Returns: 保存されたドキュメントのID
Future<String> saveHaiku({
  required String firstLine,
  required String secondLine,
  required String thirdLine,
  String? imageUrl,
}) async {
  _logger.i('Saving haiku to Firestore');

  state = const AsyncValue.loading();

  state = await AsyncValue.guard(() async {
    final repository = ref.read(haikuRepositoryProvider);
    final String? nickname = await ref.read(userNicknameProvider.future);

    final haiku = HaikuModel(
      id: '',
      firstLine: firstLine,
      secondLine: secondLine,
      thirdLine: thirdLine,
      createdAt: DateTime.now(),
      likeCount: 0,
      nickname: nickname,
      imageUrl: imageUrl,
    );

    final docId = await repository.create(haiku);
    return docId;
  });

  return state.when(
    data: (docId) {
      _logger.i('Haiku saved successfully: $docId');
      return docId!;
    },
    loading: () => throw StateError('Still loading'),
    error: (error, stackTrace) {
      _logger.e('Failed to save haiku', error: error, stackTrace: stackTrace);
      throw error;
    },
  );
}
```

### 4.2 preview_page.dart の修正

#### handlePost() の新実装

```dart
/// 俳句を投稿する
///
/// 1. Firebase Storageに画像を保存
/// 2. Firestoreに俳句データを保存
/// 3. 状態をリセットして一覧画面に遷移
Future<void> handlePost() async {
  if (imageData == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('画像データがありません'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  // 1. Firebase Storageに画像を保存
  final imageUrl = await ref.read(imageSaveProvider.notifier).saveImage(
    imageData: imageData,
    firstLine: firstLine,
    secondLine: secondLine,
    thirdLine: thirdLine,
  );

  if (imageUrl == null) {
    // imageSaveProviderがエラー状態を設定済み
    // ImageSaveState.errorからメッセージを取得して表示
    final saveState = ref.read(imageSaveProvider);
    final errorMessage = saveState.maybeWhen(
      error: (message) => message,
      orElse: () => '画像の保存に失敗しました',
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  // 2. Firestoreに俳句データを保存
  try {
    await ref.read(haikuProvider.notifier).saveHaiku(
      firstLine: firstLine,
      secondLine: secondLine,
      thirdLine: thirdLine,
      imageUrl: imageUrl,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('投稿しました！'),
          backgroundColor: Colors.green,
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('投稿に失敗しました: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return;
  }

  // 3. 状態をリセットして一覧画面に遷移
  ref.read(imageGenerationProvider.notifier).reset();
  ref.read(imageSaveProvider.notifier).reset();
  const HaikuListRoute().go(context);
}
```

#### 削除対象コード

1. `handleSave()`関数 - 全体削除
2. `_SaveButtonSection`ウィジェット使用箇所:
```dart
// 削除
_SaveButtonSection(
  saveState: saveState,
  imageData: imageData,
  onSave: handleSave,
),
const SizedBox(height: 12),
```
3. `_SaveButtonSection`クラス定義 - 全体削除

---

## 5. テスト戦略

### 5.1 Unit Tests

#### 追加テストケース

```dart
test('saveHaiku with imageUrl succeeds and returns document ID', () async {
  // Arrange
  const docId = 'test-doc-id';
  const imageUrl = 'https://storage.example.com/image.jpg';
  when(mockRepository.create(any)).thenAnswer((_) async => docId);

  // Act
  final notifier = container.read(haikuProvider.notifier);
  final result = await notifier.saveHaiku(
    firstLine: '古池や',
    secondLine: '蛙飛び込む',
    thirdLine: '水の音',
    imageUrl: imageUrl,
  );

  // Assert
  expect(result, equals(docId));
  verify(mockRepository.create(any)).called(1);
});

test('saveHaiku creates HaikuModel with imageUrl', () async {
  // Arrange
  const imageUrl = 'https://storage.example.com/image.jpg';
  when(mockRepository.create(any)).thenAnswer((_) async => 'doc-id');

  // Act
  final notifier = container.read(haikuProvider.notifier);
  await notifier.saveHaiku(
    firstLine: '閑さや',
    secondLine: '岩にしみ入る',
    thirdLine: '蝉の声',
    imageUrl: imageUrl,
  );

  // Assert
  final captured = verify(mockRepository.create(captureAny)).captured;
  final haiku = captured.first as HaikuModel;

  expect(haiku.imageUrl, equals(imageUrl));
  expect(haiku.firstLine, equals('閑さや'));
  expect(haiku.secondLine, equals('岩にしみ入る'));
  expect(haiku.thirdLine, equals('蝉の声'));
});

test('saveHaiku without imageUrl creates HaikuModel with null imageUrl', () async {
  // Arrange
  when(mockRepository.create(any)).thenAnswer((_) async => 'doc-id');

  // Act
  final notifier = container.read(haikuProvider.notifier);
  await notifier.saveHaiku(
    firstLine: '古池や',
    secondLine: '蛙飛び込む',
    thirdLine: '水の音',
  );

  // Assert
  final captured = verify(mockRepository.create(captureAny)).captured;
  final haiku = captured.first as HaikuModel;

  expect(haiku.imageUrl, isNull);
});
```

### 5.2 テストカバレッジ目標

| テスト種別 | 対象 | カバレッジ目標 |
|-----------|------|---------------|
| Unit Test | `HaikuNotifier.saveHaiku()` | 100% |
| Unit Test | `HaikuModel`作成 | 100% |
| Widget Test | `PreviewPage` | 任意 |

### 5.3 既存テスト影響

既存の`haiku_provider_test.dart`のテストは変更不要。新パラメータは省略可能なため、後方互換性を維持。

---

## 6. アーキテクチャ準拠チェック

### 三層アーキテクチャ

| チェック項目 | 状態 |
|-------------|------|
| Feature層内で完結 | OK |
| Feature間の直接依存なし | OK |
| Shared層への依存のみ | OK |
| App層経由のFeature間連携 | OK (userNicknameProvider) |

### コーディング規約

| チェック項目 | 対応 |
|-------------|------|
| 日本語ドキュメントコメント(///) | 必須 |
| 型の明示 | 必須 |
| const使用 | 可能な限り |
| private変数は`_`プレフィックス | 必須 |

---

## 7. リスク分析と対策

### リスク1: Firebase Storage保存失敗

**リスク**: Storage保存失敗時にFirestore保存が実行される可能性

**対策**:
- Storage保存後にnullチェック
- 失敗時は早期リターン
- エラーメッセージをユーザーに表示

### リスク2: Firestore保存失敗

**リスク**: Storage保存成功後にFirestore保存が失敗する可能性（画像はStorageに残る）

**対策**:
- try-catchでエラーをキャッチ
- ユーザーにエラーを通知
- 画像は保存済みのため、再試行時に再アップロードは不要（現状の設計では毎回新規アップロード）

### リスク3: 既存テストへの影響

**リスク**: 新パラメータ追加による既存テストの破壊

**対策**:
- `imageUrl`はオプショナルパラメータ
- 既存テストは変更不要
- 後方互換性を維持

---

## 8. 検証コマンド

```bash
# 1. コード生成
fvm flutter pub run build_runner build --delete-conflicting-outputs

# 2. 静的解析
fvm flutter analyze

# 3. フォーマット
dart format --set-exit-if-changed .

# 4. テスト実行
fvm flutter test

# 5. (任意) カバレッジ確認
fvm flutter test --coverage
```

---

## 9. 成果物

### 実装完了後の確認項目

- [ ] `haiku_provider.dart`に`imageUrl`パラメータ追加済み
- [ ] `preview_page.dart`の`handlePost()`統合完了
- [ ] `_SaveButtonSection`削除完了
- [ ] 新規テストケース追加完了
- [ ] `fvm flutter analyze` - No issues found
- [ ] `dart format --set-exit-if-changed .` - 0 changed
- [ ] `fvm flutter test` - All tests passed
- [ ] コミット作成完了
- [ ] PR更新完了

---

## 10. 結論

```
status: SUCCESS
next: IMPLEMENT
details: "Flutter実装計画作成完了。包括的カバレッジ対応。詳細はplan_20251130_post_firestore_integration.mdに記録。実装フェーズに移行。"
```
