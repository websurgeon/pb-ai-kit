---
name: refactor
description: Standalone refactor — cleans code without behaviour changes, verifies with tests, then commits
argument-hint: "<file-path> [file-path ...]"
allowed-tools: Bash, Read, Agent
---

Run a standalone refactor workflow for `$ARGUMENTS`.

1. Run `.ai/scripts/run_tests.sh` to confirm tests are currently green. If they fail — stop and report; do not proceed.
2. Read `.ai/agents/specialists/SPEC_REFACTOR.md` for the specialist role.
3. Read `.ai/platforms/claude-code/SUBAGENT_PATTERNS.md` for invocation patterns.
4. Determine target side: production code or test code — never both in one cycle (One-Side Rule). If `$ARGUMENTS` mixes both sides, ask which to do first.
5. Spawn a `general-purpose` agent as SPEC_REFACTOR:
   - **ROLE** — SPEC_REFACTOR.md content
   - **CONTEXT** — file path(s), confirmation tests pass, which side (production/test)
   - **TASK** — refactor the listed files; return file paths modified and one-line description per file
6. Run `.ai/scripts/run_tests.sh` again to confirm no regressions.
7. If green → ask for JIRA ticket if not known, then run the commit workflow.
8. If red → report which tests broke; do not commit.
