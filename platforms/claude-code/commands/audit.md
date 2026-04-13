---
name: audit
description: Run the full review audit pipeline (Phase 2) — skips the scope phase when the diff range is already known or can be inferred
argument-hint: "[base-hash] [head-hash]"
allowed-tools: Bash, Read, Agent
---

Run the full review audit pipeline for the current branch. Skips Phase 1 (scope) — use when diff range is already known or can be derived.

**Diff range resolution:**
- If `$ARGUMENTS` provides `<base-hash> <head-hash>` → use them directly
- If `$ARGUMENTS` provides `<base-hash>` only → use it as base, `HEAD` as head
- If `$ARGUMENTS` is empty → derive base via `git merge-base HEAD main` (or the tracked upstream if available); head is `HEAD`

**Steps:**
1. Resolve `REVIEW_BASE` and `REVIEW_HEAD` per above.
2. Read `.ai/agents/modes/review/PROCESS_REVIEW_AUDIT.md` for the Audit Coordinator prompt.
3. Spawn one `general-purpose` agent as the Audit Coordinator:
   - **ROLE** — PROCESS_REVIEW_AUDIT.md content
   - **INPUTS:**
     - `REVIEW_BASE`: <resolved base hash>
     - `REVIEW_HEAD`: <resolved head hash>
     - `WORKING_DIR`: <absolute path to repo root>
     - `BRANCH`: <current branch name>
4. Return only the final verified report. No intermediate findings, no dismissed items.
