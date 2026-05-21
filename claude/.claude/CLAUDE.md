# CLAUDE.md

---

## Engineering

### 1. Architect-First
- Identify architectural implications before every implementation
- Always consider modularity, coupling, and cohesion
- Check even small changes for structural impact

### 2. No Implicit Decisions
- Never make design or architecture decisions silently
- At decision points: name options + trade-offs, then ask
- Applies to: patterns, abstractions, structures, dependencies

### 3. Abstractions Require Confirmation
- Never introduce an abstraction without explicit approval
- Name it, briefly justify why it's needed, wait for confirmation
- Applies to: design patterns, wrapper layers, shared utilities, interfaces, base classes

### 4. No Assumptions
- Always ask when something is unclear – never bridge gaps with assumptions
- Collect multiple open questions and ask them together in one message
- No "reasonable defaults" without disclosure

### 5. No Invented Facts
- Only make verifiable statements
- When uncertain, say explicitly: "I'm not sure about this — should I verify it?"
- Applies to: API behavior, library features, performance claims, framework conventions

### 6. ADR Awareness
- Propose an ADR for significant decisions
- Reference previously made decisions when relevant

### 7. Tests
- No feature is done without at least one test
- Test edge cases, not only the happy path
- Never commit when tests are failing

### 8. Dependencies
- No new dependency without justification and explicit approval
- Prefer standard library — external deps only when there is a clear benefit

### 9. Git Discipline
- Atomic commits: one logical change per commit
- Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `chore:`
- Never break existing tests — not even temporarily

### 10. Breaking Changes
- Explicitly flag any breaking change to an interface or API before implementing
- State what breaks, what needs to be updated, and why it's necessary

---

## Code

### 1. Language
- Code, filenames, comments, commit messages in English
- Documentation (README, ADRs, architecture docs, inline docs) always in English — unless explicitly requested otherwise

### 2. Error Handling
- No silent failures — no empty catch blocks, no swallowed errors
- Errors are either propagated or explicitly handled — never both, never neither
- No `console.log` / `print` as error handling in production code

### 3. Complexity & Structure
- Functions do exactly one thing
- Max 2–3 levels of nesting — refactor via early return or extracted functions
- No dead code — delete rather than comment out

### 4. Constants Over Magic Values
- No magic numbers or magic strings in logic
- Always use named constants

### 5. Security Baseline
- No secrets or credentials in code — ever
- Validate all user input at system boundaries
- No SQL/command string concatenation with external input

### 6. Logging
- Log at appropriate levels — no debug noise in production
- No operations that fail silently without a trace

---
