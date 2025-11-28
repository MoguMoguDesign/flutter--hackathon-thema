# コーディングスタイルと規約

## 基本方針
1. **可読性を最優先**: 誰が読んでも理解しやすいコードを書く
2. **一貫性の維持**: プロジェクト全体で統一されたスタイルを保つ
3. **SOLID原則の遵守**: 保守性の高い設計を心がける
4. **DRY原則**: 重複を避け、再利用可能なコードを書く
5. **KISS原則**: シンプルで理解しやすい実装を優先する

## 静的解析

### 必須ルール
- `fvm flutter analyze` でエラーが出ないこと
- `very_good_analysis` + `riverpod_lint` + `custom_lint` に準拠

### 設定ファイル
```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml
```

## 命名規則

### ファイル名
- **snake_case** を使用
- 内容を明確に表す名前

✅ 良い例: `auth_repository.dart`, `user_profile_page.dart`, `custom_button.dart`
❌ 悪い例: `AuthRepository.dart`, `userProfilePage.dart`, `btn.dart`

### クラス名
- **PascalCase** を使用
- 名詞で命名

✅ 良い例: `AuthRepository`, `UserProfile`, `CustomButton`
❌ 悪い例: `authRepository`, `user_profile`, `btn`

### 変数・関数名
- **lowerCamelCase** を使用
- 変数は名詞、関数は動詞で命名

✅ 良い例: `userName`, `itemCount`, `fetchUserData()`, `login()`
❌ 悪い例: `UserName`, `item_count`, `UserData()`, `Login()`

### 定数名
- **lowerCamelCase** を使用
- 意味のある名前

✅ 良い例: `defaultPadding`, `primaryColor`, `apiBaseUrl`
❌ 悪い例: `PADDING`, `color1`, `URL`

### Boolean変数
- `is`, `has`, `can`, `should` で始める

✅ 良い例: `isLoggedIn`, `hasPermission`, `canEdit`, `shouldUpdate`
❌ 悪い例: `loggedIn`, `permission`, `edit`, `update`

### Private メンバー
- 先頭に `_` を付ける

```dart
class AuthRepository {
  String _apiKey;
  void _validateCredentials() { }
}
```

## コーディングルール

### 1. 型を明示的に指定
```dart
// ✅ 良い例
final String userName = 'John';
final List<int> numbers = [1, 2, 3];

// ❌ 悪い例
final userName = 'John';  // 型が不明瞭
var numbers = [1, 2, 3];  // var は避ける
```

### 2. const を積極的に使用
```dart
// ✅ 良い例
const EdgeInsets.all(16.0)
const SizedBox(height: 24)
const Text('Hello')

// ❌ 悪い例
EdgeInsets.all(16.0)
SizedBox(height: 24)
Text('Hello')
```

### 3. StatelessWidget を優先
- 可能な限り StatelessWidget を使用
- 状態管理は Riverpod で行う

```dart
// ✅ 良い例: Riverpod で状態管理
class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(body: Text(user.name));
  }
}
```

## フォーマット

### インデント
- スペース2つ（Flutter標準）
- `dart format` コマンドで自動整形

### 行の長さ
- 最大80文字を推奨
- 超える場合は適切に改行

### Import 順序
```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. 外部パッケージ（アルファベット順）
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 4. プロジェクト内 - shared
import 'package:flutterhackthema/shared/constants/app_colors.dart';

// 5. プロジェクト内 - features
import 'package:flutterhackthema/features/auth/data/models/user.dart';

// 6. 相対パス（同一Feature内のみ）
import '../widgets/custom_button.dart';
```

### 空行の使用
- クラスメンバー間に空行を入れる
- メソッド間に空行を入れる
- 論理的なブロック間に空行を入れる

## Riverpod パターン

### Provider定義
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    // ログイン処理
  }
}
```

### State定義（Freezed）
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

## コメントとドキュメント

### ドキュメントコメント
- 公開APIには必ず `///` でドキュメントを書く

```dart
/// ユーザー認証を管理するリポジトリ
///
/// Firebase Authenticationを使用してログイン、ログアウト、
/// ユーザー情報の取得を提供します。
class AuthRepository {
  /// 指定されたメールアドレスとパスワードでログインします
  ///
  /// [email] ユーザーのメールアドレス
  /// [password] ユーザーのパスワード
  ///
  /// ログインに成功した場合は [User] を返します。
  Future<User> login(String email, String password) async {
    // 実装
  }
}
```

### TODOコメント
```dart
// TODO(#123): ページネーション機能を実装
// FIXME: メモリリークの可能性があるため修正が必要
```

## 禁止事項

### ❌ dynamic型の使用
```dart
// ❌ 禁止
dynamic data = getData();

// ✅ 型を明示
final Map<String, dynamic> data = getData();
```

### ❌ print()の使用
```dart
// ❌ 禁止
print('デバッグ情報');

// ✅ Loggerを使用
logger.i('デバッグ情報');
logger.e('エラー情報');
```

### ❌ コードの重複
```dart
// ❌ 禁止（重複コード）
void loginWithEmail() {
  showDialog(/* ... */);
  // ログイン処理
}
void loginWithGoogle() {
  showDialog(/* ... */);  // 同じダイアログ
  // ログイン処理
}

// ✅ 共通化
void _showLoginDialog() { showDialog(/* ... */); }
void loginWithEmail() { _showLoginDialog(); }
void loginWithGoogle() { _showLoginDialog(); }
```

### ❌ Magic Numbers
```dart
// ❌ 禁止
const SizedBox(height: 24)
const EdgeInsets.all(16)

// ✅ 定数化
// lib/shared/constants/app_spacing.dart
class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

// 使用例
const SizedBox(height: AppSpacing.large)
```

## ファイル構成

### 1ファイル1クラスの原則
- 1つのファイルには1つの主要なクラスのみ
- 例外: 密接に関連する小さなヘルパークラス

### ファイルの長さ
- 1ファイル500行以内を目安
- 超える場合は分割を検討

## チェックリスト

コード作成時の確認事項：
- [ ] 型が明示されているか
- [ ] const が使われているか
- [ ] 命名規則に従っているか
- [ ] 適切なコメントが書かれているか
- [ ] 重複コードがないか
- [ ] Magic Numbersが定数化されているか
- [ ] `fvm flutter analyze` でエラーがないか
- [ ] `dart format` でフォーマットされているか
