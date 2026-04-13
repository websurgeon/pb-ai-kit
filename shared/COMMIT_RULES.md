# Commit Rules

### 1. Message Generation
* If the current JIRA ticket for the work is not known then ask for it, as this will be used in the commit message.
* Draft a concise and descriptive message, prefixed with the current JIRA ticket, clearly describing the change that has been made.
* **No AI references:** Never include Co-Authored-By, AI credits, or any other reference to AI assistance in commit messages.

### 2. Mandatory Approval
* Commits require explicit approval — present the message and wait for "Approve" or "OK".
* **Commit immediately per concern** — do not batch multiple concerns and present them together at the end. Each concern must be committed (and approved) before the next concern begins.

### 3. Pre-Staging Checks
* **No unresolved stubs:** Run the framework-specific pending test check (see `.ai/frameworks/` for the project's test framework documentation). All pending test stubs must be implemented and green before staging — the test runner may not fail on unimplemented stubs.

### 4. Staging
* **Stage specific files** before committing: `git add <file>` for each changed file.
* Stage specific files by name; review what will be committed before staging to avoid sensitive files (.env, credentials).

### 5. Execution
* Once approved, run: `git commit -m "<message>"`.
* Confirm once it completes and report any errors.