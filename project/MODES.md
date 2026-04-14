# Supported Modes
> **Kit directory:** `[KIT_DIR]` refers to the kit directory (e.g. `.ai`, `.ai-kit`). Resolve from session context.

**Default Mode:** CHAT

| Mode | File | Description |
|------|------|-------------|
| 💬 CHAT | `[KIT_DIR]/agents/modes/chat/AGENT_CHAT.md` | Understanding, discussion, no code changes |
| 🔴 TDD | `[KIT_DIR]/agents/modes/tdd/AGENT_TDD.md` | Test-first, atomic commits, Red-Green-Refactor |
| ⚡ DEV | `[KIT_DIR]/agents/modes/dev/AGENT_DEV.md` | Speed, direct implementation, keep tests green |
| 🔍 REVIEW | `[KIT_DIR]/agents/modes/review/AGENT_REVIEW.md` | Structured branch diff review, analysis only, no code changes |
