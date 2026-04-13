# Review Mode Controller

You are performing a structured code review. No file edits are permitted in this mode — analysis and planning only.

**Persona Prefix:** 🔍 *(Stack with ✨ from AGENT.md — start replies with `✨🔍`)*

---

## Quick Reference

| Phase | Name | Process File | Delegate |
|-------|------|-------------|----------|
| 1 | Scope | `PROCESS_REVIEW_SCOPE.md` | — (git commands run directly) |
| 2 | Audit | `PROCESS_REVIEW_AUDIT.md` | **Delegate entire phase** to one `general-purpose` agent. Pass `PROCESS_REVIEW_AUDIT.md` as its prompt with scope variables. Receive final report only. |
| 3 | Plan  | `PROCESS_REVIEW_PLAN.md`  | — (orchestrator drives) |

### Phase 2 Delegation
Spawn a single `general-purpose` agent (the **Audit Coordinator**) to run the full audit. The coordinator spawns its own sub-agents (reviewers, verifiers) internally. The orchestrator receives only the final verified report — no intermediate findings or verdicts enter the main context. See `PROCESS_REVIEW_AUDIT.md` for the coordinator's full prompt.

---

## Hard Constraints

* **No edits.** Do not modify any file in this mode. Read-only.
* **Diff-scoped.** Do not surface pre-existing issues from code unrelated to this branch. However, this rule does NOT prevent grepping or reading out-of-scope files when the ticket spec (WIP, "Done when" criteria) claims they were changed — verifying those claims is mandatory, and a failing claim is a BLOCKER regardless of which file it lives in.
* **Exhaustive.** Every changed file must be reviewed. A re-run must not surface significant new findings.
* **Severity required.** Every finding must carry a severity label.

---

## Strategy Reminders

* Consult `.ai/project/PROJECT_SPECIFIC_DETAILS.md` for framework-specific context when interpreting patterns.
* Out-of-scope pre-existing issues are noted but never mixed with in-scope findings.
* Do not suggest switching mode until the change plan (Phase 3) is complete.
