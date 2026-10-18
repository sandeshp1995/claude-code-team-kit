# The starter CLAUDE.md, explained

Claude Code reads `CLAUDE.md` at the start of every session. Treat it as the short briefing you would give a strong engineer on their first day: facts and rules they need *every* time, nothing more.

> Official reference: https://code.claude.com/docs/en/memory

## Ground rules

- **Keep it under ~200 lines.** The official guidance is to target under 200 lines per file; longer files cost context and Claude follows them less reliably.
- **Be specific and checkable.** "Use `pytest -q path`" beats "test your code". "Never edit `migrations/`" beats "be careful with the database".
- **No contradictions.** If two lines disagree, Claude may pick either. Review the file when conventions change.
- **Procedures belong in skills, not here.** A multi-step workflow ("how we cut a release") should be a skill in `.claude/skills/`. CLAUDE.md is for always-true facts.
- **Part-of-repo rules belong in `.claude/rules/`.** A rule that only matters for, say, `api/**` can live in a path-scoped rule file that loads only when Claude touches those files (see below).

## Section by section

| Section | Why it's there | What good looks like |
|---|---|---|
| Header | Orients Claude on purpose and users, which shapes trade-offs. | Two sentences. No marketing. |
| Commands | The single biggest quality win: Claude can verify its own work. | Exact, copy-pasteable commands, including a *single-file* test command so feedback is fast. |
| Layout | Stops Claude guessing where things live or editing generated code. | 3–8 bullets. Explicit "do not edit" list. |
| Conventions | Encodes the things code review keeps catching. | Rules you'd actually reject an MR for. |
| Workflow | Sets the working style: plan first, tests always, no surprise commits. | Short imperative bullets. |
| Boundaries | Hard limits. | Secrets, dependencies, schemas, CI. |
| Team notes | Tribal knowledge. | Gotchas that cost someone a day once. |

## Useful mechanics

- **Personal overrides:** create `CLAUDE.local.md` next to `CLAUDE.md` for your own preferences and add it to `.gitignore`. It loads after the shared file.
- **Imports:** `@docs/architecture.md` inside CLAUDE.md pulls that file in at launch (relative to the CLAUDE.md, up to four hops deep). Imports organise a file but do **not** reduce its context cost.
- **Path-scoped rules:** put a file in `.claude/rules/` with frontmatter like:

  ```markdown
  ---
  paths:
    - "src/api/**/*.py"
  ---
  # API rules
  - Every endpoint validates input with the shared schema helpers.
  ```

  It loads only when Claude reads or edits a matching file.
- **Monorepos:** a `CLAUDE.md` in a subdirectory loads when Claude works there, on top of the root one.
- **AGENTS.md:** if your repo already has `AGENTS.md` for other tools, Claude Code can read it when no `CLAUDE.md` exists, or you can import it from CLAUDE.md with `@AGENTS.md`.

## A 15-minute way to fill it in

1. Run `/init` in your repo so Claude drafts a version from your code.
2. Merge the useful parts into this template's structure; delete anything generic.
3. Ask two teammates: "What did code review catch most in the last month?" Add those as conventions.
4. Commit it. Revisit when someone says "Claude keeps doing X".
