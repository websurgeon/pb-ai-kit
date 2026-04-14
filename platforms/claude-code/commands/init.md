---
name: init
description: Initialise the [KIT_DIR]/project/ config for this project
allowed-tools: Bash, Read, Write, Glob
---

You are initialising the `[KIT_DIR]/project/` directory for this project.
`[KIT_DIR]` is already resolved from the session start — use that value throughout.

**Step 1 — Check existing state**

Check if `[KIT_DIR]/project/OWNER.md` already exists (use Glob or Bash).
- If it exists, warn the user: "⚠️ A project config already exists. Running `/pb:init` will overwrite it. Continue? (y/n)" — accept `y` or `yes` to proceed, `n` or `no` to abort.
- If it does not exist, continue immediately.

**Step 2 — Detect the framework**

Inspect the project root (the directory containing `[KIT_DIR]/`) for these indicators (check in order):

| Indicator | Framework |
|-----------|-----------|
| `package.json` contains `"react-native"` | `react-native` |
| `package.json` exists (no react-native) | `node` |
| `build.gradle` or `build.gradle.kts` exists | `android` |
| `*.xcodeproj` or `*.xcworkspace` exists | `ios` |
| `pubspec.yaml` exists | `flutter` |
| None matched | `unknown` |

Run `ls [KIT_DIR]/frameworks/` to get the list of supported frameworks, then check if the detected framework name appears in that output.
- If yes: it is a **supported framework**.
- If no: it is a **new/unsupported framework** — you will generate generic project files.

**Step 3 — Ask questions (one at a time)**

Ask the following questions sequentially. Wait for each answer before asking the next.

1. "What is the project owner's name?"
2. "The project root looks like a **[detected framework]** project. Is that correct? (yes / type the correct framework name)"
3. *(Only if framework name was NOT in the `ls [KIT_DIR]/frameworks/` output)* "This framework isn't in `[KIT_DIR]/frameworks/` yet. I'll generate a generic config. What is the primary test runner / build tool for this project?"
4. "What directory contains the test config / package files? (e.g. `app`, `.` for root)"

**Step 4 — Generate project files**

Using the answers collected, create the following files by copying from `[KIT_DIR]/templates/project/` and substituting placeholders:

| File | Placeholders to replace |
|------|------------------------|
| `[KIT_DIR]/project/OWNER.md` | `{{OWNER_NAME}}` → owner's name |
| `[KIT_DIR]/project/MODES.md` | none — copy as-is |
| `[KIT_DIR]/project/scripts.env` | `{{FRAMEWORK}}` → framework dir name, `{{TEST_ROOT}}` → test root path |
| `[KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md` | `{{PROJECT_NAME}}` → project dir name, `{{FRAMEWORK_NAME}}` → display name, `{{FRAMEWORK_DIR}}` → dir name |

If the framework is **unsupported**, remove the "Framework Conventions" section from `PROJECT_SPECIFIC_DETAILS.md` and leave a note that the user should fill in test conventions manually.

**Step 5 — Confirm and summarise**

After writing all files, reply:

```
✨ Project initialised.

- Owner: [name]
- Framework: [framework] ([supported/new])
- Files written:
  - [KIT_DIR]/project/OWNER.md
  - [KIT_DIR]/project/MODES.md
  - [KIT_DIR]/project/scripts.env
  - [KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md

Next steps:
- Fill in the architecture details in `[KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md`
[If new framework]: - Add test conventions in `[KIT_DIR]/frameworks/[framework]/` — see existing frameworks for the expected structure
```
