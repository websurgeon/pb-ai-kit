---
name: init
description: Initialise the .ai/project/ config for this project
allowed-tools: Bash, Read, Write, Glob
---

You are initialising the `.ai/project/` directory for this project.

**Step 1 — Check existing state**

Check if `.ai/project/OWNER.md` already exists (use Glob or Bash).
- If it exists, warn the user: "⚠️ A project config already exists. Running `/init` will overwrite it. Continue? (yes/no)" — wait for confirmation before proceeding.
- If it does not exist, continue immediately.

**Step 2 — Detect the framework**

Inspect the project root (the directory containing `.ai/`) for these indicators (check in order):

| Indicator | Framework |
|-----------|-----------|
| `package.json` contains `"react-native"` | `react-native` |
| `package.json` exists (no react-native) | `node` |
| `build.gradle` or `build.gradle.kts` exists | `android` |
| `*.xcodeproj` or `*.xcworkspace` exists | `ios` |
| `pubspec.yaml` exists | `flutter` |
| None matched | `unknown` |

Check if the detected framework has a directory under `.ai/frameworks/` (e.g. `.ai/frameworks/react-native/`).
- If yes: it is a **supported framework**.
- If no: it is a **new/unsupported framework** — you will generate generic project files.

**Step 3 — Ask questions (one at a time)**

Ask the following questions sequentially. Wait for each answer before asking the next.

1. "What is the project owner's name?"
2. "The project root looks like a **[detected framework]** project. Is that correct? (yes / type the correct framework name)"
3. If framework has no `.ai/frameworks/` directory: "This framework isn't in `.ai/frameworks/` yet. I'll generate a generic config. What is the primary test runner / build tool for this project?"
4. "What directory contains the test config / package files? (e.g. `app`, `.` for root)"

**Step 4 — Generate project files**

Using the answers collected, create the following files by copying from `.ai/templates/project/` and substituting placeholders:

| File | Placeholders to replace |
|------|------------------------|
| `.ai/project/OWNER.md` | `{{OWNER_NAME}}` → owner's name |
| `.ai/project/MODES.md` | (no substitutions — copy as-is) |
| `.ai/project/scripts.env` | `{{FRAMEWORK}}` → framework dir name, `{{TEST_ROOT}}` → test root path |
| `.ai/project/PROJECT_SPECIFIC_DETAILS.md` | `{{PROJECT_NAME}}` → project dir name, `{{FRAMEWORK_NAME}}` → display name, `{{FRAMEWORK_DIR}}` → dir name |

If the framework is **unsupported** (no `.ai/frameworks/` directory), remove the "Framework Conventions" section from `PROJECT_SPECIFIC_DETAILS.md` and leave a note that the user should fill in test conventions manually.

**Step 5 — Confirm and summarise**

After writing all files, reply:

```
✨ Project initialised.

- Owner: [name]
- Framework: [framework] ([supported/new])
- Files written:
  - .ai/project/OWNER.md
  - .ai/project/MODES.md
  - .ai/project/scripts.env
  - .ai/project/PROJECT_SPECIFIC_DETAILS.md

Next steps:
- Fill in the architecture details in `.ai/project/PROJECT_SPECIFIC_DETAILS.md`
[If new framework]: - Add test conventions in `.ai/frameworks/[framework]/` — see existing frameworks for the expected structure
```
