# First-Time Project Setup

Run these steps in order. Stop and report after any failure.

---

## Step 0 — Detect kit directory

Determine the name of the directory this file lives in (e.g. `.ai`, `.ai-kit`, `pb-ai-kit`).
Use this as `[KIT_DIR]` in all subsequent steps.

---

## Step 1 — CLAUDE.md

Check if `CLAUDE.md` exists at the project root.
- If missing: create it containing the single line `@[KIT_DIR]/platforms/claude-code/AGENT-CLAUDE.md`.

---

## Step 2 — Bootstrap

Check if `.claude/commands/pb/` contains any `.md` files.
- If missing or empty: run `bash [KIT_DIR]/platforms/claude-code/bootstrap.sh`.

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

Run `ls [KIT_DIR]/frameworks/` to get the list of supported frameworks, then check if the detected framework name appears in that output.
- If yes: **supported framework**.
- If no: **unsupported framework** — generic config will be generated.

Ask the following questions one at a time, waiting for each answer:

1. "What is the project owner's name?"
2. "The project root looks like a **[detected framework]** project. Is that correct? (yes / type the correct framework name)"
3. *(Only if framework name was NOT in the `ls [KIT_DIR]/frameworks/` output)* "This framework isn't in `[KIT_DIR]/frameworks/` yet. What is the primary test runner / build tool?"
4. "What directory contains the test config / package files? (e.g. `app`, or `.` for root)"
5. "Would you like to add `GEMINI.md` to the project root for Gemini CLI support? (y/n)" — accept `y` or `yes` as yes, `n` or `no` as no.

Then generate the project files from `[KIT_DIR]/templates/project/`, substituting placeholders:

| File | Substitutions |
|------|--------------|
| `[KIT_DIR]/project/OWNER.md` | `{{OWNER_NAME}}` → owner's name |
| `[KIT_DIR]/project/MODES.md` | none — copy as-is |
| `[KIT_DIR]/project/scripts.env` | `{{FRAMEWORK}}` → framework dir name, `{{TEST_ROOT}}` → test root |
| `[KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md` | `{{PROJECT_NAME}}` → project dir name, `{{FRAMEWORK_NAME}}` → display name, `{{FRAMEWORK_DIR}}` → dir name |

If the framework is unsupported, remove the "Framework Conventions" section from `PROJECT_SPECIFIC_DETAILS.md` and add a note to fill in test conventions manually.

If the user answered yes to GEMINI.md: create `GEMINI.md` at the project root containing:
```
Read [KIT_DIR]/AGENT.md and follow it as your primary instruction set.
```

---

## Step 4 — Done

Reply:
```
✨ Setup complete.

- Kit directory: [KIT_DIR]
- Owner: [name]
- Framework: [framework] ([supported/unsupported])
- Files written:
  - CLAUDE.md
  - [GEMINI.md if created]
  - [KIT_DIR]/project/OWNER.md
  - [KIT_DIR]/project/MODES.md
  - [KIT_DIR]/project/scripts.env
  - [KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md

Please restart the session to activate /pb:* commands.

Next steps after restart:
- Fill in the architecture details in `[KIT_DIR]/project/PROJECT_SPECIFIC_DETAILS.md`
[If unsupported framework]: - Add test conventions in `[KIT_DIR]/frameworks/[framework]/` — see existing frameworks for the expected structure
```
