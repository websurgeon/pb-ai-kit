# TDD Agent Controller

You are currently executing a Test-Driven Development workflow. Follow RED → GREEN → REFACTOR phases in order.

**Persona Prefix:** 🔴 *(Stack with ✨ from AGENT.md — start replies with `✨🔴`)*

### Pre-Flight: Plan Before You Code
Before writing any code or tests, break the ticket into discrete implementation steps. For each step, decide upfront:

* **Has testable behaviour?** → apply full RED → GREEN → REFACTOR cycle
* **No meaningful assertion possible?** (e.g. adding a field to an interface, one-line DI registration) → skip RED, go straight to GREEN, state the justification explicitly, verify with full suite run
* **Defensive guard with no triggerable failure path?** (e.g. try/catch wrapping code that already swallows errors internally) → skip RED. Do not force a contrived test just to satisfy the cycle — note the reason and implement directly.

Be conservative when classifying "has testable behaviour." If you cannot write a test that currently fails without the production change, it is skip-RED.

Do not switch to DEV mode for individual steps. Stay in TDD mode throughout. The justification rule ensures skips are intentional, not lazy.

**The plan is the source of truth for commit timing.** After grouping steps into concerns, mark each commit point explicitly with `[COMMIT]` in the plan. The orchestrator executes the plan literally — when it reaches a `[COMMIT]` marker, it proposes the commit and waits for approval before proceeding to the next step.

Group steps under a single `[COMMIT]` only when they are so tightly coupled that neither is meaningful alone (e.g. a type change and its only call site). Committing as you go keeps changes separable — batching makes them inseparable.

---

### The Cycle — one test at a time
RED → GREEN → REFACTOR repeats **per test**, not per feature. After each REFACTOR, return to RED for the next pending test stub. Commit per concern group (as defined by the review plan), not once for all findings — large single commits hide intent and make bisect harder.

### Phase 1: RED (Testing)
* Reference `.ai/agents/modes/tdd/PROCESS_TDD_RED.md`.
* Goal: Implement the next pending stub as a real failing test. On first run, also scaffold all titles and create empty shells.
* **Constraint:** Write only test code in this phase.
* **Delegate:** First run only — spawn `SPEC_ANALYST` to explore existing patterns, then `SPEC_TEST_WRITER` with the analyst summary and test file path. Subsequent tests — implement **exactly one** pending stub (the next in the list) directly, without re-running ANALYST. Convert exactly one pending stub per RED phase.
* **Return:** Specialists write files directly. Expect back: file paths + one-line descriptions only.

### Phase 2: GREEN (Implementation)
* Reference `.ai/agents/modes/tdd/PROCESS_TDD_GREEN.md`.
* Goal: Write the **minimum** code to pass **this one test**. Implement only what this test requires.
* **Delegate:** Spawn `SPEC_IMPLEMENTER` with the failing test file path and the ANALYST summary. Do not paste file contents — the specialist reads them.
* **Return:** Specialist writes files directly. Expect back: file paths + descriptions + any trade-off flags.

### Phase 3: REFACTOR (Cleanup)
* Reference `.ai/agents/modes/tdd/PROCESS_TDD_REFACTOR.md`.
* Goal: Improve code structure while keeping tests passing. If nothing needs cleaning, state that explicitly and proceed.
* **Delegate:** Spawn `SPEC_REFACTOR` with the target file path and confirmation that tests pass. Do not paste file contents.
* **Return:** Specialist writes files directly. Expect back: file paths + descriptions.

### Commit
* **Timing:** Defined by the pre-flight plan. When execution reaches a `[COMMIT]` gate, stop, propose the commit, and wait for approval before continuing.
* **Pre-Commit Gate:** Before spawning `SPEC_COMMIT`, run the framework-specific pending test check (see `.ai/frameworks/` for the project's test framework documentation). All pending stubs must be implemented and green — the test runner may not fail on unimplemented stubs.
* **Delegate:** Spawn `SPEC_COMMIT` with the JIRA ticket, changed files, and a brief description of changes.

### Automation
Always use `.ai/scripts/run_tests.sh` to verify your current state.

> ⚠️ **For known test runner quirks, consult the project's test framework documentation in `.ai/frameworks/`.**