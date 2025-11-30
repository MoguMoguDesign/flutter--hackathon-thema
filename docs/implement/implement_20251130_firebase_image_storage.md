# 実装報告書: Firebase Storage画像保存機能

## 概要

プレビュー画面で生成された俳句画像をFirebase Storageに保存する機能を実装しました。

**関連Issue**: [#55](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/55)
**Pull Request**: [#56](https://github.com/MoguMoguDesign/flutter--hackathon-thema/pull/56)
**ブランチ**: `feature/firebase-image-storage`

## 実装内容

### Phase 1: Data Layer（Repository）

#### HaikuImageStorageRepository
- **ファイル**: `lib/features/haiku/data/repositories/haiku_image_storage_repository.dart`
- **機能**:
  - `StorageRepository`を継承し`haiku_images/`パスを使用
  - `uploadHaikuImage()`で画像をFirebase Storageにアップロード
  - `HaikuImageMetadata`でカスタムメタデータを管理

```dart
class HaikuImageStorageRepository extends StorageRepository {
  HaikuImageStorageRepository() : super(basePath: 'haiku_images');

  Future<String> uploadHaikuImage({
    required Uint8List imageData,
    String? haikuId,
    String? userId,
    HaikuImageMetadata? metadata,
  }) async { ... }
}
```

### Phase 2: State Layer（Freezed）

#### ImageSaveState
- **ファイル**: `lib/features/haiku/presentation/state/image_save_state.dart`
- **状態**:
  - `initial`: 初期状態
  - `saving`: 保存中
  - `success(downloadUrl)`: 保存成功
  - `error(message)`: エラー

### Phase 3: Provider Layer（Riverpod）

#### ImageSaveProvider
- **ファイル**: `lib/features/haiku/presentation/providers/image_save_provider.dart`
- **機能**:
  - `@riverpod`アノテーションによる状態管理
  - `saveImage()`でFirebase Storageへアップロード
  - `_mapFirebaseError()`でユーザー向けエラーメッセージに変換

エラーマッピング:
| Firebase Error Code | ユーザー向けメッセージ |
|---------------------|---------------------|
| permission-denied | 保存の権限がありません |
| canceled | 保存がキャンセルされました |
| quota-exceeded | ストレージ容量が不足しています |
| unauthenticated | 認証が必要です |
| その他 | 保存に失敗しました。再試行してください |

### Phase 4: UI Layer（PreviewPage）

#### PreviewPage更新
- **ファイル**: `lib/features/haiku/presentation/pages/preview_page.dart`
- **追加機能**:
  - 「画像を保存」ボタン（`_SaveButtonSection`）
  - 状態に応じたUI表示（初期/保存中/成功/エラー）
  - 保存成功時はSnackBar表示

## テスト

### Repository Tests
- **ファイル**: `test/features/haiku/data/repositories/haiku_image_storage_repository_test.dart`
- **テスト内容**:
  - `HaikuImageMetadata.toMap()`の各パターン
  - 日本語文字の正常処理

### Provider Tests
- **ファイル**: `test/features/haiku/presentation/providers/image_save_provider_test.dart`
- **テスト内容**:
  - 初期状態の検証
  - 保存成功フロー
  - 空データエラー
  - Firebase例外のマッピング（permission-denied, quota-exceeded, canceled, unauthenticated, unknown）
  - リセット機能

## 検証結果

| コマンド | 結果 |
|---------|------|
| `fvm flutter analyze` | No issues found |
| `dart format --set-exit-if-changed .` | 3 files formatted |
| `fvm flutter test` | 48 tests passed |

## 作成ファイル一覧

### 新規作成
1. `lib/features/haiku/data/repositories/haiku_image_storage_repository.dart`
2. `lib/features/haiku/presentation/state/image_save_state.dart`
3. `lib/features/haiku/presentation/state/image_save_state.freezed.dart`（生成）
4. `lib/features/haiku/presentation/providers/image_save_provider.dart`
5. `lib/features/haiku/presentation/providers/image_save_provider.g.dart`（生成）
6. `test/features/haiku/data/repositories/haiku_image_storage_repository_test.dart`
7. `test/features/haiku/presentation/providers/image_save_provider_test.dart`
8. `test/features/haiku/presentation/providers/image_save_provider_test.mocks.dart`（生成）

### 修正
1. `lib/features/haiku/presentation/pages/preview_page.dart`

## アーキテクチャ準拠

- Three-Layer Architecture: Feature層内で完結
- hooks_riverpod 3.x: `@riverpod`アノテーション使用
- Freezed: `ImageSaveState`で使用
- ドキュメント: 日本語コメント（///）

## 備考

- 実際のFirebase Storage操作は既存の`StorageRepository`基底クラスを利用
- `Ref`型の使用により、riverpod_generator 3.xに対応
- Freezed 3.xの拡張メソッドパターン（`ImageGenerationStatePatterns`）に対応するためimportを追加
