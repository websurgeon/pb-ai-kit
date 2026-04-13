---
name: wip
description: Create or update WIP.md with "Done when" criteria — feeds the review audit spec check (optional but improves review determinism)
argument-hint: "[JIRA-ticket] [optional description]"
allowed-tools: Bash, Read, Write
---

Create or update `WIP.md` at the repo root with "Done when" criteria for the current work.

**Input resolution (priority order):**
1. `$ARGUMENTS` contains ticket + description → use both directly
2. `$ARGUMENTS` contains ticket only → infer criteria from `git diff` and `git log` on current branch
3. `$ARGUMENTS` is empty → infer ticket from branch name, criteria from `git diff` and `git log`

**WIP.md format:**
```
# WIP: <JIRA-ticket> <short title>

## Done when
- [ ] <concrete, independently verifiable criterion>
- [ ] <concrete, independently verifiable criterion>

## Notes
<optional: context that informs the review but is not a done-when criterion>
```

**Rules:**
- Each criterion must be concrete and verifiable — not "code is clean" but "CurrencyService returns null when no country is set"
- Infer only from branch diff and commit messages — do not invent requirements not evidenced by code changes
- If `WIP.md` already exists, update it — preserve any manually written Notes
- Confirm file path once written
