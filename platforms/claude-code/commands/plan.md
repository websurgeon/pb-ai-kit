---
name: plan
description: Pre-flight ticket planning — break work into TDD/SKIP-RED steps with [COMMIT] gate markers before any code is written
argument-hint: "[JIRA-ticket]"
allowed-tools: Bash, Read
---

Run pre-flight planning for `$ARGUMENTS`. If empty, infer the ticket from the current branch name.

**Steps:**
1. Read `.ai/project/PROJECT_SPECIFIC_DETAILS.md` for framework context.
2. If `WIP.md` exists at repo root, read it for "Done when" criteria. If not, infer scope from `git log --oneline` on the current branch vs main.
3. Break the ticket into discrete implementation steps. For each step, classify:
   - `[TDD]` — has testable behaviour → full RED → GREEN → REFACTOR cycle
   - `[SKIP-RED]` — no meaningful assertion possible (e.g. interface field addition, DI registration, defensive guard with no triggerable failure path) → implement directly; state reason explicitly
   - Be conservative: if unsure, use `[TDD]`
4. Group tightly-coupled steps under one `[COMMIT]` gate. Independent concerns get separate gates.
5. Present the plan and wait for feedback before any coding begins.

**Output format:**
```
# Plan: <JIRA-ticket>

## Steps

### 1. <title> [TDD | SKIP-RED]
<one-line description of what changes>
Reason: <why this classification>

### 2. <title> [TDD]
...

[COMMIT] <what this group of changes represents>

### 3. <title> [TDD]
...

[COMMIT] <what this group of changes represents>
```

**The plan is the source of truth for commit timing** — when execution reaches a `[COMMIT]` marker, stop, propose the commit, and wait for approval before continuing.
