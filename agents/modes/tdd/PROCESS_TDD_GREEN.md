# TDD Phase: GREEN (Implementation)

**Core Directive:** Make it pass. Write the minimum amount of code necessary.

---

## Steps

1. **Minimum Implementation:** Write only the code required to make the **current failing test** pass. Do not implement logic for pending stubs. Degenerate implementations are valid — if the test only asserts something is *not* called, `return;` is correct. Trust the next test to force generalisation.
2. **Verification:** Execute `.ai/scripts/run_tests.sh`.
    * If the test fails: fix the implementation. Stay focused on this one test.
    * If the test passes: ask the user: "🟢 Test is green. Proceed to REFACTOR? (y/n)". Wait for explicit `y` before continuing. If `n`, stop and ask what needs to change.
3. **Do NOT commit yet.** Commit timing is defined by the pre-flight plan `[COMMIT]` gates.
