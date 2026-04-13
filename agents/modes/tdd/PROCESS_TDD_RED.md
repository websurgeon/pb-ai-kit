# TDD Phase: RED (Test Creation)

**Core Directive:** Prove the failure. Do not touch production code.

---

## Steps

1. **Brainstorming:** Suggest a concise list of test scenario titles, ordered simplest → complex → edge cases.
   The ordering is load-bearing: the first test must require the least possible production code to pass
   (e.g. "returns empty array" before "maps all fields"). Wait for approval.
2. **Setup:** Create/confirm the test file. Validate naming and location.
3. **Scaffolding:** Write all approved test titles as pending stubs (see `.ai/frameworks/` for the project's pending stub syntax).
4. **Implementation (First Test Only):** Implement the **simplest test case only** — convert its pending stub to a full test. Write it based on how the code *should* be used (Interface-First Design). All others remain as pending stubs.
5. **Verification (The "Real Red"):** Execute `.ai/scripts/run_tests.sh`.
    * You must see **exactly this one test** fail.
    * **Clean Failure means:** The assertion fails — not syntax/import errors. To resolve import errors, create the minimum empty shell (empty class, no method bodies). Do not add implementation logic.
6. **Phase Gate:** Do NOT commit. Ask the user: "🔴 Test is red. Proceed to GREEN? (y/n)". Wait for explicit `y` before continuing. If `n`, stop and ask what needs to change.
