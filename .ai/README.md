# AI Development Rules Enforcement

This directory contains tools to ensure CLAUDE.md rules are followed during AI-assisted development.

## Overview

Based on the approach from [this article](https://zenn.dev/cypher256/articles/a0342b5dadcb4c), this system enforces project-specific rules to maintain code quality and consistency.

## Components

### 1. Header Template (`dart_header_template.txt`)
- Mandatory header for all Dart files
- Contains project rules and metadata
- Prevents accidental file deletion

### 2. Project Files Tracker (`project_files.json`)
- Maintains list of all Dart files in the project
- Used for validation and tracking
- Auto-generated, excluded from version control

### 3. Rules Checker (`check_claude_rules.py`)
- Validates all Dart files against CLAUDE.md rules
- Checks for:
  - Required header presence
  - Provider patterns (@riverpod annotation)
  - Widget patterns (classes not methods)
  - Documentation in Japanese
  - No cross-feature dependencies
  - Test coverage ≥80% (excluding auto-generated files)

### 4. Pre-commit Hook (`.githooks/pre-commit`)
- Runs automatically before each commit
- Blocks commits that violate rules
- Ensures code quality standards

## Usage

### Manual Check
```bash
python3 .ai/check_claude_rules.py
```

### Enable Git Hooks
```bash
git config core.hooksPath .githooks
```

### Update Project Files List
```bash
find lib -name "*.dart" -type f | jq -R -s -c 'split("\n") | map(select(length > 0))' > .ai/project_files.json
```

## Integration

- **Local Development**: Pre-commit hooks enforce rules
- **CI/CD**: GitHub Actions runs compliance checks
- **AI Development**: Rules prevent common AI mistakes

## Benefits

1. **Consistency**: All code follows the same standards
2. **Quality**: Prevents common mistakes and anti-patterns
3. **Documentation**: Enforces proper documentation practices
4. **Architecture**: Maintains clean three-layer architecture boundaries
5. **Testing**: Ensures ≥80% test coverage (auto-generated files excluded)

## Troubleshooting

If commits are blocked:
1. Run `python3 .ai/check_claude_rules.py` to see violations
2. Fix the reported issues
3. Try committing again

For more details, see CLAUDE.md in the project root.
