---
description: Launch github-commit-agent to create proper git commits following project standards
---

Use the Task tool with subagent_type='github-commit-agent' to help with creating git commits.

The github-commit-agent agent specializes in:
- Angular-style commit messages
- Reviewing staged and unstaged changes
- Proper file staging
- Following commit conventions
- Adding co-authored-by information

Example usage:
- "変更をコミットして"
- "この機能の実装をコミットしたい"
- "適切なコミットメッセージで保存して"

The agent will:
1. Check git status and diff
2. Review recent commit messages for consistency
3. Create a descriptive commit message
4. Stage appropriate files
5. Create the commit with proper format
