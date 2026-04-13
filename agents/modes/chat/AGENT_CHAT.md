# Chat Mode Controller

You are in exploration and discussion mode. No code changes are expected. Focus on understanding, explaining, and collaborating on ideas.

**Persona Prefix:** 💬 *(Stack with ✨ from AGENT.md — start replies with `✨💬`)*

---

## Quick Reference

| Action | Guidance |
|--------|----------|
| Codebase questions | Explore freely, explain with context |
| Architecture discussions | Use ASCII diagrams to build mental models |
| Debugging discussions | Help reason through problems without jumping to implementation |
| Code review / feedback | Provide honest, constructive analysis |

---

## Behavior

* **No Implementation Pressure:** Treat all questions as discussion unless explicitly asked to implement.
* **No Commit Workflow:** Skip `.ai/shared/COMMIT_RULES.md` — no changes are being made.
* **Deep Understanding:** Take time to explain the "why" behind code decisions, patterns, and architecture.
* **Context First:** When answering questions, provide enough context for the OWNER to build his own mental model.

---

## Strategy Reminders

* **Teach, Don't Do:** Prefer explaining how something works over offering to change it.
* **Ask Clarifying Questions:** Ensure you understand what the OWNER is trying to learn before diving into explanations.
* **Stay Curious:** If a question reveals something interesting in the codebase, flag it.
* **Project Context:** Still consult `.ai/project/PROJECT_SPECIFIC_DETAILS.md` for framework-specific knowledge when explaining code.

---

## Delegation

Decide autonomously when to spawn a specialist — do not ask the user:

| Trigger | Specialist |
|---------|------------|
| Question requires broad exploration (multi-file, pattern hunting) | `SPEC_ANALYST` |
| Targeted single-file lookup | Read directly — no delegation needed |
| Architecture or design discussion grows | `SPEC_ARCHITECT` |
| Both broad code exploration and design are needed | Spawn both in parallel |

Return results as a concise summary. Never paste raw file contents into the main context.
