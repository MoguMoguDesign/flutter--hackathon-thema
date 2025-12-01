# Investigation: Firebase Functions を利用した Gemini API 呼び出しのセキュア化

**Issue**: #66
**Branch**: `feature/firebase-functions-gemini-api`
**Date**: 2025-12-01

---

## 1. 調査概要

### 1.1 背景

Flutter Web から Gemini API を直接呼び出しており、API キーがクライアント側に露出するセキュリティリスクがある。Firebase Functions を中間層として導入し、以下を実現する:

- API キーをサーバーサイドで管理
- 画像生成時に Firebase Storage/Firestore への保存もサーバーで実行
- 匿名認証による認証済みユーザーのみアクセス可能に

### 1.2 現在のアーキテクチャ

```
[Flutter Web] --直接--> [Gemini API]
      |                      |
      +-- API キー露出 --<-----+
      |
      +---(画像データ)---> [Firebase Storage] (クライアントから直接)
      |
      +---(俳句データ)---> [Firestore] (クライアントから直接)
```

### 1.3 目標アーキテクチャ

```
[Flutter Web] --> [Firebase Functions] --> [Gemini API]
      |                   |                     |
   匿名認証済み            +----> [Firebase Storage]
                          |
                          +----> [Firestore]
                          |
                          +----> URL を返却
```

---

## 2. 現状分析

### 2.1 Gemini API 実装

**ファイル**: `lib/shared/service/gemini_service.dart`

- HTTP クライアントで直接 Gemini API を呼び出し
- API キーは `--dart-define=GEMINI_API_KEY` で注入
- Web ビルド時に JavaScript に API キーが埋め込まれる (セキュリティリスク)

```dart
// 現在の実装 (問題あり)
final apiUrl = '${ApiConfig.geminiBaseUrl}/models/${ApiConfig.geminiImageModel}:'
    'streamGenerateContent?key=$_effectiveApiKey';
```

**ファイル**: `lib/shared/data/repositories/image_generation_repository_web.dart`

- Web 専用の XMLHttpRequest 実装
- 同様に API キーが露出

### 2.2 Firebase 統合状況

| コンポーネント | 現状 | 備考 |
|--------------|------|------|
| Firebase Core | 有効 | `firebase_core: ^4.2.1` |
| Cloud Firestore | 有効 | `cloud_firestore: ^6.1.0` |
| Firebase Storage | 有効 | `firebase_storage: ^13.0.4` |
| Firebase Auth | **未導入** | 追加が必要 |
| Cloud Functions | **未導入** | 追加が必要 |

### 2.3 三層アーキテクチャ適合性

```
lib/
├── app/              # App Layer - ルーティング、DI
├── features/         # Feature Layer
│   ├── haiku/
│   │   ├── data/     # HaikuRepository, HaikuImageStorageRepository
│   │   ├── presentation/  # ImageGenerationProvider, ImageSaveProvider
│   │   └── service/  # HaikuPromptService
│   └── nickname/
└── shared/           # Shared Layer
    ├── service/      # GeminiService (変更対象)
    ├── data/         # FirestoreRepository, StorageRepository (基底クラス)
    └── models/       # ImageGenerationResult
```

**評価**: 三層アーキテクチャに準拠。GeminiService を FirebaseFunctionsService に置き換えても依存方向は維持可能。

### 2.4 Riverpod パターン

現在のプロバイダー構成:

```dart
// Shared Layer
@riverpod
GeminiService geminiService(Ref ref);

@riverpod
ImageGenerationRepository imageGenerationRepository(Ref ref);

// Feature Layer (haiku)
@riverpod
class ImageGeneration extends _$ImageGeneration;  // 画像生成状態管理

@riverpod
class ImageSave extends _$ImageSave;  // 画像保存状態管理
```

### 2.5 画像表示フロー

現在の `PreviewPage`:
- `imageGenerationProvider` から `Uint8List` を取得
- `Image.memory(imageData)` でローカル表示
- 投稿時に `imageSaveProvider` で Storage にアップロード

**変更後**:
- Firebase Functions から URL を受け取る
- `Image.network(imageUrl)` で表示 (Storage URL 直接参照)
- 投稿時は Functions 側で既に保存済みなのでスキップ可能

---

## 3. 必要な変更

### 3.1 Firebase Console 設定 (手動)

1. **Authentication**
   - 匿名認証を有効化

2. **Functions**
   - Firebase Functions プロジェクトのセットアップ
   - Blaze プラン (従量課金) へのアップグレード

3. **Secret Manager**
   - `GEMINI_API_KEY` をシークレットとして登録

### 3.2 Flutter 側の変更

#### pubspec.yaml への追加

```yaml
dependencies:
  firebase_auth: ^5.5.4
  cloud_functions: ^5.3.4
```

#### 新規ファイル

| ファイル | 説明 |
|---------|------|
| `lib/shared/service/auth_service.dart` | 匿名認証サービス |
| `lib/shared/service/firebase_functions_service.dart` | Functions 呼び出しサービス |

