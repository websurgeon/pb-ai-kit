> **Kit directory:** `[KIT_DIR]` refers to the directory containing this file. Resolve it from the path used to load this file.

# Compute Tiers

Platform-agnostic labels for how much capability a task warrants. Each platform maps these to its own specific models.

| Tier | Intent |
|------|--------|
| `economy` | Mechanical tasks — formatting, fact-checking, simple commands |
| `standard` | Default — reasoning, writing, analysis |
| `performance` | Deep reasoning — architecture, cross-cutting trade-offs |

# Specialists

| Specialist | File | Use When | Tier |
|------------|------|----------|------|
| Analyst | `[KIT_DIR]/agents/specialists/SPEC_ANALYST.md` | Any question requiring code exploration | `standard` |
| Architect | `[KIT_DIR]/agents/specialists/SPEC_ARCHITECT.md` | Design questions, pattern analysis | `performance` |
| Test Writer | `[KIT_DIR]/agents/specialists/SPEC_TEST_WRITER.md` | Writing test files (TDD RED) | `standard` |
| Implementer | `[KIT_DIR]/agents/specialists/SPEC_IMPLEMENTER.md` | Writing production code (TDD GREEN, DEV) | `standard` |
| Refactor | `[KIT_DIR]/agents/specialists/SPEC_REFACTOR.md` | Cleaning code (TDD REFACTOR) | `standard` |
| Commit | `[KIT_DIR]/agents/specialists/SPEC_COMMIT.md` | Preparing commits | `economy` |
| Reviewer | `[KIT_DIR]/agents/specialists/SPEC_REVIEWER.md` | Diff-scoped code review (REVIEW mode) | `standard` |
| Finding Verifier | *(inline)* | Batched verification of findings | `economy` |
| Audit Coordinator | *(inline)* | Orchestrates full REVIEW Phase 2 | `standard` |

> Tiers are defaults. The orchestrator may override when a task is unusually complex or trivially simple. Platform-specific model mappings live in `[KIT_DIR]/platforms/<platform>/SUBAGENT_PATTERNS.md`.

# AI Platform Entry Points

| Platform | Entry Point | Sub-Agent Patterns |
|----------|-------------|-------------------|
| **Claude Code** | `CLAUDE.md` → `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/claude-code/SUBAGENT_PATTERNS.md` |
| **GitHub Copilot** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/github-copilot/` *(not yet defined)* |
| **Cursor** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/cursor/` *(not yet defined)* |
| **Gemini** | `GEMINI.md` → `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/gemini/` *(not yet defined)* |
| **ChatGPT / GPT-4** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/chatgpt/` *(not yet defined)* |

Universal: all platforms read `[KIT_DIR]/AGENT.md` first. Scripts in `[KIT_DIR]/scripts/` are bash-compatible and platform-agnostic.
