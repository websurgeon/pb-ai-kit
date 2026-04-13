# Specialists

| Specialist | File | Use When |
|------------|------|----------|
| Analyst | `.ai/agents/specialists/SPEC_ANALYST.md` | Any question requiring code exploration |
| Architect | `.ai/agents/specialists/SPEC_ARCHITECT.md` | Design questions, pattern analysis |
| Test Writer | `.ai/agents/specialists/SPEC_TEST_WRITER.md` | Writing test files (TDD RED) |
| Implementer | `.ai/agents/specialists/SPEC_IMPLEMENTER.md` | Writing production code (TDD GREEN, DEV) |
| Refactor | `.ai/agents/specialists/SPEC_REFACTOR.md` | Cleaning code (TDD REFACTOR) |
| Commit | `.ai/agents/specialists/SPEC_COMMIT.md` | Preparing commits |
| Reviewer | `.ai/agents/specialists/SPEC_REVIEWER.md` | Diff-scoped code review (REVIEW mode) |

# AI Platform Entry Points

| Platform | Entry Point | Sub-Agent Patterns |
|----------|-------------|-------------------|
| **Claude Code** | `CLAUDE.md` → `.ai/AGENT.md` | `.ai/platforms/claude-code/SUBAGENT_PATTERNS.md` |
| **GitHub Copilot** | `.ai/AGENT.md` | `.ai/platforms/github-copilot/` *(not yet defined)* |
| **Cursor** | `.ai/AGENT.md` | `.ai/platforms/cursor/` *(not yet defined)* |
| **Gemini** | `GEMINI.md` → `.ai/AGENT.md` | `.ai/platforms/gemini/` *(not yet defined)* |
| **ChatGPT / GPT-4** | `.ai/AGENT.md` | `.ai/platforms/chatgpt/` *(not yet defined)* |

Universal: all platforms read `.ai/AGENT.md` first. Scripts in `.ai/scripts/` are bash-compatible and platform-agnostic.
