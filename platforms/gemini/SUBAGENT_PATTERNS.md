# Gemini CLI: Sub-Agent Invocation Patterns

This file is Gemini CLI-specific. Other platforms should ignore it.

## Tool Reference

Use the `codebase_investigator` and `generalist` sub-agents to delegate tasks. Each invocation is stateless — it starts with no memory of the main conversation.

## Compute Tier → Model Mapping

| Tier | Gemini Model | Use When |
|------|--------------|----------|
| `economy` | `Flash` (e.g., `gemini-3-flash-preview`) | Mechanical tasks — formatting, fact-checking, git commands |
| `standard` | `Pro` (e.g., `gemini-3-pro-preview`) | Default — reasoning, writing, analysis |
| `performance` | `Pro` (e.g., `gemini-3-pro-preview`) | Deep reasoning — architecture, cross-cutting trade-offs |

## Model Routing Mechanisms

Gemini CLI handles model selection through three primary methods:

1. **Automatic Complexity-Based Routing:** When configured to use an **"Auto"** model (e.g., `Auto (Gemini 3)`), the CLI automatically selects between **Pro** (high-reasoning) and **Flash** (high-speed) models based on the task complexity.
2. **Phase-Based Routing:** In **Plan Mode**, the CLI automatically routes requests to a **Pro** model during the Planning Phase and switches to a **Flash** model for the Implementation Phase.
3. **Manual Configuration:** Subagent models can be explicitly overridden in the `settings.json` file or via interactive commands (`/agents config <agent-name>`).

## Specialist → Agent Type Mapping

| Specialist | subagent_tool | Default Tier | Notes |
|------------|---------------|--------------|-------|
| SPEC_ANALYST | `codebase_investigator` | `standard` | Optimized for exploration and analysis |
| SPEC_ARCHITECT | `codebase_investigator` | `performance` | Best for understanding patterns and architecture |
| SPEC_TEST_WRITER | `generalist` | `standard` | Writes files and handles implementation |
| SPEC_IMPLEMENTER | `generalist` | `standard` | Writes files and handles implementation |
| SPEC_REFACTOR | `generalist` | `standard` | Performs refactoring and modifications |
| SPEC_COMMIT | `generalist` | `economy` | Runs shell commands and git operations |

## Prompt Construction

Each sub-agent prompt should follow this structure:

```
[1. ROLE — paste the relevant SPEC_*.md file content]
[2. CONTEXT — pass only what the specialist needs (paths, summaries, principles)]
[3. TASK — the specific objective for this invocation]
```

### Context Budget Rule
* **Paths over Content:** Pass file paths and symbols, not full file contents where possible.
* **Summaries over Raw Data:** Pass structured summaries from previous specialists.
* **Selective Principles:** Only inject `CODE_PRINCIPLES.md` or `TEST_CONVENTIONS.md` when the specialist is writing code.

## Parallel Execution

Gemini CLI executes independent tool calls in parallel by default. Run specialists in parallel when their inputs are independent (e.g., multiple `codebase_investigator` calls exploring unrelated modules).

**Decision rule:**
> Can I write the full prompt for both specialists right now, without waiting for either result?
> If yes → parallel. If no → sequential.
