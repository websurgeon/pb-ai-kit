# Claude Code: Sub-Agent Invocation Patterns

This file is Claude Code-specific. Other platforms should ignore it.

## Tool Reference

Use the `Agent` tool to spawn sub-agents. Each invocation is stateless — it starts with no memory of the main conversation.

## Compute Tier → Model Mapping

| Tier | Model | Use When |
|------|-------|----------|
| `economy` | `haiku` | Mechanical tasks — formatting, fact-checking, git commands |
| `standard` | `sonnet` | Default — reasoning, writing, analysis |
| `performance` | `opus` | Deep reasoning — architecture, cross-cutting trade-offs |

The orchestrator MUST pass the `model` parameter when spawning any sub-agent. Use the specialist's default tier from `DELEGATES.md`. Override when the specific task is clearly simpler or more complex than the default.

## Specialist → Agent Type Mapping

| Specialist | subagent_type | model | Notes |
|------------|---------------|-------|-------|
| SPEC_ANALYST | `Explore` | `sonnet` | Optimized for codebase exploration and file reading |
| SPEC_ARCHITECT | `general-purpose` | `opus` | Needs deep reasoning and file reads |
| SPEC_TEST_WRITER | `general-purpose` | `sonnet` | Writes files |
| SPEC_IMPLEMENTER | `general-purpose` | `sonnet` | Writes files |
| SPEC_REFACTOR | `general-purpose` | `sonnet` | Writes files |
| SPEC_COMMIT | `general-purpose` | `haiku` | Runs bash and git commands |
| SPEC_REVIEWER | `Explore` | `sonnet` | Read-only diff analysis — use `Bash` tool for all git diff commands, not `Grep` or `Read` |
| SPEC_FINDING_VERIFIER | `general-purpose` | `haiku` | Batched verification of all findings in one invocation |
| **Audit Coordinator** | `general-purpose` | `sonnet` | Runs entire REVIEW Phase 2 — spawns its own reviewer/verifier sub-agents |

### Override Examples
- ANALYST exploring a single well-scoped file → downgrade to `haiku`
- IMPLEMENTER writing cross-cutting middleware touching many layers → upgrade to `opus`

## Prompt Construction

Each sub-agent prompt has three sections:

```
[1. ROLE — paste the relevant SPEC_*.md file content]
[2. CONTEXT — pass only what the specialist needs]
[3. TASK — the specific job for this invocation]
```

### Context Budget Rule
Keep injected context under ~2000 tokens:
* Pass file paths, not full file contents where possible
* Pass summaries from prior specialists, not raw outputs
* Only inject shared files (CODE_PRINCIPLES, TEST_CONVENTIONS) when directly needed by that specialist

## Parallel Execution

Run specialists in parallel when their inputs are fully independent — neither result feeds the other.

**Safe to parallelise:**
- Two ANALYST calls exploring unrelated modules
- ANALYST + ARCHITECT when the architect has sufficient context without the analyst's result
- Multiple IMPLEMENTER calls for changes in separate, unrelated files

**Not safe to parallelise:**
- ANALYST → TEST_WRITER (writer needs the analyst's summary)
- TEST_WRITER → IMPLEMENTER (implementer needs the failing test)
- Any chain where specialist N+1 consumes specialist N's output

**Decision rule:**
> Can I write the full prompt for both specialists right now, without waiting for either result?
> If yes → parallel. If no → sequential.

Use `run_in_background: true` for parallel specialists when results are not immediately needed.

## Example: Spawning ANALYST

```
Agent tool:
  description: "Analyse existing auth service"
  subagent_type: "Explore"
  prompt: |
    [paste SPEC_ANALYST.md content]

    CONTEXT:
    The orchestrator needs to understand the existing auth service before writing a new test.

    TASK:
    Explore the auth feature at `app/src/features/auth/`. Return:
    - Domain interfaces
    - Existing test patterns
    - DI registration location
```

## Example: Spawning TEST_WRITER

```
Agent tool:
  description: "Write failing test for AuthService.login"
  subagent_type: "general-purpose"
  prompt: |
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

Never paste full file contents back into the main context. Instead:
* **ANALYST:** paste the structured summary only
* **TEST_WRITER / IMPLEMENTER / REFACTOR:** confirm the file path written and provide a one-line description of the change
* **ARCHITECT:** paste the overview and recommendation sections only
* **COMMIT:** paste the full commit preparation block for OWNER approval
* **Audit Coordinator:** return the final verified report only — no intermediate findings, no dismissed items, no raw reviewer output

This keeps the orchestrator context lean throughout the session.

## Context Isolation

Sub-agents are stateless — they receive only the prompt you construct. Do NOT pass:
* Content from `.ai/project/PROJECT_SPECIFIC_DETAILS.md` to SPEC_REVIEWER or SPEC_FINDING_VERIFIER — they work from the diff and code, not framework docs
* Raw output from one specialist to another — pass summaries
* Files the specialist doesn't need — each spec file is self-contained
