# Project: <PROJECT NAME>

<One or two sentences: what this service/app does and who uses it.>

## Commands

- Install: `<e.g. make install>`
- Run locally: `<e.g. make dev>`
- Test (all): `<e.g. make test>`
- Test (one file): `<e.g. pytest path/to/test_file.py -q>`
- Lint + format: `<e.g. make lint>`
- Type check: `<e.g. make typecheck>`

Run the single-file test and lint commands after every change. Run the full suite before saying a task is done.

## Layout

- `<src/>`: application code
- `<tests/>`: tests mirror the `src/` layout
- `<docs/>`: architecture notes and ADRs
- Do not edit: `<generated/, vendor/, migrations already applied>`

## Conventions

- <Naming rule, e.g. "snake_case for files, PascalCase for classes">
- <Error-handling rule, e.g. "raise domain errors from services; translate to HTTP only in the API layer">
- <Logging rule, e.g. "use the shared logger; never print">
- Match the style of the surrounding code over personal preference.
- Prefer small, focused changes. Do not reformat files you are not otherwise changing.

## Workflow

- Before a non-trivial change, state a short plan and the files you expect to touch.
- Add or update tests for every behaviour change.
- Never commit, push, or open a merge request unless asked.
- Commit messages: <e.g. Conventional Commits: `feat: ...`, `fix: ...`>.
- If a requirement is ambiguous, ask one clear question instead of guessing.

## Boundaries

- Never read, print, or commit secrets. `.env*` files are off limits.
- Do not add new dependencies without saying why and asking first.
- Do not change public APIs, database schemas, or CI config without explicit approval.

## Team notes

- <Gotchas a new joiner would trip over, e.g. "the payments sandbox resets nightly at 02:00 UTC">
