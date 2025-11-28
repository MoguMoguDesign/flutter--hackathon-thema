# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**Flutter Hackathon Thema** is a modular Flutter application built with a three-layer architecture (App → Feature → Shared). The architecture enforces clear separation of concerns and unidirectional dependencies for maximum maintainability and scalability.

### Tech Stack

- **Flutter SDK**: >=3.24.0 (managed via FVM)
- **Dart**: >=3.9.0
- **State Management**: hooks_riverpod 3.x with @riverpod annotation
- **Routing**: go_router 16.x
- **Code Generation**: build_runner, riverpod_generator, freezed, json_serializable
- **Static Analysis**: very_good_analysis 10.x, riverpod_lint 3.x

---

## Essential Commands

### Development Setup

```bash
# Install FVM Flutter version
fvm install

# Use FVM-managed Flutter
fvm use

# Install dependencies
fvm flutter pub get

# Initial code generation
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### Development Workflow

```bash
# Code generation (watch mode - recommended during development)
fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Run static analysis
fvm flutter analyze

# Format code
dart format --set-exit-if-changed .

# Run all tests
fvm flutter test

# Run specific test file
fvm flutter test test/features/auth/data/repositories/auth_repository_test.dart

# Run app
fvm flutter run
```

### Build Commands

```bash
# Android APK
fvm flutter build apk

# iOS
fvm flutter build ios

# Web
fvm flutter build web
```

### Troubleshooting

```bash
# Clean and regenerate everything
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Three-Layer Architecture

The project follows a strict three-layer architecture with unidirectional dependencies:

```
App Layer (アプリ層)
  ↓ depends on
Feature Layer (機能層)
  ↓ depends on
Shared Layer (共有層)
```

### Critical Dependency Rules

1. **✅ ALLOWED**: App → Feature, App → Shared
2. **✅ ALLOWED**: Feature → Shared
3. **❌ FORBIDDEN**: Feature → Feature (direct dependencies between features)
4. **❌ FORBIDDEN**: Shared → Feature or Shared → App
5. **❌ FORBIDDEN**: Any circular dependencies

### Layer Responsibilities

**App Layer** (`lib/app/`)
- Global routing configuration (go_router)
- Dependency injection setup (Riverpod)
- Route guards and authentication checks
- App-wide widgets (AppBar, Navigation)

**Feature Layer** (`lib/features/`)
- Independent, self-contained feature modules
- Each feature has: data/, presentation/, service/
- Business logic specific to the feature
- Feature-specific state management

**Shared Layer** (`lib/shared/`)
- Common UI components (buttons, cards, dialogs)
- Utilities and helper functions
- Constants (colors, spacing, text styles)
- Common models (Result types, base models)
- Error handling infrastructure

---

## Feature Module Structure

Each feature follows this consistent structure:

```
features/
└── example_feature/
    ├── data/                      # Data Layer
    │   ├── models/                # Data models with Freezed
    │   │   ├── example_model.dart
    │   │   ├── example_model.freezed.dart  # Generated
    │   │   └── example_model.g.dart        # Generated
    │   └── repositories/          # Data access logic
    │       ├── example_repository.dart
    │       └── example_repository.g.dart   # Generated
    │
    ├── presentation/              # Presentation Layer
    │   ├── providers/             # Riverpod providers (@riverpod)
    │   │   ├── example_provider.dart
    │   │   └── example_provider.g.dart     # Generated
    │   ├── state/                 # State classes (Freezed)
    │   │   ├── example_state.dart
    │   │   └── example_state.freezed.dart  # Generated
    │   ├── pages/                 # Full screen pages
    │   │   └── example_page.dart
    │   └── widgets/               # Reusable UI components
    │       ├── example_widget_a.dart
    │       └── example_widget_b.dart
    │
    └── service/                   # Service Layer
        ├── example_service.dart   # Business logic
        └── example_validator.dart # Validation logic
```

---

## State Management with Riverpod 3.x

