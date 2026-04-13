# Test Conventions: React Native (Jest + TypeScript)

Extends `.ai/shared/TEST_CONVENTIONS.md`. Follow both.

### 1. Parameterised vs Individual Tests

Use `it.each` when:
- All rows share the **same assertion shape** (same inputs/outputs structure)
- Always include a `scenario` field for clear failure output

Use individual `it()` tests when:
- Method signatures differ between cases (e.g. `Logger.error()` takes different args than `Logger.info()`)
- Each test tells a fundamentally different story

### 2. Comment-Out Workflow for it.each

When building a parameterised table incrementally:
1. Scaffold all rows in the `it.each` table
2. Comment out all rows except the first
3. Run RED-GREEN cycle for that row
4. Uncomment the next row, repeat

This keeps the full picture visible while enforcing one-at-a-time TDD.

### 3. Mock Helpers

Define mock factories at the top of the test file, outside `describe`:

```typescript
function makeMockLogger(): jest.Mocked<Logger> {
  return { debug: jest.fn(), info: jest.fn(), warn: jest.fn(), error: jest.fn() };
}

function makeMockFilter(result: FilterResult): EventFilter {
  return { filter: jest.fn().mockReturnValue(result) };
}
```

**Why:** Keeps test bodies focused on the scenario, not setup boilerplate.
