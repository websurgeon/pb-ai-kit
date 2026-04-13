# Phase 1: Scope

**Goal:** Establish the exact diff range and get explicit owner confirmation before any analysis begins.

---

## Steps

### Step 1: Detect branches
1. Run `git branch --show-current` to identify the current branch.
2. Ask the owner to confirm the base branch: *"Confirm base branch (default: main)?"*
   Do not proceed until confirmed. This avoids silent over-scoping when the branch diverges from a feature branch rather than main.

### Step 2: Find divergence point
Run:
```
git merge-base <current-branch> <base-branch>
```
Capture the resulting commit hash as `REVIEW_BASE`.
`REVIEW_HEAD` is `HEAD` (current tip of the branch).

### Step 3: Summarise and confirm
Present to owner:

```
Branch:     <current-branch>
Base:       <base-branch>
Divergence: <REVIEW_BASE short hash> — <commit message>
Tip:        <REVIEW_HEAD short hash> — <commit message>
Commits:    <count> commits in scope
Files:      <count> files changed
```

**Wait for explicit confirmation before proceeding.** Do not begin Phase 2 until the owner approves this scope.

### Step 4: Lock scope
Store `REVIEW_BASE` and `REVIEW_HEAD` in session context. All subsequent phases reference only this range.