### Provider Pattern

Always use the modern `@riverpod` annotation pattern with code generation:

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
    // Implementation
  }
}
```

### State Classes with Freezed

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

### Provider Placement

- **Global providers**: `lib/app/app_di/`
- **Feature providers**: `lib/features/{feature}/presentation/providers/`
- **Shared providers**: `lib/shared/presentation/providers/`

---

## Routing with go_router 16.x

- Global routes: `lib/app/app_router/`
- Feature routes: `lib/features/{feature}/presentation/routes/`
- Use type-safe routing with go_router_builder when possible
- Implement route guards in `lib/app/route_guard/`

---

## Coding Standards

### Naming Conventions

- **Files**: `snake_case` (e.g., `auth_repository.dart`)
- **Classes**: `PascalCase` (e.g., `AuthRepository`)
- **Variables/Functions**: `lowerCamelCase` (e.g., `getUserData()`)
- **Constants**: `lowerCamelCase` (e.g., `primaryColor`)
- **Private members**: Prefix with `_` (e.g., `_privateMethod()`)
- **Booleans**: Start with `is`, `has`, `can`, `should` (e.g., `isLoggedIn`)

### Import Order

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. External packages (alphabetical)
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 4. Project - shared layer
import 'package:flutterhackthema/shared/constants/app_colors.dart';

// 5. Project - features
import 'package:flutterhackthema/features/auth/data/models/user.dart';

// 6. Relative imports (same feature only)
import '../widgets/custom_button.dart';
```

### Required Practices

1. **Explicit types**: Avoid `var`, always specify types
2. **const everywhere**: Use `const` constructors when possible for performance
3. **Documentation**: Public APIs must have `///` doc comments in Japanese
4. **Static analysis**: Code must pass `fvm flutter analyze` with zero errors
5. **Formatting**: Use `dart format` before committing
6. **Magic numbers**: Define constants in `lib/shared/constants/`

### Prohibited Practices

- ❌ Using `dynamic` type
- ❌ Using `print()` (use Logger instead)
- ❌ Code duplication (follow DRY principle)
- ❌ Long functions (>100 lines - split into smaller functions)
- ❌ Feature-to-Feature imports (use Shared layer)

---

## Testing Strategy

### Test Structure

Tests mirror the source structure:

```
lib/features/auth/data/repositories/auth_repository.dart
↓
test/features/auth/data/repositories/auth_repository_test.dart
```

### Test Types

- **Unit tests**: Required for all business logic and data layers
- **Widget tests**: Required for all presentation layer components
- **Integration tests**: Optional but recommended for critical flows

### Running Tests

```bash
# All tests
fvm flutter test

# Specific test file
fvm flutter test test/features/auth/auth_test.dart

# With coverage
fvm flutter test --coverage
```

---

## 4-Phase Development Workflow

The project uses a systematic 4-phase workflow. Each phase has a dedicated slash command:

### 1. INVESTIGATE Phase (`/investigate`)

**Purpose**: Understand requirements, constraints, and existing codebase patterns

**Tasks**:
- Clarify requirements and background
- Analyze existing code and architecture compliance
- Verify three-layer architecture adherence
- Check Riverpod provider patterns
- Identify test patterns
- Create `feature/<topic>` branch
- Output: `docs/investigate/investigate_{TIMESTAMP}.md`

### 2. PLAN Phase (`/plan`)

**Purpose**: Create detailed implementation strategy

**Tasks**:
- Design implementation approach
- Break down into specific tasks
- Plan file changes (create/modify/delete)
- Define test strategy (unit/widget/integration)
- Risk analysis and mitigation
- Output: `docs/plan/plan_{TIMESTAMP}.md`

### 3. IMPLEMENT Phase (`/implement`)

**Purpose**: Execute the plan with high-quality code

