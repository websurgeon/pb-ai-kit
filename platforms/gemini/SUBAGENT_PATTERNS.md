# Gemini CLI: Sub-Agent Invocation Patterns

This file is Gemini CLI-specific. Other platforms should ignore it.

## Tool Reference

Use the `codebase_investigator` and `generalist` sub-agents to delegate tasks. Each invocation is stateless — it starts with no memory of the main conversation.

## Specialist → Agent Type Mapping

| Specialist | subagent_tool | Notes |
|------------|---------------|-------|
| SPEC_ANALYST | `codebase_investigator` | Optimized for exploration, analysis, and architectural mapping |
| SPEC_ARCHITECT | `codebase_investigator` | Best for understanding patterns and cross-cutting concerns |
| SPEC_TEST_WRITER | `generalist` | Writes files and handles specific implementation tasks |
| SPEC_IMPLEMENTER | `generalist` | Writes files and handles specific implementation tasks |
| SPEC_REFACTOR | `generalist` | Performs refactoring and file modifications |
| SPEC_COMMIT | `generalist` | Runs shell commands and prepares git operations |

## Prompt Construction

Each sub-agent prompt should be constructed with three clear sections:

```
[1. ROLE — paste the relevant SPEC_*.md file content]
[2. CONTEXT — pass only what the specialist needs (paths, summaries, principles)]
[3. TASK — the specific objective for this invocation]
```

### Context Budget Rule
Keep injected context focused to maintain speed and accuracy:
* **Paths over Content:** Pass file paths and symbols, not full file contents where possible.
* **Summaries over Raw Data:** Pass structured summaries from previous specialists.
* **Selective Principles:** Only inject `CODE_PRINCIPLES.md` or `TEST_CONVENTIONS.md` when the specialist is responsible for writing or refactoring code.

## Parallel Execution

Run specialists in parallel when their inputs are fully independent — neither result feeds the other.

**Safe to parallelise:**
- Multiple `codebase_investigator` calls exploring unrelated modules
- `codebase_investigator` (ANALYST) + `codebase_investigator` (ARCHITECT) when the architect has sufficient context without the analyst's result
- Multiple `generalist` calls for changes in separate, unrelated files

**Not safe to parallelise:**
- ANALYST → TEST_WRITER (writer needs the analyst's summary)
- TEST_WRITER → IMPLEMENTER (implementer needs the failing test)
- Any chain where specialist N+1 consumes specialist N's output

**Decision rule:**
> Can I write the full prompt for both specialists right now, without waiting for either result?
> If yes → parallel. If no → sequential.

Note: Gemini CLI executes multiple independent tool calls in parallel automatically when possible.

## Example: Spawning ANALYST (codebase_investigator)

```
codebase_investigator tool:
  objective: |
    [paste SPEC_ANALYST.md content]

    CONTEXT:
    The orchestrator needs to understand the existing auth service before writing a new test.

    TASK:
    Explore the auth feature at `app/src/features/auth/`. Return:
    - Domain interfaces
    - Existing test patterns
    - DI registration location
```

## Example: Spawning TEST_WRITER (generalist)

```
generalist tool:
  request: |
    [paste SPEC_TEST_WRITER.md content]

    [paste TEST_CONVENTIONS.md content]

    CONTEXT (from ANALYST summary):
    - AuthService interface: `app/src/features/auth/domain/AuthService.ts`
    - Existing tests pattern: `__tests__/AuthService.test.tsx`
    - Mock helper pattern: `makeAuthService()` returns `jest.Mocked<AuthService>`

    TASK:
    Write a failing test for the `login(email, password)` method.
    Scenario: returns a user when credentials are valid.
```

## Returning Results to Main Context

To keep the orchestrator context lean, specialists should return only essential information:
* **ANALYST / ARCHITECT:** Return the structured summary/insight block defined in their SPEC file.
* **TEST_WRITER / IMPLEMENTER / REFACTOR:** Confirm the file path(s) modified and provide a one-line description of the change.
* **COMMIT:** Return the full commit preparation block for OWNER approval.

Avoid pasting raw file contents back into the main orchestrator loop unless explicitly requested by the OWNER.
