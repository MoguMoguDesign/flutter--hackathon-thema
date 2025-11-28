---
description: Launch investigation phase to understand requirements and constraints
---

# INVESTIGATE Phase

# User Input
#$ARGUMENTS

## Purpose
Understand background, requirements, and constraints to determine implementation direction. Establish implementation strategy that complies with Flutter Hackathon Thema project's three-layer architecture (App → Feature → Shared) and comprehensive test coverage requirements.

## Precautions
- Read all related code
- Think thoroughly with ultrathink for all processes
- Do not use emojis in file descriptions
- Strictly follow three-layer architecture dependencies (App → Feature → Shared)
- Keep in mind that direct dependencies between Features are prohibited
- Assume use of hooks_riverpod, go_router, freezed

## Flutter Hackathon Thema-Specific Investigation Points
- Consistency with existing Feature module structure
- Riverpod provider placement and patterns (@riverpod annotation)
- go_router routing patterns
- Freezed model structure
- Existing test patterns
- Japanese comment requirements for public APIs

## TODO Tasks to Include
1. Clarify investigation scope and targets
2. Check current branch status and create `feature/<topic>` branch (from main branch)
3. Collect and systematically analyze related Flutter/Dart files, tests, and documentation
4. Investigate compliance with three-layer architecture
5. Verify consistency with existing Feature module patterns
6. Investigate Riverpod state management patterns (v3.x with @riverpod)
7. Consider test strategy (comprehensive coverage achievement method)
8. Evaluate impact on existing codebase
9. Identify root causes and solution approaches
10. Document investigation results and save to `docs/investigate/investigate_{TIMESTAMP}.md`
11. Present recommendations for next phase (Plan)
12. Execute `afplay /System/Library/Sounds/Sosumi.aiff` to notify user of investigation completion and file save
13. Output created branch name and investigation result file name to console

## Branch Creation Rules
- Branch naming: `feature/<topic>` or `fix/<issue>`
- Must create from `main` branch (Flutter Hackathon Thema's main branch)
- Continue all work on that branch after creation

## Mandatory Verification Commands
```bash
# Check dependencies
fvm flutter pub get

# Static analysis
fvm flutter analyze

# Test execution
fvm flutter test

# Code format check
dart format --set-exit-if-changed .
```

## Architecture Verification Items
- App layer: Routing (go_router), DI (Riverpod), global settings
- Feature layer: Independent feature modules (data/presentation/service structure)
- Shared layer: Common components
- Correct dependency direction (App → Feature → Shared)
- No direct dependencies between Features

## Output Files
- `docs/investigate/investigate_{TIMESTAMP}.md`

## Final Output Format
- Must output in one of the following two formats

### Investigation Complete (Implementation Recommended)
```
status: COMPLETED
next: PLAN
branch: feature/<topic>
architecture_layer: [App|Feature|Shared]
test_coverage_required: comprehensive
details: "Investigation complete. feature/<topic> branch created. Details in docs/investigate/investigate_{TIMESTAMP}.md. Implementation strategy recommended."
```

### Investigation Complete (Implementation Not Required)
```
status: COMPLETED
next: NONE
details: "Investigation complete. Details in docs/investigate/investigate_{TIMESTAMP}.md. Can be handled with existing features. No implementation/changes required."
```
