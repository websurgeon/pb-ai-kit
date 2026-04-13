# Code Principles

Follow these principles strictly. They are functional requirements, not suggestions.

### 1. Simplicity over Cleverness
* **Prioritize Simplicity:** Implement simple, maintainable solutions over clever or complex ones. 
* **Readability First:** Write logic that is easy to parse at a glance.
* **Readability Over Performance:** Value readability over performance optimizations unless high-performance is a stated requirement.

### 2. Architecture & Structure
The goal is stable, maintainable, scalable, and testable code. SOLID principles are strongly favoured because they serve that goal. Apply them when they clearly improve the solution. When following a principle would add complexity without meaningful benefit, ask the OWNER before deviating.

* **Single Responsibility (SRP):** Every class and function has exactly one reason to change.
* **Open/Closed (OCP):** Favour extending behaviour through new types or composition rather than modifying existing stable logic. Apply when the extension point is clear; do not add abstractions speculatively.
* **Liskov Substitution (LSP):** Implementations must honour the full contract of the interface they satisfy — including edge cases and error semantics, not just the type signature.
* **Interface Segregation (ISP):** Keep interfaces narrow. Prefer several focused interfaces over one broad one when consumers only need a subset of the contract.
* **Dependency Inversion (DIP):** Depend on domain abstractions (interfaces in `domain/`), not on concrete implementations (`data/`). Wire concretions at the DI layer only.
* **Atomic Functions:** Keep functions small and focused on a single task.
* **Self-Documenting Names:** Use explicit, descriptive names. Code must be understandable without comments.

### 3. Testing
* **Conventions:** Follow `.ai/shared/TEST_CONVENTIONS.md` for universal test patterns, and the framework-specific conventions in `.ai/frameworks/` for language/framework specifics.

### 4. Layer Decoupling
This project uses a feature-based layered architecture: `domain/` → `data/` → `di/`. Respect these dependency direction rules:

* `domain/` must not import from `data/` or `di/`.
* `data/` may import from `domain/` (to implement its interfaces) but not from `di/`.
* `di/` wires everything together and may import from both layers.
* Screens and components consume services via context hooks — never by importing a service class directly.

Violating these rules creates coupling that defeats the testability and replaceability goals of the architecture. If a violation seems necessary, ask the OWNER before proceeding.

### 5. Change Management
* **Minimal Footprint:** Limit changes strictly to the necessary scope. Do not touch unrelated code.
* **Preserve Existing Logic:** Keep existing logic intact. Seek permission from the OWNER before rewriting.
* **Consistency:** Adhere to established patterns in the codebase over personal preferences.