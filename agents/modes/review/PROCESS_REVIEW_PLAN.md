# Phase 3: Change Plan

**Goal:** Turn accepted findings into an ordered, actionable change plan.

---

## Steps

### Step 1: Filter candidates
From the audit report, take all in-scope findings. Present NITs last, after BLOCKER, WARNING, and SUGGESTION.

### Step 2: Confirm each finding — one at a time
For each finding (BLOCKER first, then WARNING, then SUGGESTION, then NIT):

```
Finding [n/N] — [SEVERITY]
<title>
File: path/to/file.ts:42
<detail>

Include in change plan? (y/n)
```

Wait for response before presenting the next finding.

### Step 3: Build the plan
From accepted findings, produce an ordered change plan:
- Group changes that logically belong together (same file, same concern)
- Order by dependency: changes that unblock others go first
- Assign each planned change a number
- **Flag contract changes:** If any finding involves removing or widening a type contract, note it explicitly with a ⚠️ and confirm intent before including in the plan — these are debatable and easy to mis-implement.
- **Propose commit groupings:** At the end of the plan, suggest how the changes should be split across commits (one commit per concern, not one large commit for all findings). Label each planned change with its proposed commit (e.g. `[Commit A]`).

Present the full plan for review and wait for confirmation before proceeding.

### Step 4: Suggest mode switch
Once the plan is confirmed, suggest switching mode:

```
Change plan is ready. Switch to TDD mode for test-first changes,
or DEV mode for direct implementation. Say "switch to TDD mode"
or "switch to DEV mode" to continue.
```

**Do not commit or edit files. REVIEW mode ends here.**
