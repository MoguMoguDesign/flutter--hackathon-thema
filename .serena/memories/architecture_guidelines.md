# アーキテクチャガイドライン

## 三層アーキテクチャの原則

### アーキテクチャ図
```
┌─────────────────────────────────────┐
│         App Layer (アプリ層)        │
│  ・ルーティング (go_router)         │
│  ・DI (Riverpod)                   │
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

### 依存関係のルール（絶対厳守）
✅ **一方向依存**: App → Feature → Shared
❌ **Feature 間の直接依存は禁止**
❌ **Shared は他の層に依存しない**

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
│   └── {feature_name}/        # 各機能モジュール
│       ├── data/              # データ層
│       │   ├── models/
│       │   └── repositories/
│       ├── presentation/      # プレゼンテーション層
│       │   ├── providers/
│       │   ├── pages/
│       │   ├── widgets/
│       │   └── state/
│       └── service/           # サービス層
│
└── shared/                    # Shared Layer
    ├── constants/             # 定数
    ├── data/                  # 共通データ
    ├── error/                 # エラーハンドリング
    ├── presentation/          # 共通UI
    ├── service/               # 共通サービス
    └── util/                  # ユーティリティ
```

## 各層の責務

### App Layer
- **責務**: アプリ全体の設定とグローバル機能
- **配置**:
  - ルーティング設定 → `lib/app/app_router/`
  - 依存性注入 → `lib/app/app_di/`
  - ルートガード → `lib/app/route_guard/`
  - アプリ全体のウィジェット → `lib/app/widgets/`

### Feature Layer
各Featureは3つのサブレイヤーで構成：

#### 1. Data Layer
- **責務**: データの取得・保存
- **配置**:
  - モデル → `models/`
  - リポジトリ → `repositories/`

#### 2. Presentation Layer
- **責務**: UI表示とユーザーインタラクション
- **配置**:
  - プロバイダー → `providers/`
  - ページ → `pages/`
  - ウィジェット → `widgets/`
  - 状態 → `state/`

#### 3. Service Layer
- **責務**: ビジネスロジック
- **配置**:
  - サービス → `service/`
  - バリデーション → `validators.dart`

### Shared Layer
- **責務**: 全層で共通使用するコンポーネント
- **配置**:
  - 定数 → `constants/`
  - 共通モデル → `data/models/`
  - エラーハンドリング → `error/`
  - 共通UI → `presentation/widgets/`
  - ユーティリティ → `util/`

## 違反例と正しい実装

### ❌ 悪い例: Feature間の直接依存
```dart
// lib/features/feature_a/presentation/pages/page_a.dart
import 'package:flutterhackthema/features/feature_b/data/models/model_b.dart';  // 禁止！
```

### ✅ 良い例: Sharedを経由
```dart
// lib/shared/data/models/common_model.dart
class CommonModel { ... }

// Feature Aから使用
import 'package:flutterhackthema/shared/data/models/common_model.dart';

// Feature Bからも使用可能
import 'package:flutterhackthema/shared/data/models/common_model.dart';
```

## Featureモジュールの作成ガイド

### 1. ディレクトリ作成
```bash
lib/features/{feature_name}/
├── data/
│   ├── models/
│   └── repositories/
├── presentation/
│   ├── providers/
│   ├── pages/
│   ├── widgets/
│   └── state/
└── service/
```

### 2. 命名規則
- Feature名: 単数形または複数形（一貫性を保つ）
- 例: `auth/`, `profile/`, `settings/`

### 3. Import順序
```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. 外部パッケージ
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 4. プロジェクト内 - shared
import 'package:flutterhackthema/shared/constants/app_colors.dart';

// 5. プロジェクト内 - features
import 'package:flutterhackthema/features/auth/data/models/user.dart';

// 6. 相対パス（同一Feature内のみ）
import '../widgets/custom_button.dart';
```

## 状態管理パターン（Riverpod）

### Provider配置ルール
| Provider種類 | 配置場所 |
|------------|---------|
| グローバル | `lib/app/app_di/` |
| Feature固有 | `lib/features/{feature}/presentation/providers/` |
| 共通 | `lib/shared/presentation/providers/` |

### コード生成パターン
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

## ルーティングパターン（go_router）

### ルート定義の配置
- グローバルルート: `lib/app/app_router/`
- Feature固有: `lib/features/{feature}/presentation/routes/`

## ベストプラクティス

### ✅ DO
- Feature間の共通モデルはSharedに配置
- 各Featureを独立してテスト可能にする
- Freezedでイミュータブルなモデルを生成
- コード生成を活用（Riverpod, go_router）

### ❌ DON'T
- Feature間で直接importしない
- SharedからAppやFeatureをimportしない
- グローバル状態を濫用しない
- 複雑な依存関係を作らない

## アーキテクチャ違反のチェック

タスク完了時、以下を確認：
- [ ] Feature間の直接依存がないか
- [ ] Sharedが他の層に依存していないか
- [ ] 一方向依存が守られているか
- [ ] 適切な層に配置されているか
