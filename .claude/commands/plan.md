---
description: Launch planning phase to determine implementation strategy
---

# PLAN Phase

## Purpose
Determine implementation strategy, task breakdown, file change planning, and test strategy for Flutter Hackathon Thema project.

## Required Input Files
- `docs/investigate/investigate_{TIMESTAMP}.md` - Investigation results
- `docs/ARCHITECTURE.md` - Architecture guidelines
- `docs/STYLE_GUIDE.md` - Coding style guide

## Precautions
- Read all related code
- Think thoroughly with ultrathink for all processes
- Treat architecture and style guide as **absolute mandatory requirements**
- Strictly follow architecture constraints (App → Feature → Shared)
- Comprehensive test coverage is mandatory

# User Input
#$ARGUMENTS


## Test Strategy (Comprehensive Coverage)
- **Unit Tests**: Mandatory for all classes and methods (using mockito)
- **Widget Tests**: Mandatory for UI components
- **Integration Tests**: Feature interaction tests
- **Test Execution**: Verify coverage with `fvm flutter test --coverage`

## TODO Tasks to Include
1. Understand user instructions
2. Read latest `docs/investigate/investigate_{TIMESTAMP}.md` and confirm investigation results
3. Verify `docs/ARCHITECTURE.md` and `docs/STYLE_GUIDE.md` requirements
4. Determine implementation strategy based on investigation results
5. Break down detailed implementation tasks and set priorities
6. Create file change plan (new creation, modification, deletion)
   - Consider architecture constraints (App → Feature → Shared)
   - Follow three-layer architecture patterns
7. Establish test strategy (comprehensive coverage)
   - Unit tests (using mockito)
   - Widget tests
   - Integration tests
8. Verify tech stack compatibility
   - hooks_riverpod ^3.0.3 (state management with @riverpod)
   - go_router ^16.2.4 (routing)
   - freezed ^3.2.3 (code generation)
   - very_good_analysis ^10.0.0 (linting)
   - riverpod_lint ^3.0.3 (Riverpod-specific linting)
9. Consider risk analysis and countermeasures
10. Document implementation plan and save to `docs/plan/plan_{TIMESTAMP}.md`
11. Create GitHub Issue if necessary
12. Execute `afplay /System/Library/Sounds/Sosumi.aiff` to notify user of plan completion and file save
13. Output plan file name and created Issue number (if any) to console

## GitHub Issue Creation (If Necessary)
Following Angular commit conventions, create Issue with:
- Title (following Angular commit conventions)
- Overview (user story format)
- Acceptance criteria
- Task list
- Priority and labels

## Output Files
- `docs/plan/plan_{TIMESTAMP}.md`

## Final Output Format
- Must output in one of the following two formats

### Plan Creation Complete
```
status: SUCCESS
next: IMPLEMENT
details: "Flutter implementation plan creation complete. Comprehensive coverage supported. Details recorded in plan_{TIMESTAMP}.md. Moving to implementation phase."
```

### Insufficient Investigation
```
status: NEED_MORE_INFO
next: INVESTIGATE
details: "Insufficient Flutter implementation information. Architecture and tech stack verification required. Details recorded in plan_{TIMESTAMP}.md. Additional investigation needed."
```