**Tasks**:
- Implement according to plan
- Follow architecture guidelines strictly
- Write tests (unit + widget minimum)
- Run required commands:
  - `fvm flutter pub run build_runner build --delete-conflicting-outputs`
  - `fvm flutter analyze`
  - `dart format --set-exit-if-changed .`
  - `fvm flutter test`
- Create Angular-style commits
- Create/update Draft PR
- Output: `docs/implement/implement_{TIMESTAMP}.md`

### 4. TEST Phase (`/test`)

**Purpose**: Comprehensive quality verification

**Tasks**:
- Run all tests (unit/widget/integration)
- Verify test coverage
- Validate static analysis
- Confirm code formatting
- Output: `docs/test/test_{TIMESTAMP}.md`

### Workflow Pattern

```
INVESTIGATE → PLAN → IMPLEMENT → TEST
                ↑         ↑         ↓
                └─────────┴────[if fixes needed]
```

---

## Git & GitHub Workflow

### Commit Message Format

Use Angular-style commit messages:

```bash
# New feature
git commit -m "feat(auth): ログイン機能を追加"

# Bug fix
git commit -m "fix(profile): ユーザー名表示のバグを修正"

# Documentation
git commit -m "docs: README を更新"

# Refactoring
git commit -m "refactor(shared): ボタンコンポーネントを改善"

# Tests
git commit -m "test(auth): 認証テストを追加"

# Chore
git commit -m "chore: 依存関係を更新"
```

### Branch Strategy

- Main branch: `main`
- Feature branches: `feature/<topic>`
- Fix branches: `fix/<issue>`
- Always create branches from `main`

### Available Slash Commands

- `/commit` - Create proper Angular-style commits
- `/pr` - Create pull requests
- `/issue` - Create GitHub issues
- `/component` - Flutter component specialist
- `/state` - Riverpod state management expert
- `/router` - go_router navigation expert
- `/agents` - List all available agents

---

## Code Generation Best Practices

### When to Regenerate

Run code generation after:
- Creating/modifying Riverpod providers with `@riverpod`
- Creating/modifying Freezed models with `@freezed`
- Creating/modifying JSON serializable classes
- Adding go_router route configurations

### Watch Mode During Development

```bash
# Recommended: Auto-regenerate on file changes
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

### One-Time Generation

```bash
# For final builds or CI/CD
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Important Project Specifics

### FVM Usage

- **Always** use `fvm` prefix for Flutter commands
- FVM config: `.fvmrc` specifies `stable` channel
- Ensures team uses consistent Flutter version

### Japanese Documentation

- Public API documentation should be in Japanese (`///` comments)
- Internal comments can be in English or Japanese
- User-facing text should be in Japanese

### Architecture Compliance

Before implementing any feature:
1. Verify layer placement (App/Feature/Shared)
2. Check dependency direction (no Feature → Feature)
3. Confirm shared components are truly shared
4. Use existing patterns from similar features

### Common Patterns to Follow

When creating new features, examine existing patterns in:
- Provider structure (`@riverpod` annotation usage)
- State management (Freezed state classes)
- Widget composition (StatelessWidget with ConsumerWidget)
- Repository patterns (data access abstraction)
- Test structure (matching source structure)

---

## Key Documentation Files

- `docs/ARCHITECTURE.md` - Detailed three-layer architecture explanation
- `docs/STYLE_GUIDE.md` - Comprehensive coding style guide
- `.claude/commands/README.md` - Slash command usage guide
- `.claude/agents/README.md` - Specialized agent descriptions

---

## Quality Gates

Every implementation must pass these checks:

1. ✅ `fvm flutter analyze` - No static analysis errors
2. ✅ `dart format --set-exit-if-changed .` - Properly formatted
3. ✅ `fvm flutter test` - All tests passing
4. ✅ Code generation complete - All `.g.dart` and `.freezed.dart` files up-to-date
5. ✅ Architecture compliance - Three-layer rules followed
6. ✅ Documentation complete - Public APIs documented in Japanese

Never skip these quality gates to "make it work faster" - they ensure long-term maintainability.
