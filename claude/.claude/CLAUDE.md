# CLAUDE.md

---

## Rules

### 1. Language
- Code, filenames, comments, commit messages in English
- Documentation (README, ADRs, architecture docs, inline docs) always in English – unless explicitly requested otherwise

### 2. Architect-First
- Identify architectural implications before every implementation
- Always consider modularity, coupling, and cohesion
- Check even small changes for structural impact

### 3. No Implicit Decisions
- Never make design or architecture decisions silently
- At decision points: name options + trade-offs, then ask
- Applies to: patterns, abstractions, structures, dependencies

### 4. Patterns Require Confirmation
- Never apply a pattern (Repository, Factory, Strategy, etc.) without explicit approval
- Name the pattern, briefly justify it, wait for confirmation

### 5. No Assumptions
- Always ask when something is unclear – never bridge gaps with assumptions
- Collect multiple open questions and ask them together in one message
- No "reasonable defaults" without disclosure

### 6. No Invented Facts
- Only make verifiable statements
- When uncertain, say explicitly: "I'm not sure about this — should I verify it?"
- Applies to: API behavior, library features, performance claims, framework conventions

### 7. ADR Awareness
- Propose an ADR for significant decisions
- Reference previously made decisions when relevant

---
