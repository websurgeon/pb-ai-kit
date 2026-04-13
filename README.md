# .ai — AI Kit

> **Work in Progress**
> This kit is under active development. Expect significant changes as behaviour is made more consistent across platforms, new skills are added, and token usage is reduced. Use it, but don't be surprised if things shift.

A portable AI configuration layer that can be dropped into any project to provide a consistent, structured AI development experience. It is platform-agnostic by design — the same kit works with Claude Code, Gemini CLI, Cursor, GitHub Copilot, or any other AI assistant.

> **Note on portability:** The `.ai` directory currently lives inside the project it serves — it is not designed to be shared across multiple projects from a central location. Each project has its own copy of the kit.

---

## What is the AI Kit?

The `.ai` directory is a self-contained configuration kit that gives your AI assistant:

- **A consistent identity** — a senior engineer persona with clear communication rules
- **Structured modes** — distinct workflows for exploration, implementation, TDD, and code review
- **Project context** — per-project configuration (owner, tech stack, conventions)
- **Shared standards** — code principles, commit rules, and test conventions
- **Specialist agents** — named sub-agents for analysis, testing, implementation, review, and commits
- **Platform-specific setup** — bootstrap scripts and skill definitions for Claude Code; sub-agent patterns for Gemini

The kit is designed so that AI reads the right files automatically at session start, with no manual prompting required. You just open your editor or terminal and start working.

---

## Directory Structure

```
.ai/
├── AGENT.md                        # Universal AI entry point (all platforms)
├── AGENT-CLAUDE.md                 # Claude Code-specific session start instructions
├── DELEGATES.md                    # Specialist roster + platform entry points
│
├── agents/
│   ├── modes/
│   │   ├── chat/                   # CHAT mode — explore and discuss
│   │   ├── dev/                    # DEV mode — direct implementation
│   │   ├── review/                 # REVIEW mode — code review and audit
│   │   └── tdd/                    # TDD mode — red/green/refactor cycle
│   └── specialists/                # Named sub-agents (ANALYST, IMPLEMENTER, etc.)
│
├── frameworks/
│   ├── android/                    # Android test framework conventions
│   └── react-native/               # React Native test framework conventions
│
├── platforms/
│   ├── claude-code/
│   │   ├── bootstrap.sh            # Installs Claude Code skills (/pb:tdd, etc.)
│   │   ├── SUBAGENT_PATTERNS.md    # How to spawn sub-agents in Claude Code
│   │   └── commands/               # Skill definitions (one .md per skill)
│   └── gemini/
│       └── SUBAGENT_PATTERNS.md    # How to spawn sub-agents in Gemini CLI
│
├── projects/
│   ├── <project-name>/             # Per-project config (OWNER, stack, details)
│   └── ...
├── project/                        # Symlink → active project config
│
├── scripts/
│   └── project-manager.sh          # List, register, and switch projects
│
└── shared/
    ├── CODE_PRINCIPLES.md          # Engineering standards (all AI modes use this)
    ├── COMMIT_RULES.md             # Commit message format and approval workflow
    └── TEST_CONVENTIONS.md         # Universal test patterns
```

---

## Platform Entry Points

Every AI platform reads `.ai/AGENT.md` as the universal foundation. Platforms with their own config file chain into it:

| Platform | Config File | Notes |
|----------|-------------|-------|
| **Claude Code** | `CLAUDE.md` → `.ai/AGENT-CLAUDE.md` | Full skills support via bootstrap |
| **Gemini CLI** | `GEMINI.md` → `.ai/AGENT.md` | Sub-agent patterns available |
| **Cursor** | `.ai/AGENT.md` | Direct read; no platform-specific setup yet |
| **GitHub Copilot** | `.ai/AGENT.md` | Direct read; no platform-specific setup yet |
| **ChatGPT / GPT-4** | `.ai/AGENT.md` | Direct read; no platform-specific setup yet |

Claude Code gets its own entry point (`AGENT-CLAUDE.md`) because it supports platform-specific features — skills bootstrapping, slash commands, and sub-agent invocation via the `Agent` tool — that don't apply to other platforms.

---

## Modes

The AI operates in one of four modes. Each has a distinct persona and workflow:

| Mode | Emoji | Purpose |
|------|-------|---------|
| **CHAT** | 💬 | Explore, discuss, plan — no code changes |
| **DEV** | ⚡ | Direct implementation with analyst/implementer delegation |
| **TDD** | 🔴 | Test-driven: RED → GREEN → REFACTOR cycle |
| **REVIEW** | 🔍 | Code review, audit, and finding verification |

Default mode is **CHAT**. Switch modes using the platform-specific prompts below.

---

## First Use: Claude Code

### 1. Bootstrap Skills

Claude Code supports slash-command skills (`/pb:tdd`, `/pb:dev`, etc.). These are installed once per machine via the bootstrap script.

At the start of a new Claude Code session, Claude will automatically detect if skills are missing and offer to install them. You can also install manually:

```bash
bash .ai/platforms/claude-code/bootstrap.sh
```

