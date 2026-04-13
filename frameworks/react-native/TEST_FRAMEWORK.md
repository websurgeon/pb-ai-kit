# Test Framework: Jest (React Native)

## Pending Test Marker

Use `it.todo('...')` to scaffold pending tests. Jest does not fail on todos — a green suite does not mean todos are resolved.

## Pre-Commit Check

Before staging test files, run:
```bash
grep -r "it\.todo" <test files being committed>
```
If any results are found, stop. All `it.todo` stubs must be implemented and green before committing.

## Known Quirks

**Jest transform cache error:** If the full suite shows failed suites but `Tests: N passed, N total` (zero assertion failures), this is a transient jest transform cache error. Re-run before treating it as a real failure.
