> **Kit directory:** `[KIT_DIR]` refers to the directory containing this file. Resolve it from the path used to load this file.

# Specialists

| Specialist | File | Use When |
|------------|------|----------|
| Analyst | `[KIT_DIR]/agents/specialists/SPEC_ANALYST.md` | Any question requiring code exploration |
| Architect | `[KIT_DIR]/agents/specialists/SPEC_ARCHITECT.md` | Design questions, pattern analysis |
| Test Writer | `[KIT_DIR]/agents/specialists/SPEC_TEST_WRITER.md` | Writing test files (TDD RED) |
| Implementer | `[KIT_DIR]/agents/specialists/SPEC_IMPLEMENTER.md` | Writing production code (TDD GREEN, DEV) |
| Refactor | `[KIT_DIR]/agents/specialists/SPEC_REFACTOR.md` | Cleaning code (TDD REFACTOR) |
| Commit | `[KIT_DIR]/agents/specialists/SPEC_COMMIT.md` | Preparing commits |
| Reviewer | `[KIT_DIR]/agents/specialists/SPEC_REVIEWER.md` | Diff-scoped code review (REVIEW mode) |

# AI Platform Entry Points

| Platform | Entry Point | Sub-Agent Patterns |
|----------|-------------|-------------------|
| **Claude Code** | `CLAUDE.md` → `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/claude-code/SUBAGENT_PATTERNS.md` |
| **GitHub Copilot** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/github-copilot/` *(not yet defined)* |
| **Cursor** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/cursor/` *(not yet defined)* |
| **Gemini** | `GEMINI.md` → `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/gemini/` *(not yet defined)* |
| **ChatGPT / GPT-4** | `[KIT_DIR]/AGENT.md` | `[KIT_DIR]/platforms/chatgpt/` *(not yet defined)* |

Universal: all platforms read `[KIT_DIR]/AGENT.md` first. Scripts in `[KIT_DIR]/scripts/` are bash-compatible and platform-agnostic.