#### 変更ファイル

| ファイル | 変更内容 |
|---------|---------|
| `lib/main.dart` | アプリ起動時に匿名認証を実行 |
| `lib/shared/data/repositories/image_generation_repository.dart` | Functions 経由に変更 |
| `lib/shared/data/repositories/image_generation_repository_web.dart` | 削除または統合 |
| `lib/features/haiku/presentation/providers/image_generation_provider.dart` | 状態管理を URL ベースに変更 |
| `lib/features/haiku/presentation/state/image_generation_state.dart` | `Uint8List` から `String` (URL) に変更 |
| `lib/features/haiku/presentation/pages/preview_page.dart` | `Image.memory` から `Image.network` に変更 |
| `lib/features/haiku/presentation/providers/image_save_provider.dart` | Functions 側で保存済みなので簡略化 |

#### 削除可能ファイル

- `lib/shared/service/gemini_service.dart` (Functions に移行)
- `lib/shared/constants/api_config.dart` の API キー関連

### 3.3 Firebase Functions 側 (新規)

```
functions/
├── package.json
├── tsconfig.json
├── src/
│   └── index.ts
└── .env.example
```

**主な Function**:

```typescript
export const generateAndSaveImage = onCall(
  { secrets: [geminiApiKey] },
  async (request) => {
    // 1. 認証チェック
    // 2. Gemini API 呼び出し
    // 3. Firebase Storage に保存
    // 4. Firestore にメタデータ保存
    // 5. URL を返却
  }
);
```

---

## 4. テスト戦略

### 4.1 既存テスト影響

| テストファイル | 影響 | 対応 |
|--------------|------|------|
| `gemini_service_test.dart` | 高 | FirebaseFunctionsService 用に書き換え |
| `image_generation_repository_test.dart` | 高 | Functions モック対応 |
| `image_save_provider_test.dart` | 中 | ロジック簡略化に伴う更新 |
| `preview_page_test.dart` | 中 | URL 表示対応 |

### 4.2 新規テスト

- `auth_service_test.dart`: 匿名認証のテスト
- `firebase_functions_service_test.dart`: Functions 呼び出しテスト

### 4.3 テスト方針

- Firebase Functions は `FakeFirebaseFunctions` または Mock でテスト
- 認証は `FirebaseAuth.instance` のモック
- E2E テストは Firebase Emulator Suite を使用

---

## 5. リスク分析

| リスク | 影響度 | 対策 |
|-------|-------|------|
| Functions のコールドスタート遅延 | 中 | ローディング UI を改善、タイムアウト延長 |
| Blaze プラン必須 | 低 | 無料枠内で十分対応可能 |
| 匿名ユーザーの UID 消失 | 低 | 将来的に正式認証とリンク機能を検討 |
| 既存の投稿済み俳句との互換性 | 低 | 既存データは影響なし |

---

## 6. 実装順序 (推奨)

### Phase 1: 基盤整備

1. Firebase Console で匿名認証を有効化
2. `firebase_auth`, `cloud_functions` パッケージ追加
3. `AuthService` 実装 + テスト
4. `main.dart` で匿名認証呼び出し

### Phase 2: Functions 実装

5. Firebase Functions プロジェクトセットアップ
6. `generateAndSaveImage` Function 実装
7. Secret Manager に API キー登録
8. Functions デプロイ + テスト

### Phase 3: Flutter 統合

9. `FirebaseFunctionsService` 実装 + テスト
10. `ImageGenerationRepository` を Functions 経由に変更
11. `ImageGenerationState` を URL ベースに変更
12. `PreviewPage` を `Image.network` に変更
13. `ImageSaveProvider` 簡略化

### Phase 4: クリーンアップ

14. 旧 `GeminiService` 関連コード削除
15. `ApiConfig` から API キー設定削除
16. 全テスト更新 + 実行
17. 動作検証 + デプロイ

---

## 7. 結論

### 推奨事項

Issue #66 の実装を推奨する。以下の理由:

1. **セキュリティ向上**: API キーのクライアント露出を完全に防止
2. **アーキテクチャ適合**: 三層アーキテクチャを維持したまま実装可能
3. **既存パターン活用**: 既存の Firebase 統合パターンを拡張
4. **テスト容易性**: Mock/Fake で十分なテストカバレッジ達成可能

### 次フェーズ

**PLAN**: 詳細な実装計画を策定

---

## 8. 参考リンク

- [GitHub Issue #66](https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/66)
- [Firebase Functions v2](https://firebase.google.com/docs/functions)
- [Secret Manager](https://firebase.google.com/docs/functions/config-env#secret-manager)
- [Callable Functions](https://firebase.google.com/docs/functions/callable)
- [Firebase Anonymous Auth (Flutter)](https://firebase.google.com/docs/auth/flutter/anonymous-auth)