> **Restart required.** After running the bootstrap script, restart Claude Code before using any `/pb:` skills. The skills are installed into `~/.claude/commands/pb/` and are picked up on the next session start.

### 2. Register the Project (First Time Only)

When `.ai` is first dropped into a project, register the project so the AI knows which config to use:

```bash
bash .ai/scripts/project-manager.sh register <name> <path>
bash .ai/scripts/project-manager.sh switch <name>
```

This only needs to be done once. After that, the active project symlink (`.ai/project/`) is in place and Claude Code will pick it up automatically on every session start. You do not need to switch projects again unless you add a second project to the same kit.

### 3. Available Skills (Claude Code)

The following skills are installed by the bootstrap. You never need to call them directly — the AI will invoke the right one based on what you ask. They are listed here for reference.

| Skill | What to say |
|-------|-------------|
| `/pb:chat` | "Switch to chat mode" / "Let's just discuss this" |
| `/pb:dev` | "Switch to dev mode" / "Implement this directly" |
| `/pb:tdd` | "Switch to TDD mode" / "Let's do this test-first" |
| `/pb:review` | "Review this" / "Switch to review mode" |
| `/pb:plan` | "Plan ticket MDT-1234" / "Break this ticket into steps" |
| `/pb:analyse` | "Analyse AuthService.ts" / "Explore this before we start" |
| `/pb:commit` | "Commit these changes" / "Let's commit, JIRA is MDT-1234" |
| `/pb:refactor` | "Refactor this file" / "Clean this up without changing behaviour" |
| `/pb:audit` | "Run a full review audit" / "Audit the changes on this branch" |
| `/pb:wip` | "Set the done criteria for this ticket" |
| `/pb:project` | "List projects" / "Switch to project X" |

---

## First Use: Gemini CLI & Other AI Platforms

There is no bootstrap step for non-Claude-Code platforms — the kit works immediately. Point the AI at the appropriate entry file and use natural-language prompts to drive the same workflows.

| Platform | Entry File |
|----------|------------|
| **Gemini CLI** | `GEMINI.md` at repo root, which chains into `.ai/AGENT.md` |
| **All others** | `.ai/AGENT.md` directly |

Gemini has additional kit support: sub-agent delegation patterns are defined in `.ai/platforms/gemini/SUBAGENT_PATTERNS.md`. For complex multi-step tasks, instruct Gemini to read that file so it knows how to structure specialist delegations. Other platforms can follow the same natural-language patterns without a platform-specific file.

Use the same natural-language prompts as any other platform — the AI will read the correct files and activate the right mode. See the **Typical Workflow** section below.

---

## Typical Workflow

These prompts work on any platform. The AI interprets them and activates the appropriate mode, skill, or process.

```
# Explore or discuss before writing any code
"Switch to chat mode"

# Plan a ticket before starting
"Plan ticket MDT-1234"

# Implement test-first
"Switch to TDD mode"

# Implement directly (no strict TDD cycle)
"Switch to dev mode"

# Analyse code before making changes
"Analyse src/auth/AuthService.ts"

# Commit staged changes
"Commit these changes, JIRA is MDT-1234"

# Refactor without changing behaviour
"Refactor this file"

# Review changes before merging
"Switch to review mode" / "Run a full review audit"
```

---

## Specialist Agents

The kit includes named specialist agents for complex delegated tasks. These are used internally by the AI during DEV, TDD, and REVIEW modes, but you can also invoke them explicitly.

| Specialist | File | Role |
|------------|------|------|
| `SPEC_ANALYST` | `agents/specialists/SPEC_ANALYST.md` | Explore code, return structured summary |
| `SPEC_ARCHITECT` | `agents/specialists/SPEC_ARCHITECT.md` | Design and architectural reasoning |
| `SPEC_TEST_WRITER` | `agents/specialists/SPEC_TEST_WRITER.md` | Write failing tests (RED phase) |
| `SPEC_IMPLEMENTER` | `agents/specialists/SPEC_IMPLEMENTER.md` | Write production code (GREEN phase) |
| `SPEC_REFACTOR` | `agents/specialists/SPEC_REFACTOR.md` | Clean code without behaviour changes |
| `SPEC_REVIEWER` | `agents/specialists/SPEC_REVIEWER.md` | Diff analysis and finding generation |
| `SPEC_FINDING_VERIFIER` | `agents/specialists/SPEC_FINDING_VERIFIER.md` | Verify review findings against the code |
| `SPEC_COMMIT` | `agents/specialists/SPEC_COMMIT.md` | Prepare commit message and await approval |

---

## Adding the Kit to a New Project

1. Copy the `.ai` directory into the project root.
2. Add `CLAUDE.md` at the repo root referencing `.ai/AGENT-CLAUDE.md` (for Claude Code).
3. Add `GEMINI.md` at the repo root referencing `.ai/AGENT.md` (for Gemini CLI).
4. Run `bash .ai/platforms/claude-code/bootstrap.sh` and restart Claude Code.
5. Register the project and switch to it (one-time):
   ```bash
   bash .ai/scripts/project-manager.sh register <name> <path>
   bash .ai/scripts/project-manager.sh switch <name>
   ```
