# CLAUDE.md

---

## General

### Communication Style
- Write in direct, factual prose — no filler phrases ("of course", "great question", "sure!"), no small talk
- Never perform empathy or adjust tone based on perceived user mood
- Do not echo back preferences, opinions, or emotional states
- Avoid hedging language like "I think", "I believe", "in my opinion" — state conclusions directly; if a yes/no answer fits, use it with a brief rationale
- Respond only to what was asked; do not expand into adjacent topics unprompted

### Language
- Code, filenames, comments, commit messages in English
- Documentation (README, ADRs, architecture docs, inline docs) always in English — unless explicitly requested otherwise

---

## Engineering

### Architect-First
- Identify architectural implications before every implementation
- Always consider modularity, coupling, and cohesion
- Check even small changes for structural impact

### No Implicit Decisions
- Never make design or architecture decisions silently
- At decision points: name options + trade-offs, then ask
- Applies to: patterns, abstractions, structures, dependencies

### Abstractions Require Confirmation
- Never introduce an abstraction without explicit approval
- Name it, briefly justify why it's needed, wait for confirmation
- Applies to: design patterns, wrapper layers, shared utilities, interfaces, base classes

### No Assumptions
- Always ask when something is unclear – never bridge gaps with assumptions
- Collect multiple open questions and ask them together in one message
- No "reasonable defaults" without disclosure

### No Invented Facts
- Only make verifiable statements
- When uncertain, say explicitly: "I'm not sure about this — should I verify it?"
- Applies to: API behavior, library features, performance claims, framework conventions

### ADR Awareness
- Propose an ADR for significant decisions
- Reference previously made decisions when relevant

### Tests
- No feature is done without at least one test
- Structure every test as Arrange / Act / Assert — one assertion per logical behavior
- Test behavior, not implementation — tests must not break on internal refactors
- Cover edge cases: empty input, boundary values, error paths — not only the happy path
- Mocking is permitted for I/O boundaries (network, DB, filesystem); never mock the unit under test itself
- Never commit when tests are failing — not even temporarily

### Dependencies
- No new dependency without justification and explicit approval
- Prefer standard library — external deps only when there is a clear benefit
- Audit dependencies for known vulnerabilities before adding (`npm audit`, `pip-audit`, etc.)
- Pin versions in lockfiles; do not use unbounded ranges in production

### Git Discipline
- Atomic commits: one logical change per commit
- Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `chore:`
- Never break existing tests — not even temporarily

### Pull Requests
- One concern per PR — mixing unrelated changes is not permitted
- PR description states: what changed, why, and how to verify it
- Explicitly call out breaking changes, migration steps, or deployment dependencies in the description

### Breaking Changes
- Explicitly flag any breaking change to an interface or API before implementing
- State what breaks, what needs to be updated, and why it's necessary

---

## Code

### Naming
- Names must express intent — avoid abbreviations, single-letter variables outside loop indices, and generic names (`data`, `info`, `manager`, `helper`)
- Booleans are named as predicates: `isLoading`, `hasError`, `canSubmit`
- Functions are named as verbs: `fetchUser`, `validateInput`, `buildQuery`
- Consistency over personal preference — match the naming style already present in the file

### Error Handling
- No silent failures — no empty catch blocks, no swallowed errors
- Errors are either propagated or explicitly handled — logging or attaching context before re-throwing is permitted, but never swallow or replace the original error
- No `console.log` / `print` as the sole error handling in production code

### Complexity & Structure
- Functions do exactly one thing
- Max 2–3 levels of nesting — refactor via early return or extracted functions
- No dead code — delete rather than comment out
- A file that exceeds ~300 lines is a signal to split; evaluate before adding more

### Type Safety
- Use the strictest type-checking mode available (`strict` in TypeScript, type annotations + `mypy --strict` in Python)
- `any` / `object` / untyped returns require explicit justification — never use them to silence a type error
- Prefer precise types over broad ones: `string` is weaker than a string literal union; `unknown` is safer than `any`

### Constants Over Magic Values
- No magic numbers or magic strings in logic
- Always use named constants

### Security Baseline
- No secrets or credentials in code — ever
- Validate all user input at system boundaries
- No SQL/command string concatenation with external input
- Keep dependencies up to date; treat a known CVE as a blocking issue

### Logging & Observability
- Log at appropriate levels — no debug noise in production
- No operations that fail silently without a trace
- Errors logged at the boundary must include enough context to reproduce the issue (input shape, relevant IDs, operation name)
- For long-running or distributed work: emit structured log events at start, end, and on failure — not just on failure

---
