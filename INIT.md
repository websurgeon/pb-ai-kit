# First-Time Project Setup

Run these steps in order. Stop and report after any failure.

---

## Step 1 — CLAUDE.md

Check if `CLAUDE.md` exists at the project root.
- If missing: create it containing the single line `@.ai/AGENT.md`.

---

## Step 2 — Bootstrap

Check if `.claude/commands/pb/` contains any `.md` files.
- If missing or empty: run `bash .ai/platforms/claude-code/bootstrap.sh`.

---

## Step 3 — Project config

Detect the framework by inspecting the project root for these indicators (check in order):

| Indicator | Framework |
|-----------|-----------|
| `package.json` contains `"react-native"` | `react-native` |
| `package.json` exists (no react-native) | `node` |
| `build.gradle` or `build.gradle.kts` exists | `android` |
| `*.xcodeproj` or `*.xcworkspace` exists | `ios` |
| `pubspec.yaml` exists | `flutter` |
| None matched | `unknown` |

Check if the detected framework has a directory under `.ai/frameworks/`.
- If yes: **supported framework**.
- If no: **unsupported framework** — generic config will be generated.

Ask the following questions one at a time, waiting for each answer:

1. "What is the project owner's name?"
2. "The project root looks like a **[detected framework]** project. Is that correct? (yes / type the correct framework name)"
3. *(Only if unsupported framework)* "This framework isn't in `.ai/frameworks/` yet. What is the primary test runner / build tool?"
4. "What directory contains the test config / package files? (e.g. `app`, or `.` for root)"

Then generate the project files from `.ai/templates/project/`, substituting placeholders:

| File | Substitutions |
|------|--------------|
| `.ai/project/OWNER.md` | `{{OWNER_NAME}}` → owner's name |
| `.ai/project/MODES.md` | none — copy as-is |
| `.ai/project/scripts.env` | `{{FRAMEWORK}}` → framework dir name, `{{TEST_ROOT}}` → test root |
| `.ai/project/PROJECT_SPECIFIC_DETAILS.md` | `{{PROJECT_NAME}}` → project dir name, `{{FRAMEWORK_NAME}}` → display name, `{{FRAMEWORK_DIR}}` → dir name |

If the framework is unsupported, remove the "Framework Conventions" section from `PROJECT_SPECIFIC_DETAILS.md` and add a note to fill in test conventions manually.

---

## Step 4 — Done

Reply:
```
✨ Setup complete.

- Owner: [name]
- Framework: [framework] ([supported/unsupported])
- Files written:
  - CLAUDE.md
  - .ai/project/OWNER.md
  - .ai/project/MODES.md
  - .ai/project/scripts.env
  - .ai/project/PROJECT_SPECIFIC_DETAILS.md

Please restart the session to activate /pb:* commands.

Next steps after restart:
- Fill in the architecture details in `.ai/project/PROJECT_SPECIFIC_DETAILS.md`
[If unsupported framework]: - Add test conventions in `.ai/frameworks/[framework]/` — see existing frameworks for the expected structure
```
