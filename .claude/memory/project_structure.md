# Project Structure Memory

**Created**: 2025-11-29
**Updated by**: Issue #8 Implementation
**Branch**: feature/project-structure-setup

## Three-Layer Architecture

This project follows a strict three-layer architecture with unidirectional dependencies:

```
App Layer (lib/app/)
  ↓ depends on
Feature Layer (lib/features/)
  ↓ depends on
Shared Layer (lib/shared/)
```

## Directory Structure

### App Layer (`lib/app/`)

Global application configuration and routing:

- `app_di/` - Dependency injection with Riverpod providers
- `app_router/` - go_router configuration with TypedGoRoute
- `route_guard/` - Route guards (e.g., nickname authentication)
- `widgets/` - App-wide widgets and placeholder pages

### Feature Layer (`lib/features/`)

Independent, self-contained feature modules:

#### Nickname Feature (`lib/features/nickname/`)
- `data/models/` - Nickname data models
- `data/repositories/` - Nickname data repositories
- `presentation/providers/` - Riverpod providers for nickname state
- `presentation/pages/` - Nickname pages
- `presentation/widgets/` - Nickname-specific widgets
- `presentation/state/` - Freezed state classes
- `service/` - Business logic and validation

#### Posts Feature (`lib/features/posts/`)
- Same structure as nickname feature
- Handles posts list functionality

#### Post Creation Feature (`lib/features/post_creation/`)
- Same structure as nickname feature
- Handles post creation and preview

### Shared Layer (`lib/shared/`)

Common resources used across features:

- `constants/` - **AppColors**, **AppGradients**, **AppTextStyles**
  - Moved from `lib/src/constants/` (Issue #8)
  - 3 files: app_colors.dart, app_gradients.dart, app_text_styles.dart
- `widgets/` - Shared UI components (buttons, cards, dialogs)
- `models/` - Shared data models
- `util/` - Utility functions and helpers
- `data/models/` - Common data models
- `error/` - Error handling infrastructure
- `service/` - Shared services
- `presentation/pages/` - Common pages (e.g., ErrorPage)

### Test Structure (`test/`)

Tests mirror the production structure:

```
test/
├── app/
│   ├── route_guard/
│   └── app_router/
├── features/
│   ├── nickname/
│   ├── posts/
│   └── post_creation/
└── shared/
    ├── constants/
    ├── widgets/
    ├── models/
    └── presentation/pages/
```

## Dependency Rules

### ✅ ALLOWED

1. App → Feature (e.g., app router can use feature pages)
2. App → Shared (e.g., app can use shared constants)
3. Feature → Shared (e.g., feature can use shared widgets)

### ❌ FORBIDDEN

1. Feature → Feature (direct dependencies between features)
2. Shared → Feature (shared layer cannot depend on features)
3. Shared → App (shared layer cannot depend on app)
4. Any circular dependencies

## Key Files

### Constants (lib/shared/constants/)

**app_colors.dart** (187 lines)
- Complete color palette for user/admin themes
- Pure white, primary colors, text colors, etc.

**app_gradients.dart** (111 lines)
- BackgroundGradientTheme extension
- User and admin gradient themes

**app_text_styles.dart** (73 lines)
- Typography using Google Fonts (M PLUS 1p)
- Headline, label, and body text styles

### Export File (lib/base_ui.dart)

Central export for shared UI resources:
```dart
export 'shared/constants/app_colors.dart';
export 'shared/constants/app_gradients.dart';
export 'shared/constants/app_text_styles.dart';
```

## Migration Notes

### Issue #8 Changes

1. Created directory structure for all three layers
2. Moved constants from `lib/src/constants/` to `lib/shared/constants/`
3. Updated 7 files with import changes:
   - lib/base_ui.dart
   - lib/shared/presentation/pages/error_page.dart
   - lib/app/widgets/pages/placeholder_nickname_page.dart
   - lib/app/widgets/pages/placeholder_posts_page.dart
   - lib/app/widgets/pages/placeholder_create_post_page.dart
   - lib/app/widgets/pages/placeholder_preview_page.dart
   - lib/shared/constants/app_text_styles.dart (relative import)
4. Created .gitkeep files in 27 empty directories
5. Removed empty `lib/src/` directory

### Future Migrations

Placeholder pages will be migrated in subsequent issues:

| Current Location | Target Location | Issue |
|-----------------|-----------------|-------|
| lib/app/widgets/pages/placeholder_nickname_page.dart | lib/features/nickname/presentation/pages/nickname_page.dart | #10 |
| lib/app/widgets/pages/placeholder_posts_page.dart | lib/features/posts/presentation/pages/posts_page.dart | #12 |
| lib/app/widgets/pages/placeholder_create_post_page.dart | lib/features/post_creation/presentation/pages/create_post_page.dart | #13 |
| lib/app/widgets/pages/placeholder_preview_page.dart | lib/features/post_creation/presentation/pages/preview_page.dart | #15 |

## Code Patterns

### Riverpod Providers

Use @riverpod annotation with code generation:
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'provider_name.g.dart';

@riverpod
class Example extends _$Example {
  @override
  ExampleState build() {
    return const ExampleState.initial();
  }
}
```

### State Classes

Use Freezed for immutable state:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'state_name.freezed.dart';

@freezed
class ExampleState with _$ExampleState {
  const factory ExampleState.initial() = _Initial;
  const factory ExampleState.loading() = _Loading;
  const factory ExampleState.success(Data data) = _Success;
  const factory ExampleState.error(String message) = _Error;
}
```

### Routing

Use go_router with TypedGoRoute:
```dart
@TypedGoRoute<ExampleRoute>(path: '/example')
class ExampleRoute extends GoRouteData {
  const ExampleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ExamplePage();
  }
}
```

## Important Reminders

1. **Always** verify layer placement before creating new files
2. **Never** create direct Feature → Feature dependencies
3. **Always** use shared layer for cross-feature components
4. **Always** follow naming conventions (snake_case for files)
5. **Always** add Japanese documentation for public APIs
6. **Always** run code generation after changes:
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```
7. **Always** verify with static analysis:
   ```bash
   fvm flutter analyze
   ```

## Quick Reference

### Finding Components

**Colors**: `lib/shared/constants/app_colors.dart`
**Text Styles**: `lib/shared/constants/app_text_styles.dart`
**Gradients**: `lib/shared/constants/app_gradients.dart`
**Error Page**: `lib/shared/presentation/pages/error_page.dart`
**Routes**: `lib/app/app_router/routes.dart`
**DI Setup**: `lib/app/app_di/`

### Common Commands

```bash
# Development
fvm flutter pub run build_runner watch --delete-conflicting-outputs
fvm flutter analyze
fvm flutter test
fvm flutter run

# Build
fvm flutter build apk
fvm flutter build ios
fvm flutter build web
```
