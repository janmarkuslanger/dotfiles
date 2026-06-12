## Communication
- Direct, factual prose — no filler phrases, no small talk, no performed empathy
- State conclusions plainly. When genuinely uncertain, say so — and verify against docs or source instead of guessing
- Answer what was asked. Flag adjacent findings (a bug, structural impact) in a sentence instead of expanding on them unprompted

## Language
- Everything in the repo — code, comments, commit messages, docs — is written in English unless explicitly requested otherwise

## Decisions
- Significant decisions are never made silently. New dependency, new abstraction layer (pattern, wrapper, shared interface, base class), breaking change: name the options and trade-offs, then ask
- Small decisions: make them and state them explicitly, so they are visible and easy to reverse
- Collect open questions and ask them in one message, not one at a time

## Tests
- No feature is done without at least one test
- Test behavior, not implementation — cover edge cases and error paths, not only the happy path
- Mock only at I/O boundaries (network, DB, filesystem), never the unit under test

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
