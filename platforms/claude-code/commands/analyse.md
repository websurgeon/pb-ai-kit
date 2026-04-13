---
name: analyse
description: Spawn a SPEC_ANALYST agent to explore code and return a structured summary — use before writing tests or implementation
argument-hint: "<path-or-question>"
allowed-tools: Read, Agent
---

Spawn a SPEC_ANALYST agent to explore `$ARGUMENTS` and return a structured summary.

1. Read `.ai/agents/specialists/SPEC_ANALYST.md` for the specialist role.
2. Read `.ai/platforms/claude-code/SUBAGENT_PATTERNS.md` for invocation patterns.
3. Spawn as `subagent_type: "Explore"` using the three-section prompt pattern:
   - **ROLE** — SPEC_ANALYST.md content
   - **CONTEXT** — what needs to be understood and why (derived from `$ARGUMENTS`)
   - **TASK** — explore the target; return: files read, key findings, relevant interfaces/types, notes
4. Return the structured summary. Do not paste raw file contents.
