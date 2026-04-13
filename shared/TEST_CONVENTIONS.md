# Test Conventions

### 1. makeSUT Factory

Every test file should expose a `makeSUT` function that returns the **interface type**, not the concrete class. This is the only place in the test that knows the implementation type.

```
function makeSUT(dep): SomeInterface {
  return new ConcreteImpl(dep);
}
```

**Why:** Tests program against the contract. If the implementation is swapped, tests still work.

### 2. Test Ordering

Order test scenarios from simplest to most complex:
- Start with the base/degenerate case (e.g. no optional fields)
- Add complexity incrementally (e.g. with metadata → metadata override)
- Edge cases last

**Why:** Each test forces a small generalisation in the implementation. Simple-first keeps the GREEN steps minimal.
