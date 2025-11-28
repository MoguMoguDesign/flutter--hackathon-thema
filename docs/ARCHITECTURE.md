# アーキテクチャ設計ドキュメント

このドキュメントは、Flutter Hackathon Thema プロジェクトのアーキテクチャ設計と実装ガイドラインを定義します。

---

## 目次

1. [アーキテクチャ概要](#アーキテクチャ概要)
2. [三層アーキテクチャ](#三層アーキテクチャ)
3. [ディレクトリ構造](#ディレクトリ構造)
4. [依存関係ルール](#依存関係ルール)
5. [各層の責務](#各層の責務)
6. [Feature モジュールの構造](#feature-モジュールの構造)
7. [状態管理](#状態管理)
8. [ルーティング](#ルーティング)
9. [ベストプラクティス](#ベストプラクティス)

---

## アーキテクチャ概要

本プロジェクトは、**三層アーキテクチャ（Three-Layer Architecture）** を採用しています。
この設計は、スケーラビリティ、保守性、テスタビリティを重視し、明確な関心の分離を実現します。

### アーキテクチャの目的

- **モジュラリティ**: 各機能が独立したモジュールとして実装される
- **保守性**: 変更の影響範囲を最小限に抑える
- **テスタビリティ**: 各層を独立してテスト可能
- **スケーラビリティ**: 新機能の追加が容易
- **再利用性**: 共通コンポーネントの効率的な再利用

---

## 三層アーキテクチャ

本プロジェクトは以下の3つの層で構成されます：

```
┌─────────────────────────────────────┐
│         App Layer (アプリ層)        │
│  ・ルーティング                     │
│  ・DI (Dependency Injection)       │
│  ・グローバル設定                   │
└─────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────┐
│      Feature Layer (機能層)         │
│  ・独立した機能モジュール           │
│  ・Data + Presentation + Service    │
└─────────────────────────────────────┘
              ↓ depends on
┌─────────────────────────────────────┐
│      Shared Layer (共有層)          │
│  ・共通コンポーネント               │
│  ・ユーティリティ                   │
│  ・定数                             │
└─────────────────────────────────────┘
```

### 1. App Layer（アプリケーション層）

アプリケーション全体の設定とグローバルな機能を管理します。

**責務:**
- アプリ全体のルーティング設定
- 依存性注入（DI）の設定
- グローバルな状態管理
- アプリ全体で使用するウィジェット
- ルートガード、認証チェック

**依存関係:**
- Feature Layer に依存
- Shared Layer に依存

### 2. Feature Layer（機能層）

各機能を独立したモジュールとして実装します。

**責務:**
- 機能固有のビジネスロジック
- UI とデータの管理
- 機能内の状態管理

**依存関係:**
- Shared Layer にのみ依存
- **他の Feature との直接依存は禁止**

### 3. Shared Layer（共有層）

全ての層で共通して使用されるコンポーネントを提供します。

**責務:**
- 共通ウィジェット
- ユーティリティ関数
- 定数定義
- 共通モデル
- エラーハンドリング

**依存関係:**
- **他の層に依存しない（完全に独立）**

---

## ディレクトリ構造

```
lib/
├── main.dart                  # エントリーポイント
├── app/                       # App Layer
│   ├── app_di/                # 依存性注入
│   ├── app_router/            # ルーティング設定
│   ├── route_guard/           # ルートガード
│   └── widgets/               # アプリ全体のウィジェット
│
├── features/                  # Feature Layer
│   ├── feature_a/             # 機能A
│   │   ├── data/              # データ層
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── presentation/      # プレゼンテーション層
│   │   │   ├── providers/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── state/
│   │   └── service/           # サービス層（ビジネスロジック）
│   │
│   └── feature_b/             # 機能B
│       └── (同じ構造)
│
└── shared/                    # Shared Layer
    ├── constants/             # 定数
    ├── data/                  # 共通データ
    │   └── models/
    ├── error/                 # エラーハンドリング
    ├── presentation/          # 共通UI
    │   ├── providers/
    │   └── widgets/
    ├── service/               # 共通サービス
    └── util/                  # ユーティリティ
```

---

## 依存関係ルール

### 基本原則

1. **一方向の依存関係**: App → Feature → Shared の一方向のみ
2. **Feature 間の独立性**: Feature 同士は直接依存してはいけない
3. **Shared の完全独立**: Shared 層は他の層に依存しない

### 依存関係の図

```
App Layer
  ├─→ Feature A
  ├─→ Feature B
  ├─→ Feature C
  └─→ Shared Layer
       ↑
Feature A ─┘
       ↑
Feature B ─┘
       ↑
Feature C ─┘

❌ Feature A → Feature B (禁止)
❌ Shared → Feature (禁止)
❌ Shared → App (禁止)
```

### 違反例と正しい実装

#### ❌ 悪い例: Feature 間の直接依存

```dart
// ❌ Feature A が Feature B に直接依存
// lib/features/feature_a/presentation/pages/page_a.dart
import 'package:flutterhackthema/features/feature_b/data/models/model_b.dart';
```

#### ✅ 良い例: Shared を経由

```dart
// ✅ 共通モデルを Shared に配置
// lib/shared/data/models/common_model.dart
class CommonModel { ... }

// Feature A から使用
// lib/features/feature_a/presentation/pages/page_a.dart
import 'package:flutterhackthema/shared/data/models/common_model.dart';

// Feature B からも使用可能
// lib/features/feature_b/presentation/pages/page_b.dart
import 'package:flutterhackthema/shared/data/models/common_model.dart';
```

---

## 各層の責務

### App Layer の責務

| コンポーネント | 責務 | 例 |
|------------|------|-----|
| app_router | アプリ全体のルーティング設定 | GoRouter の設定 |
| app_di | 依存性注入の設定 | Riverpod プロバイダーのグローバル設定 |
| route_guard | 認証チェック、権限確認 | ログイン状態の確認 |
| widgets | アプリ全体で使用するウィジェット | アプリバー、ナビゲーションバー |

### Feature Layer の責務

各 Feature は以下の3つのサブレイヤーで構成されます：

#### 1. Data Layer（データ層）

| コンポーネント | 責務 |
|------------|------|
| models | データモデルの定義 |
| repositories | データの取得・保存ロジック |
| local_storage | ローカルストレージへのアクセス |

```dart
// 例: lib/features/auth/data/repositories/auth_repository.dart
class AuthRepository {
  Future<User> login(String email, String password) async {
    // ログイン処理
  }
}
```

#### 2. Presentation Layer（プレゼンテーション層）

| コンポーネント | 責務 |
|------------|------|
| providers | 状態管理（Riverpod） |
| pages | 画面全体の構成 |
| widgets | 再利用可能なUIコンポーネント |
| state | 状態クラスの定義 |

```dart
// 例: lib/features/auth/presentation/providers/auth_provider.dart
@riverpod
class AuthNotifier extends _$AuthNotifier {
  // 状態管理ロジック
}
```

#### 3. Service Layer（サービス層）

| コンポーネント | 責務 |
|------------|------|
| services | ビジネスロジックの実装 |
| validators | バリデーション |
| mappers | データ変換 |

```dart
// 例: lib/features/auth/service/auth_service.dart
class AuthService {
  Future<void> validateAndLogin(String email, String password) async {
    // バリデーション + ログイン処理
  }
}
```

### Shared Layer の責務

| ディレクトリ | 責務 | 例 |
|----------|------|-----|
| constants | アプリ全体の定数 | カラー定義、テキストスタイル |
| data/models | 共通データモデル | Result型、エラーモデル |
| error | エラーハンドリング | 例外クラス、失敗クラス |
| presentation/widgets | 共通UIコンポーネント | ボタン、カード、ダイアログ |
| service | 共通サービス | ロギング、分析 |
| util | ユーティリティ関数 | 日付変換、バリデーション |

---

## Feature モジュールの構造

各 Feature モジュールは以下の構造に従います：

```
features/
└── example_feature/
    ├── data/
    │   ├── models/
    │   │   ├── example_model.dart
    │   │   ├── example_model.freezed.dart  # 自動生成
    │   │   └── example_model.g.dart        # 自動生成
    │   └── repositories/
    │       ├── example_repository.dart
    │       └── example_repository.g.dart   # 自動生成
    │
    ├── presentation/
    │   ├── providers/
    │   │   ├── example_provider.dart
    │   │   └── example_provider.g.dart     # 自動生成
    │   ├── state/
    │   │   ├── example_state.dart
    │   │   └── example_state.freezed.dart  # 自動生成
    │   ├── pages/
    │   │   └── example_page.dart
    │   └── widgets/
    │       ├── example_widget_a.dart
    │       └── example_widget_b.dart
    │
    └── service/
        ├── example_service.dart
        └── example_validator.dart
```

---

## 状態管理

本プロジェクトは **hooks_riverpod 3.x** を使用した状態管理を採用します。

### Provider の配置ルール

| Provider の種類 | 配置場所 |
|--------------|---------|
| グローバルなプロバイダー | `lib/app/app_di/` |
| Feature 固有のプロバイダー | `lib/features/{feature}/presentation/providers/` |
| 共通プロバイダー | `lib/shared/presentation/providers/` |

### Riverpod のコード生成

```dart
// lib/features/auth/presentation/providers/auth_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    // ログイン処理
  }
}
```

コード生成コマンド:
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## ルーティング

本プロジェクトは **go_router 16.x** を使用した宣言的ルーティングを採用します。

### ルート定義の配置

- グローバルルート: `lib/app/app_router/`
- Feature 固有のルート: `lib/features/{feature}/presentation/routes/`

### ルート定義例

```dart
// lib/app/app_router/app_router.dart
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
```

---

## ベストプラクティス

### 1. 依存関係の管理

- ✅ Feature は Shared にのみ依存
- ✅ Feature 間で共通のモデルは Shared に配置
- ❌ Feature 間で直接 import しない

### 2. コード生成の活用

- Freezed でイミュータブルなモデルを生成
- Riverpod Generator でプロバイダーを生成
- JSON Serializable で JSON シリアライゼーションを自動化

### 3. 命名規則

| 対象 | 命名規則 | 例 |
|------|---------|-----|
| ファイル | snake_case | `auth_repository.dart` |
| クラス | PascalCase | `AuthRepository` |
| 変数・関数 | camelCase | `getUserData()` |
| 定数 | lowerCamelCase | `primaryColor` |
| Private | 先頭に `_` | `_privateMethod()` |

### 4. ディレクトリ命名

- Feature ディレクトリ: 機能名の複数形または単数形（一貫性を保つ）
- 例: `auth/`, `profile/`, `settings/`

### 5. Import の順序

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. 外部パッケージ
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 4. プロジェクト内（絶対パス）
import 'package:flutterhackthema/shared/constants/app_colors.dart';
import 'package:flutterhackthema/features/auth/data/models/user.dart';

// 5. 相対パス（同一 Feature 内のみ）
import '../widgets/custom_button.dart';
```

---

## まとめ

本アーキテクチャは以下の原則に基づいています：

1. **明確な関心の分離**: 各層が明確な責務を持つ
2. **一方向の依存**: App → Feature → Shared
3. **Feature の独立性**: Feature 同士は直接依存しない
4. **共通化の徹底**: 共通コンポーネントは Shared に配置
5. **スケーラビリティ**: 新機能の追加が容易

このアーキテクチャに従うことで、保守性とスケーラビリティの高いアプリケーションを構築できます。
