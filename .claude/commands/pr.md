---
description: Launch github-pr-creator agent to create GitHub pull requests
---

Use the Task tool with subagent_type='github-pr-creator' to help with creating GitHub pull requests.

The github-pr-creator agent specializes in:
- Creating well-formatted pull requests
- Using PR templates
- Writing clear summaries
- Including test plans
- Following project PR guidelines

Example usage:
- "この機能のPRを作成して"
- "main ブランチへのプルリクエストを作って"
- "変更をレビュー依頼したい"

The agent will:
1. Check git status and branch
2. Review all changes since branch diverged
3. Push changes if needed
4. Create PR with proper title and description
5. Include test plan and checklist
