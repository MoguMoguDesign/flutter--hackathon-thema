# 実装ドキュメント - Issue #66: Gemini API呼び出しのセキュア化

## 概要

**Issue**: #66 - Gemini API呼び出しをFirebase Functionsに移行してAPIキーをクライアントから隠蔽
**実装日**: 2025-12-01
**ブランチ**: `feature/firebase-functions-gemini-api`

## 実装内容

### Phase 1: 認証基盤

#### 1.1 パッケージ追加
- `firebase_auth: ^6.1.2`
- `cloud_functions: ^6.0.4`

#### 1.2 AuthService作成
**ファイル**: `lib/shared/service/auth_service.dart`

匿名認証サービスを実装:
- `ensureAuthenticated()`: 匿名認証を実行/確認
- `currentUser`, `isAuthenticated`, `currentUserId`: 現在のユーザー情報
- `signOut()`: サインアウト
- `authStateChanges()`: 認証状態のStream

テスト: 14テストすべてパス

#### 1.3 main.dart更新
アプリ起動時に匿名認証を初期化:
```dart
final authService = AuthService();
await authService.ensureAuthenticated();
```

### Phase 2: Firebase Functions (Python)

#### 2.1 functions/main.py
`generate_and_save_image` Cloud Functionを作成:

1. **認証チェック**: `req.auth`で認証済みユーザーか確認
2. **プロンプト検証**: 入力パラメータのバリデーション
3. **Gemini API呼び出し**: Secret Managerから取得したAPIキーを使用
4. **画像抽出**: Base64エンコードされた画像データを抽出
5. **Firebase Storage保存**: `haiku-images/{haiku_id}.png`に保存
6. **Firestore更新**: 画像メタデータを保存
7. **URL返却**: ダウンロードURLをクライアントに返却

特徴:
- タイムアウト: 120秒
- メモリ: 512MB
- APIキー: Google Secret Managerで管理

#### 2.2 requirements.txt
```
firebase-functions>=0.4.0
firebase-admin>=6.0.0
google-generativeai>=0.8.0
```

### Phase 3: Flutter統合

#### 3.1 FirebaseFunctionsService
**ファイル**: `lib/shared/service/firebase_functions_service.dart`

Cloud Functionsを呼び出すサービス:
- `generateAndSaveImage()`: 画像生成リクエストを送信
- エラーハンドリング: Firebase例外を日本語メッセージに変換

テスト: 13テストすべてパス

#### 3.2 FunctionsException
**ファイル**: `lib/shared/service/firebase_functions_exception.dart`

カスタム例外クラス:
- `message`: ユーザー向けエラーメッセージ
- `code`: エラーコード（オプション）

#### 3.3 ImageGenerationState変更
**ファイル**: `lib/features/haiku/presentation/state/image_generation_state.dart`

変更前:
```dart
const factory ImageGenerationState.success(Uint8List imageData) = ImageGenerationSuccess;
```

変更後:
```dart
const factory ImageGenerationState.success(String imageUrl) = ImageGenerationSuccess;
```

理由: サーバーサイドで画像を保存するため、クライアントにはURLのみ返却

#### 3.4 ImageGenerationProvider変更
**ファイル**: `lib/features/haiku/presentation/providers/image_generation_provider.dart`

変更内容:
- `ImageGenerationRepository`から`FirebaseFunctionsService`へ移行
- `FunctionsException`でエラーハンドリング

#### 3.5 PreviewPage変更
**ファイル**: `lib/features/haiku/presentation/pages/preview_page.dart`

変更内容:
- `Image.memory()`から`Image.network()`へ移行
- Dart 3 switch式でパターンマッチング
- `handlePost()`を簡素化（画像は既にサーバーで保存済み）

#### 3.6 ImageSaveProvider変更
**ファイル**: `lib/features/haiku/presentation/providers/image_save_provider.dart`

追加:
- `setPosting()`: 投稿中状態を設定（UI表示用）

## 技術的詳細

### Dart 3 パターンマッチング

Freezed 3.xでは`maybeWhen`メソッドが拡張として定義されているため、
Dart 3のswitch式を使用:

```dart
final imageUrl = switch (generationState) {
  ImageGenerationSuccess(:final imageUrl) => imageUrl,
  _ => null,
};
```

### セキュリティ改善

1. **APIキー保護**: Gemini APIキーをSecret Managerに移動
2. **認証必須**: Cloud Functionsは認証済みユーザーのみ呼び出し可能
3. **サーバーサイド処理**: 画像生成・保存をサーバーで実行

### アーキテクチャ変更

```
Before:
Client → Gemini API (直接呼び出し、APIキー露出)
       → Firebase Storage (クライアントアップロード)

After:
Client → Firebase Functions → Gemini API (APIキー保護)
                            → Firebase Storage (サーバーアップロード)
                            → Firestore (メタデータ保存)
```

## テスト結果

```
All tests passed! (170+ tests)
- auth_service_test.dart: 14 tests
- firebase_functions_service_test.dart: 13 tests
- 既存テスト: すべてパス
```

## コミット履歴

1. `feat(auth): add anonymous authentication service` - 認証サービス追加
2. `feat(functions): add Firebase Functions for secure image generation` - Functions統合

## デプロイ手順

### Firebase Functions デプロイ

```bash
# Secret Managerにgemini APIキーを設定
firebase functions:secrets:set GEMINI_API_KEY

# Functionsをデプロイ
firebase deploy --only functions
```

### Firebase Console設定

1. **Authentication**: 匿名認証を有効化
2. **Storage**: セキュリティルールを更新（認証済みユーザーのみ書き込み可）
3. **Firestore**: セキュリティルールを更新

## 残作業

- [ ] Phase 4: クリーンアップ（古いGeminiService等の削除）
- [ ] Firebase Consoleでの設定確認
- [ ] 本番環境でのテスト

## 参照

- 調査ドキュメント: `docs/investigate/investigate_20251201_issue66.md`
- 計画ドキュメント: `docs/plan/plan_20251201_issue66.md`
- Issue: https://github.com/MoguMoguDesign/flutter--hackathon-thema/issues/66
