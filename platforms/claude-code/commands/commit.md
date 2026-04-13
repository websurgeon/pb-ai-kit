---
name: commit
description: Run the commit workflow — stages files, builds a JIRA-prefixed message, and waits for explicit approval before committing
argument-hint: "[JIRA-ticket]"
allowed-tools: Bash, Read, Glob, Grep
---

Run the commit workflow. JIRA ticket: $ARGUMENTS

- If `$ARGUMENTS` is empty, ask for the JIRA ticket ID before continuing.
- Run `git status` + `git diff --staged`. If nothing staged, run `git diff` and ask which files to include.
- Prepare a commit block:
  - `git add <file>` per file (never `-A` or `.`)
  - Message: `<JIRA> <what and why>` — no AI references
- Present the block and wait for "Approve" or "OK".
- On approval: stage files, commit, report result.
