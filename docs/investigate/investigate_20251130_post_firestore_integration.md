# 調査報告書: 投稿機能の改善 - Firebase Storage画像保存とFirestore連携

## 概要

**Issue**: [#57](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/57)
**ブランチ**: `feature/post-with-firestore-integration`
**調査日**: 2025-11-30

## 要件サマリー

1. **Firebase Storage機能の移植**: 「画像を保存」ボタンの機能を「Mya句に投稿する」ボタンに移植
2. **「画像を保存」ボタンの削除**: プレビュー画面から`_SaveButtonSection`ウィジェットを削除
3. **Firestore連携**: 投稿時にFirebase StorageのdownloadURLを`haikus`コレクションの`imageUrl`フィールドに保存
4. **画面遷移**: 投稿完了後、みんなの投稿一覧画面(`HaikuListRoute`)に遷移

## アーキテクチャ分析

### 三層アーキテクチャ準拠状況

```
App Layer (app/)
  ├── app_router/routes.dart    - ルーティング定義
  └── app_di/user_providers.dart - Feature間の依存注入
      ↓
Feature Layer (features/haiku/)
  ├── data/
  │   ├── models/haiku_model.dart              - データモデル
  │   └── repositories/
  │       ├── haiku_repository.dart            - Firestore CRUD
  │       └── haiku_image_storage_repository.dart - Firebase Storage
  └── presentation/
      ├── pages/preview_page.dart              - 修正対象
      └── providers/
          ├── haiku_provider.dart              - 俳句保存Provider (修正必要)
          └── image_save_provider.dart         - 画像保存Provider (既存活用)
      ↓
Shared Layer (shared/)
  └── data/repositories/
      └── firestore_repository.dart            - 基底クラス
```

**評価**: 現在の実装は三層アーキテクチャに準拠しています。Feature間の依存はApp層(`user_providers.dart`)経由で解決されています。

### 状態管理パターン (Riverpod 3.x)

現在のProviderパターン:

```dart
// haiku_provider.dart
@riverpod
class HaikuNotifier extends _$HaikuNotifier {
  @override
  FutureOr<String?> build() => null;

  Future<String> saveHaiku({
    required String firstLine,
    required String secondLine,
    required String thirdLine,
    // imageUrl パラメータが存在しない <-- 修正必要
  }) async { ... }
}
```

```dart
// image_save_provider.dart
@riverpod
class ImageSave extends _$ImageSave {
  @override
  ImageSaveState build() => const ImageSaveState.initial();

  Future<String?> saveImage({...}) async { ... }
  void reset() { ... }
}
```

**課題**: `HaikuNotifier.saveHaiku()`に`imageUrl`パラメータがない

## 現在の実装状況

### preview_page.dart の分析

```dart
// 現在のhandlePost() - 画面遷移のみ
void handlePost() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('投稿しました！'), backgroundColor: Colors.black),
  );
  ref.read(imageGenerationProvider.notifier).reset();
  ref.read(imageSaveProvider.notifier).reset();
  const HaikuListRoute().go(context);
}

// 現在のhandleSave() - Firebase Storage保存
Future<void> handleSave() async {
  if (imageData == null) return;

  final url = await ref
      .read(imageSaveProvider.notifier)
      .saveImage(
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
```

### HaikuModel の分析

```dart
class HaikuModel {
  final String id;
  final String firstLine;
  final String secondLine;
  final String thirdLine;
  final DateTime createdAt;
  final String? imageUrl;    // <-- 既に存在
  final String? userId;
  final int? likeCount;
  final String? nickname;
}
```

**評価**: `HaikuModel`には既に`imageUrl`フィールドが存在するため、データモデルの変更は不要

## 修正計画

### Phase 1: Provider修正

**ファイル**: `lib/features/haiku/presentation/providers/haiku_provider.dart`

変更内容:
- `saveHaiku()`メソッドに`imageUrl`パラメータを追加

```dart
Future<String> saveHaiku({
  required String firstLine,
  required String secondLine,
  required String thirdLine,
  String? imageUrl,  // 追加
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
    imageUrl: imageUrl,  // 追加
  );
  // ...
}
```

### Phase 2: UI修正

**ファイル**: `lib/features/haiku/presentation/pages/preview_page.dart`

変更内容:
1. `handleSave()`関数を削除
2. `_SaveButtonSection`ウィジェットの使用箇所を削除
3. `_SaveButtonSection`クラス定義を削除
4. `handlePost()`関数を修正:

```dart
Future<void> handlePost() async {
  if (imageData == null) return;

  // 1. Firebase Storageに画像を保存
  final imageUrl = await ref.read(imageSaveProvider.notifier).saveImage(
    imageData: imageData,
    firstLine: firstLine,
    secondLine: secondLine,
    thirdLine: thirdLine,
  );

  if (imageUrl == null) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('画像の保存に失敗しました'),
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

### Phase 3: テスト修正

**ファイル**: `test/features/haiku/presentation/providers/haiku_provider_test.dart`

変更内容:
- `saveHaiku()`テストに`imageUrl`パラメータを追加
- 新規テストケース追加:
  - `saveHaiku with imageUrl succeeds`
  - `saveHaiku creates HaikuModel with imageUrl`

## テスト戦略

### Unit Tests

| テスト対象 | テスト内容 |
|-----------|-----------|
| `HaikuNotifier.saveHaiku()` | imageUrl付きで保存成功 |
| `HaikuNotifier.saveHaiku()` | imageUrlなしで保存成功 |
| `HaikuNotifier.saveHaiku()` | HaikuModelに正しいimageUrlが設定される |

### Widget Tests (任意)

| テスト対象 | テスト内容 |
|-----------|-----------|
| `PreviewPage` | 「画像を保存」ボタンが表示されない |
| `PreviewPage` | 「Mya句に投稿する」ボタンが正しく表示される |
| `PreviewPage` | 投稿中のローディング表示 |

### 既存テスト

48テスト全てパス済み

## 検証結果

| コマンド | 結果 |
|---------|------|
| `fvm flutter pub get` | 成功 |
| `fvm flutter analyze` | No issues found |
| `dart format --set-exit-if-changed .` | 0 changed |
| `fvm flutter test` | 48 tests passed |

## リスク分析

### 低リスク

1. **Providerの修正**: パラメータ追加のみで既存機能に影響なし
2. **UIの修正**: ボタン削除と関数統合のみ

### 中リスク

1. **エラーハンドリング**: Firebase Storage保存失敗後のFirestore保存をスキップする必要あり
2. **処理順序**: Storage保存成功 → Firestore保存の順序を厳守

### 対策

- Firebase Storage保存失敗時は早期リターン
- Firestore保存失敗時はユーザーに通知(画像は保存済み)
- 処理中のローディング表示でUXを維持

## 影響範囲

### 修正ファイル

1. `lib/features/haiku/presentation/providers/haiku_provider.dart`
   - `saveHaiku()`にimageUrlパラメータ追加

2. `lib/features/haiku/presentation/pages/preview_page.dart`
   - `handlePost()`関数の実装修正
   - `handleSave()`関数の削除
   - `_SaveButtonSection`ウィジェットの削除

3. `test/features/haiku/presentation/providers/haiku_provider_test.dart`
   - imageUrl関連テストの追加

### 影響なしファイル

- `lib/features/haiku/data/models/haiku_model.dart` (変更不要)
- `lib/features/haiku/data/repositories/haiku_repository.dart` (変更不要)
- `lib/features/haiku/presentation/providers/image_save_provider.dart` (既存活用)
- `lib/features/haiku/data/repositories/haiku_image_storage_repository.dart` (既存活用)

## 次のステップ

1. `/plan`フェーズで詳細実装計画を作成
2. `/implement`フェーズで実装
3. `/test`フェーズで検証

## 結論

```
status: COMPLETED
next: PLAN
branch: feature/post-with-firestore-integration
architecture_layer: Feature
test_coverage_required: comprehensive
details: "調査完了。feature/post-with-firestore-integration ブランチ作成済み。詳細は docs/investigate/investigate_20251130_post_firestore_integration.md を参照。実装推奨。"
```
