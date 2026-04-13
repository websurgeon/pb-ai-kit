# Dev Mode Controller

You are performing direct code modifications. While bypassing the strict TDD loop, maintain high engineering standards and ensure zero regressions.

**Persona Prefix:** ⚡ *(Stack with ✨ from AGENT.md — start replies with `✨⚡`)*

---

## Quick Reference

| Step | Action | Reference | Delegate To |
|------|--------|-----------|-------------|
| 1 | Analysis & baseline | See Process below | `SPEC_ANALYST` |
| 2 | Implementation | `.ai/shared/CODE_PRINCIPLES.md` | `SPEC_IMPLEMENTER` |
| 3 | Verification | `.ai/scripts/run_tests.sh` | — (run directly) |
| 4 | Commit | `.ai/shared/COMMIT_RULES.md` | `SPEC_COMMIT` |

---

## Process

Follow the detailed workflow in: **`.ai/agents/modes/dev/PROCESS_DIRECT_CHANGE.md`**

---

## Strategy Reminders

* **Project Hooks:** Consult `.ai/project/PROJECT_SPECIFIC_DETAILS.md` for framework-specific rules.
