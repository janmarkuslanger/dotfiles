## Communication
- Direct, factual prose — no filler phrases, no small talk, no performed empathy
- State conclusions plainly. When genuinely uncertain, say so — and verify against docs or source instead of guessing
- Answer what was asked. Flag adjacent findings (a bug, structural impact) in a sentence instead of expanding on them unprompted

## Language
- Everything in the repo — code, comments, commit messages, docs — is written in English unless explicitly requested otherwise

## Decisions
- Classify decisions by reversibility: one-way doors (DB schemas, public APIs, wire/persistence formats, framework choices) are never decided silently — name the options and trade-offs, then ask
- Two-way doors: decide, and state the decision explicitly so it stays visible and easy to reverse
- Collect open questions and ask them in one message, not one at a time

## Architecture
- Impact is measured by reach, not diff size: a one-line change to a shared interface is a change to every implementer and call site. A design sketch (3–5 sentences: what is touched, where the change lives and why there, what was rejected) is required when a change (a) touches a contract others depend on — interface, public signature, shared type, schema, wire format, base class — (b) adds new files or new module interactions, or (c) grows past ~50 lines
- Before editing a contract, enumerate its consumers first and state the blast radius (implementers, call sites); update all of them in the same change, or flag explicitly why not
- Dependencies point in one direction: core/domain logic never imports infrastructure (HTTP, DB, UI, framework glue); no circular imports
- Side effects (I/O, network, DB, filesystem) live at the boundaries — keep core logic pure
- Stop and flag instead of pushing through when a structural smell appears: one concern requires edits in 3+ modules, an import would cross a layer boundary, a module's responsibility no longer fits in one sentence, the same logic appears a third time
- Structure for current requirements, not hypothetical ones — extensibility needs a named, concrete upcoming use case

## Tests
- No feature is done without at least one test — in projects without test infrastructure, flag the gap instead of skipping silently
- Test behavior, not implementation — cover edge cases and error paths, not only the happy path
- Mock only at I/O boundaries (network, DB, filesystem), never the unit under test

## Verification
- "Done" means verified: run the relevant checks (tests, linter, build) and report their actual output — never claim success on assumption; if something could not be verified, say so and why

## Dependencies
- Prefer the standard library. A new dependency needs a clear benefit and explicit approval
- Audit new dependencies for known vulnerabilities (`npm audit`, `pip-audit`, …); a known CVE is blocking

## Git & Pull Requests
- Atomic commits — one logical change per commit, Conventional Commits style (`feat:`, `fix:`, `refactor:`, `test:`, `chore:`)
- Never commit with failing tests
- One concern per PR. The description covers what changed, why, and how to verify; breaking changes and migration steps are called out explicitly

## Code
- Never swallow errors — propagate or handle them explicitly, with enough context to debug
- Match the project's existing type strictness; never silence a type error with `any` or an unchecked cast
- A file growing past ~300 lines is a signal to split it before adding more
