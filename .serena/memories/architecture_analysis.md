# Architecture Migration Plan: Privastor Reference

## Current State (flutter--hackathon-thema)

### Directory Structure
```
lib/
├── main.dart
├── base_ui.dart
├── gourmet_ui.dart
└── src/
    ├── component_test_page.dart
    ├── home_page.dart
    ├── constants/ (app_colors, app_gradients, app_text_styles)
    ├── models/ (ranking)
    ├── widgets/ (20+ widget files)
    └── gourmet/
        ├── constants/
        └── widgets/
```

### Current Tech Stack
- No state management
- Basic MaterialApp routing
- No code generation
- Minimal dependencies (google_fonts, flutter_svg, flutter_hooks, gap)
- Basic linting (flutter_lints)

## Target State (Privastor Architecture)

### Directory Structure
```
lib/
├── main.dart (or main_prod.dart for flavors)
├── app/
│   ├── app_router/ (go_router configuration)
│   ├── app_di/ (dependency injection)
│   ├── widgets/ (shared app widgets)
│   └── route_guard/ (auth guards)
└── features/
    └── [feature_name]/
        ├── data/
        │   ├── data_source/ (API/Firebase calls)
        │   └── repository/ (data abstractions)
        ├── presentation/
        │   ├── pages/ (screens)
        │   ├── providers/ (Riverpod state)
        │   └── widgets/ (feature-specific widgets)
        └── util/ (feature utilities)
```

### Target Tech Stack
- **State Management**: hooks_riverpod + riverpod_annotation
- **Routing**: go_router + go_router_builder
- **Code Generation**: build_runner, freezed, json_serializable, riverpod_generator
- **Testing**: patrol, mockito, bdd_framework
- **Linting**: very_good_analysis, riverpod_lint, custom_lint

## Feature Identification

### Current Features in Project

#### TCG Match Manager
- **Tournament**: TournamentTitleCard, TournamentInfoCard
- **Match**: MatchCard, MatchList, MatchRow, MatchStatusContainer
- **Player**: PlayerContainer, PlayersContainer
- **Ranking**: RankingCard, RankingContainer, RankingRow
- **Shared Widgets**: Buttons, Dialogs, TextFields, VSContainer

#### My Gourmet
- **Gourmet**: GuruMemoCard, AppDialog, AppElevatedButton, AppSnackBar

### Proposed Feature Structure

```
lib/
├── main.dart
├── app/
│   ├── app_router/
│   │   ├── app_router.dart (main router config)
│   │   ├── tcg_routes.dart (TCG routes)
│   │   └── gourmet_routes.dart (Gourmet routes)
│   └── widgets/
│       └── navigation/ (bottom nav, etc.)
└── features/
    ├── tcg/
    │   ├── tournament/
    │   │   ├── presentation/
    │   │   │   ├── pages/ (tournament_page.dart)
    │   │   │   ├── providers/ (tournament_provider.dart)
    │   │   │   └── widgets/ (tournament_title_card.dart, tournament_info_card.dart)
    │   ├── match/
    │   │   ├── presentation/
    │   │   │   ├── pages/ (match_list_page.dart)
    │   │   │   ├── providers/ (match_provider.dart)
    │   │   │   └── widgets/ (match_card.dart, match_list.dart, etc.)
    │   ├── player/
    │   │   └── presentation/
    │   │       └── widgets/ (player_container.dart, etc.)
    │   ├── ranking/
    │   │   └── presentation/
    │   │       ├── pages/ (ranking_page.dart)
    │   │       └── widgets/ (ranking_card.dart, etc.)
    │   └── shared/
    │       ├── constants/ (app_colors, app_text_styles, app_gradients)
    │       └── widgets/ (common buttons, dialogs, text_fields)
    └── gourmet/
        └── presentation/
            ├── pages/ (gourmet_component_test_page.dart)
            ├── constants/ (themes, constants)
            └── widgets/ (guru_memo_card, etc.)
```

## Migration Steps

### Phase 1: Foundation Setup
1. Update pubspec.yaml with new dependencies
2. Add analysis_options.yaml with very_good_analysis
3. Add build.yaml for code generation
4. Create directory structure

### Phase 2: Feature Migration
1. Identify features from current widgets
2. Create feature directories
3. Migrate widgets to feature-based structure
4. Convert constants to shared resources

### Phase 3: State Management
1. Setup ProviderScope in main.dart
2. Create providers for existing state
3. Convert StatefulWidgets to HookConsumerWidget

### Phase 4: Routing
1. Setup go_router configuration
2. Define route structure
3. Migrate from MaterialApp to MaterialApp.router
4. Add route guards if needed

### Phase 5: Code Generation
1. Add freezed models
2. Setup riverpod_generator
3. Run build_runner
4. Update imports

## Key Architectural Principles from Privastor

1. **Feature-First Organization**: Each feature is self-contained
2. **Clean Architecture**: Data → Domain → Presentation layers
3. **Code Generation**: Minimize boilerplate with generators
4. **Type Safety**: Use go_router_builder for type-safe navigation
5. **Immutability**: Use freezed for immutable state
6. **Testing**: 100% coverage requirement
7. **Strict Linting**: very_good_analysis + custom rules
