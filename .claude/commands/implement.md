---
description: Launch implementation phase following the plan
---

# IMPLEMENT Phase

# User Input
#$ARGUMENTS

## Purpose
Implement tasks based on plan.md. Create high-quality code following project guidelines.

## Critical Requirements ⚠️
- **Test-Driven Development**: Write tests first when possible
- **Comprehensive Coverage**: Maintain high test coverage
- **Modular Design**: Maintain App → Feature → Shared dependency flow
- **Tech Stack**: Use hooks_riverpod, go_router, freezed
- **Comments**: Japanese /// comments required for public APIs
- **No Emojis**: Emojis are prohibited in code

## Flutter Project Required Tech Stack
- **State Management**: `hooks_riverpod` (3.0.3) - Required with @riverpod annotation
- **Routing**: `go_router` (16.2.4) - Required
- **Logging**: `logger` (2.6.2) - Required
- **UI Framework**: `flutter_hooks` (0.21.2)
- **Code Generation**:
  - `riverpod_generator` (3.0.3) - Provider generation
  - `freezed` (3.2.3) - Immutable models
  - `json_serializable` (6.11.1) - JSON serialization
  - `go_router_builder` (4.1.0) - Router generation
- **Linting**:
  - `very_good_analysis` (10.0.0)
  - `riverpod_lint` (3.0.3)
  - `custom_lint` (0.8.0)
  - `flutter_lints` (6.0.0)

## Required Input Files
- `docs/plan/plan_{TIMESTAMP}.md` - Implementation plan
- `docs/ARCHITECTURE.md` - Architecture guidelines
- `docs/STYLE_GUIDE.md` - Coding style guide
- GitHub Issues (if any)
- Related existing files and code

## TODO Tasks to Include
1. Understand user instructions and notify implementation start in console
2. Read latest `docs/plan/plan_{TIMESTAMP}.md` file and confirm implementation plan
3. Check current branch and ensure on appropriate branch
4. **Execute Implementation**:
   - Follow architecture guidelines strictly
   - Write tests alongside implementation
   - Maintain comprehensive coverage
5. Flutter-specific implementation:
   - Use HookConsumerWidget (when using hooks)
   - Define Riverpod providers with @riverpod annotation
   - Use go_router patterns for routing
   - Add Japanese /// documentation comments
6. Execute mandatory commands:
   - `fvm flutter pub run build_runner build --delete-conflicting-outputs` (when models change)
   - `fvm flutter analyze` (static analysis)
   - `dart format --set-exit-if-changed .` (formatting)
   - `fvm flutter test` (test execution)
7. Commit and push following Angular conventions (under 50 chars, English)
8. Create or update Draft PR (create on first implementation, update on continuation)
9. Record implementation details in `docs/implement/implement_{TIMESTAMP}.md`
10. Execute `afplay /System/Library/Sounds/Sosumi.aiff` to notify user of implementation completion and file save
11. Output related plan file, implementation detail file, PR number to console

## Flutter Development Rules (Strictly Enforced)
- **Architecture**: `lib/app/`, `lib/features/`, `lib/shared/` structure
- **Dependencies**: App → Feature → Shared (one-way only)
- **Between Features**: Direct dependencies prohibited (only via Shared)
- **Widgets**: Use classes (methods prohibited)
- **Provider Definition**: Use @riverpod annotation with code generation
- **Routing**: Use go_router patterns
- **State Management**: Use hooks_riverpod 3.x patterns

## Branch and Commit Rules
- **Main Branch**: `main`
- **Branch Naming**: Use prefixes like `feature/`, `fix/`, `chore/`
- **Commit Messages**: Angular conventions (under 50 chars, English)
  - `feat:` New features
  - `fix:` Bug fixes
  - `test:` Test additions/modifications
  - `refactor:` Refactoring
  - `docs:` Documentation updates
  - `style:` Format changes
  - `chore:` Build/auxiliary tool changes
- **Granular Commits**: Separate logical changes
- **Draft PR**: Create on first implementation, update on continuation

## Mandatory Test and Quality Check Commands
```bash
# Get dependencies
fvm flutter pub get

# Code generation (when models change)
fvm flutter pub run build_runner build --delete-conflicting-outputs

# Static analysis (mandatory)
fvm flutter analyze

# Format (mandatory)
dart format --set-exit-if-changed .

# Run tests (mandatory)
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage

# Run single test file
fvm flutter test test/path/to/test_file.dart

# Verbose test output
fvm flutter test -v
```

## Flutter-Specific Test Patterns
- **Riverpod Providers**: Test with ProviderContainer
- **HookConsumerWidget**: Test with proper widget test setup
- **go_router**: Use GoRouter test helpers
- **Freezed Models**: Verify copyWith and equality

## Output Files
- `docs/implement/implement_{TIMESTAMP}.md` - Implementation detail record

## Final Output Format
- Must output in one of the following three formats

### Implementation Complete
```
status: SUCCESS
next: TEST
details: "Implementation complete. Comprehensive testing achieved. Details recorded in implement_{TIMESTAMP}.md. Moving to test phase."
```

### Additional Work Required
```
status: NEED_MORE
next: IMPLEMENT
details: "Dependencies or refactoring required. Details recorded in implement_{TIMESTAMP}.md. Continue implementation."
```

### Plan Review Required
```
status: NEED_REPLAN
next: PLAN
details: "Architecture or design changes required. Details recorded in implement_{TIMESTAMP}.md. Return to plan phase."
```
