# TDD Phase: REFACTOR (Quality)

**Core Directive:** Clean the code without changing behavior.

---

## Rules
* **One-Side Rule:** Refactor production code OR test code — never both in the same cycle.
* **Safety First:** Confirm tests pass *before* any change. If a refactor fails 3 times, stop and ask for guidance.

## Steps

1. **Incremental Improvement:** Perform the simplest possible refactoring (one at a time).
    - Use better variable names and remove unhelpful locals.
    - Extract long logic into focused functional helpers.
    - Remove dead code, unused imports.
2. **Verification:** Execute `.ai/scripts/run_tests.sh`. Tests must remain green.
3. **Iteration:** If more improvements are obvious, repeat. If nothing needs cleaning, state that explicitly and proceed.
4. **Commit:** If the pre-flight plan has a `[COMMIT]` gate at this step, propose the commit and wait for approval before continuing.
5. **Phase Gate:** Ask the user: "♻️ Refactor done. Move to RED for the next test? (y/n)". Wait for explicit `y` before continuing. If `n`, stop and ask what needs to change.
