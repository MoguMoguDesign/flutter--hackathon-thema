---
description: Launch testing phase to verify implementation quality
---

# TEST Phase

# User Input
#$ARGUMENTS

## Purpose
Execute comprehensive functional verification of added/modified code in Flutter environment.

## Test Execution Policy
- **Test-Driven Development**: Test-first approach is recommended
- **Comprehensive Test Coverage**: Maintain high test coverage
- **Quality Focus**: Ensure all functionality works as expected

## Required Input Files
- `docs/plan/plan_{TIMESTAMP}.md` - Test requirements verification
- `docs/implement/implement_{TIMESTAMP}.md` - Implementation details
- Implemented code (current branch)

## Test Types
- **Unit Tests (Mandatory)**
  - Unit tests for all classes and methods
  - Mock creation using `mockito`
  - Comprehensive test coverage
  - Verification with `fvm flutter test --coverage`
- **Widget Tests (Mandatory)**
  - Rendering and interaction tests for UI components
  - Widget verification using `testWidgets`
  - User interaction tests
- **Integration Tests (Optional)**
  - Interaction tests between multiple components
  - Execution with `fvm flutter test integration_test/`


## TODO Tasks to Include
1. Understand user instructions and notify test start in console
2. Verify test requirements from latest `docs/plan/plan_{TIMESTAMP}.md`
3. Verify implementation details from latest `docs/implement/implement_{TIMESTAMP}.md`
4. Notify user of dependency verification (`fvm flutter pub get`)
5. Execute code generation (`fvm flutter pub run build_runner build`)
6. Create test cases for added/modified features (if not already done)
7. Execute unit tests (`fvm flutter test`)
8. Execute widget tests (if applicable)
9. Verify test coverage (`fvm flutter test --coverage`)
10. Execute static analysis (`fvm flutter analyze`)
11. Verify code format (`dart format --set-exit-if-changed .`)
12. Notify user in real-time of test execution status
13. Report details to user if any tests fail
14. Comprehensively evaluate and document test results
15. Save test results in `docs/test/test_{TIMESTAMP}.md`
16. Notify user of test completion and file save
17. Output next phase transition decision to console


## Output Files
- `docs/test/test_{TIMESTAMP}.md`

## Final Output Format
- Must output in one of the following three formats

### Test Success
```
status: SUCCESS
next: DONE
details: "All tests passed. Details recorded in test_{TIMESTAMP}.md."
```

### Test Failure - Fixes Required
```
status: FAILURE
next: IMPLEMENT
details: "Failure: Test coverage below target. Check test_{TIMESTAMP}.md for details. Fixes required."
```

### Critical Issue Discovered
```
status: CRITICAL_FAILURE
next: INVESTIGATE
details: "Critical issue discovered: Architecture violation detected. test_{TIMESTAMP}.md. Root cause re-investigation required."
```
