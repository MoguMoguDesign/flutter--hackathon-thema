# コーディングスタイルガイド

このドキュメントは、Flutter Hackathon Thema プロジェクトのコーディング規約とスタイルガイドを定義します。

---

## 目次

1. [基本方針](#基本方針)
2. [Dart コーディング規約](#dart-コーディング規約)
3. [命名規則](#命名規則)
4. [フォーマットとレイアウト](#フォーマットとレイアウト)
5. [Widget スタイル](#widget-スタイル)
6. [状態管理（Riverpod）](#状態管理riverpod)
7. [コメントとドキュメント](#コメントとドキュメント)
8. [ファイル構成](#ファイル構成)
9. [禁止事項](#禁止事項)

---

## 基本方針

### コーディングの原則

1. **可読性を最優先**: 誰が読んでも理解しやすいコードを書く
2. **一貫性の維持**: プロジェクト全体で統一されたスタイルを保つ
3. **SOLID 原則の遵守**: 保守性の高い設計を心がける
4. **DRY 原則**: 重複を避け、再利用可能なコードを書く
5. **KISS 原則**: シンプルで理解しやすい実装を優先する

### 静的解析ツール

本プロジェクトは `flutter_lints` を使用します。

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml
```

すべてのコードは以下のコマンドでエラーが出ないことを確認してください：

```bash
fvm flutter analyze
```

---

## Dart コーディング規約

### 基本ルール

Dart の公式スタイルガイドに従います：
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)

### 必須ルール

#### 1. すべての公開 API にドキュメントコメントを書く

```dart
/// ユーザー認証を管理するプロバイダー
///
/// ログイン、ログアウト、ユーザー情報の取得を提供します。
@riverpod
class AuthNotifier extends _$AuthNotifier {
  // ...
}
```

#### 2. 型を明示的に指定する

```dart
// ✅ 良い例
final String userName = 'John';
final List<int> numbers = [1, 2, 3];

// ❌ 悪い例
final userName = 'John';  // 型が不明瞭
var numbers = [1, 2, 3];  // var は避ける
```

#### 3. `const` を積極的に使用する

```dart
// ✅ 良い例
const EdgeInsets.all(16.0)
const SizedBox(height: 24)

// ❌ 悪い例
EdgeInsets.all(16.0)
SizedBox(height: 24)
```

---

## 命名規則

### ファイル名

- **snake_case** を使用
- 内容を明確に表す名前を付ける

```
✅ auth_repository.dart
✅ user_profile_page.dart
✅ custom_button.dart

❌ AuthRepository.dart
❌ userProfilePage.dart
❌ btn.dart
```

### クラス名

- **PascalCase** を使用
- 名詞で命名

```dart
// ✅ 良い例
class AuthRepository { }
class UserProfile { }
class CustomButton extends StatelessWidget { }

// ❌ 悪い例
class authRepository { }
class user_profile { }
class btn extends StatelessWidget { }
```

### 変数・関数名

- **lowerCamelCase** を使用
- 変数は名詞、関数は動詞で命名

```dart
// ✅ 良い例
String userName;
int itemCount;
void fetchUserData() { }
Future<void> login() async { }

// ❌ 悪い例
String UserName;
int item_count;
void UserData() { }
Future<void> Login() async { }
```

### 定数名

- **lowerCamelCase** を使用
- 意味のある名前を付ける

```dart
// ✅ 良い例
const double defaultPadding = 16.0;
const Color primaryColor = Color(0xFF6200EE);
const String apiBaseUrl = 'https://api.example.com';

// ❌ 悪い例
const double PADDING = 16.0;
const Color color1 = Color(0xFF6200EE);
const String URL = 'https://api.example.com';
```

### Private メンバー

- 先頭に `_` を付ける

```dart
// ✅ 良い例
class AuthRepository {
  String _apiKey;

  void _validateCredentials() { }
}

// ❌ 悪い例
class AuthRepository {
  String apiKey;  // 公開する必要がないなら private にする

  void validateCredentials() { }
}
```

### Boolean 変数

- `is`、`has`、`can`、`should` で始める

```dart
// ✅ 良い例
bool isLoggedIn;
bool hasPermission;
bool canEdit;
bool shouldUpdate;

// ❌ 悪い例
bool loggedIn;
bool permission;
bool edit;
bool update;
```

---

## フォーマットとレイアウト

### インデント

- スペース2つ（Flutter 標準）
- `dart format` コマンドを使用

```bash
dart format --set-exit-if-changed .
```

### 行の長さ

- 最大80文字を推奨
- 超える場合は適切に改行

```dart
// ✅ 良い例
final user = User(
  id: '123',
  name: 'John Doe',
  email: 'john@example.com',
);

// ❌ 悪い例
final user = User(id: '123', name: 'John Doe', email: 'john@example.com', age: 30, address: '123 Main St');
```

### Import の順序

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:convert';

// 2. Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. 外部パッケージ（アルファベット順）
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 4. プロジェクト内 - shared
import 'package:flutterhackthema/shared/constants/app_colors.dart';
import 'package:flutterhackthema/shared/util/validators.dart';

// 5. プロジェクト内 - features
import 'package:flutterhackthema/features/auth/data/models/user.dart';

// 6. 相対パス（同一 Feature 内のみ）
import '../widgets/custom_button.dart';
import 'auth_state.dart';
```

### 空行の使用

```dart
// ✅ 良い例
class AuthRepository {
  final Dio _dio;
  final Logger _logger;

  AuthRepository(this._dio, this._logger);

  Future<User> login(String email, String password) async {
    _logger.i('ログイン試行: $email');

    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    return User.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post('/logout');
  }
}

// ❌ 悪い例（空行なし）
class AuthRepository {
  final Dio _dio;
  final Logger _logger;
  AuthRepository(this._dio, this._logger);
  Future<User> login(String email, String password) async {
    _logger.i('ログイン試行: $email');
    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });
    return User.fromJson(response.data);
  }
  Future<void> logout() async {
    await _dio.post('/logout');
  }
}
```

---

## Widget スタイル

### StatelessWidget vs StatefulWidget

- **可能な限り StatelessWidget を使用**
- 状態管理は Riverpod で行う

```dart
// ✅ 良い例: Riverpod で状態管理
class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Text(user.name),
    );
  }
}

// ❌ 悪い例: StatefulWidget で状態管理
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}
```

### Widget の分割

- 1つのウィジェットは100行以内を目安に分割
- 再利用可能な部分は別ウィジェットに抽出

```dart
// ✅ 良い例
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ログイン')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LoginForm(),
            SizedBox(height: 16),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

// 分割されたウィジェット
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // フォームの実装
  }
}
```

### const コンストラクタの使用

- 可能な限り `const` コンストラクタを使用
- パフォーマンス向上のため

```dart
// ✅ 良い例
const Text('Hello')
const SizedBox(height: 16)
const Icon(Icons.home)

// ❌ 悪い例
Text('Hello')
SizedBox(height: 16)
Icon(Icons.home)
```

### Widget の命名

- 具体的で説明的な名前を付ける

```dart
// ✅ 良い例
class UserProfileCard extends StatelessWidget { }
class LoginButton extends StatelessWidget { }
class CustomTextField extends StatelessWidget { }

// ❌ 悪い例
class Card1 extends StatelessWidget { }
class Btn extends StatelessWidget { }
class Widget1 extends StatelessWidget { }
```

---

## 状態管理（Riverpod）

### Provider の定義

- `@riverpod` アノテーションを使用
- コード生成を活用

```dart
// ✅ 良い例
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

// ❌ 悪い例（古い書き方）
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
```

### State クラスの定義

- Freezed を使用してイミュータブルな状態を定義

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

### Provider の使用

```dart
// ✅ 良い例: ref.watch でリアクティブに監視
class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.when(
      initial: () => const Text('初期状態'),
      loading: () => const CircularProgressIndicator(),
      authenticated: (user) => Text('ようこそ、${user.name}さん'),
      error: (message) => Text('エラー: $message'),
    );
  }
}

// ✅ 良い例: ref.read でイベントハンドラから呼び出し
ElevatedButton(
  onPressed: () {
    ref.read(authNotifierProvider.notifier).login(email, password);
  },
  child: const Text('ログイン'),
)
```

---

## コメントとドキュメント

### ドキュメントコメント

- 公開 API には必ずドキュメントコメントを書く
- `///` を使用

```dart
/// ユーザー認証を管理するリポジトリ
///
/// Firebase Authentication を使用してログイン、ログアウト、
/// ユーザー情報の取得を提供します。
class AuthRepository {
  /// 指定されたメールアドレスとパスワードでログインします
  ///
  /// [email] ユーザーのメールアドレス
  /// [password] ユーザーのパスワード
  ///
  /// ログインに成功した場合は [User] を返します。
  /// 認証情報が無効な場合は [AuthException] をスローします。
  Future<User> login(String email, String password) async {
    // 実装
  }
}
```

### インラインコメント

- 複雑なロジックの説明に使用
- `//` を使用

```dart
// ✅ 良い例: 複雑なロジックを説明
Future<void> processPayment(double amount) async {
  // 支払い金額を検証（最小100円、最大100万円）
  if (amount < 100 || amount > 1000000) {
    throw InvalidAmountException();
  }

  // トランザクションを開始
  final transaction = await _startTransaction();

  try {
    // 決済処理を実行
    await _executePayment(transaction, amount);

    // トランザクションをコミット
    await transaction.commit();
  } catch (e) {
    // エラー時はロールバック
    await transaction.rollback();
    rethrow;
  }
}

// ❌ 悪い例: 自明なことをコメント
final userName = user.name;  // ユーザー名を取得
```

### TODO コメント

- 将来の改善点や未実装機能を記載
- GitHub Issue 番号を含める

```dart
// TODO(#123): ページネーション機能を実装
// TODO(#456): エラーハンドリングを改善
// FIXME: メモリリークの可能性があるため修正が必要
```

---

## ファイル構成

### 1ファイル1クラスの原則

- 1つのファイルには1つの主要なクラスのみを定義
- 例外: 密接に関連する小さなヘルパークラス

```dart
// ✅ 良い例
// user_profile.dart
class UserProfile {
  final String id;
  final String name;
  final String email;
}

// ✅ 良い例（関連する小さなクラス）
// auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}

// ❌ 悪い例（無関係な複数クラス）
// models.dart
class User { }
class Product { }
class Order { }
```

### ファイルの長さ

- 1ファイル500行以内を目安
- 超える場合は分割を検討

---

## 禁止事項

### 1. Dynamic 型の使用

```dart
// ❌ 禁止
dynamic data = getData();

// ✅ 型を明示
final Map<String, dynamic> data = getData();
```

### 2. print() の使用

```dart
// ❌ 禁止
print('デバッグ情報');

// ✅ Logger を使用
logger.i('デバッグ情報');
logger.e('エラー情報');
```

### 3. コードの重複

```dart
// ❌ 禁止（重複コード）
void loginWithEmail() {
  showDialog(/* ... */);
  // ログイン処理
}

void loginWithGoogle() {
  showDialog(/* ... */);  // 同じダイアログを表示
  // ログイン処理
}

// ✅ 共通化
void _showLoginDialog() {
  showDialog(/* ... */);
}

void loginWithEmail() {
  _showLoginDialog();
  // ログイン処理
}

void loginWithGoogle() {
  _showLoginDialog();
  // ログイン処理
}
```

### 4. Magic Numbers

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
const EdgeInsets.all(AppSpacing.medium)
```

### 5. 長すぎる関数

```dart
// ❌ 禁止（100行以上の関数）
Future<void> processOrder() async {
  // 100行以上のコード
}

// ✅ 分割
Future<void> processOrder() async {
  await _validateOrder();
  await _calculateTotal();
  await _processPayment();
  await _sendConfirmation();
}
```

---

## まとめ

本スタイルガイドに従うことで、以下を実現できます：

1. **可読性の向上**: 誰が読んでも理解しやすいコード
2. **保守性の向上**: 変更や拡張が容易なコード
3. **一貫性の確保**: チーム全体で統一されたスタイル
4. **品質の向上**: バグの少ない堅牢なコード

すべての開発者がこのガイドに従い、高品質なコードを維持してください。
