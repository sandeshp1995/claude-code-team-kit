# Claude Code Team Kit (free edition)

Drop-in files that make Claude Code behave consistently across your whole team: a starter `CLAUDE.md`, three slash commands, and a code-review skill. Copy them into a repo, fill in the placeholders, commit, and everyone on the team gets the same setup.

Written for engineering teams and tech leads who already use [Claude Code](https://code.claude.com/docs) and want fewer "it did something weird again" moments.

## What's inside

| Path | What it is | How you use it |
|---|---|---|
| `CLAUDE.md` | Starter project instructions: commands, layout, conventions, workflow, boundaries | Fill in the `<placeholders>` |
| `docs/claude-md-explained.md` | Why each section exists and how to write it well | Read once |
| `.claude/skills/commit-msg/` | Writes a commit message from your staged diff, matching your repo's style | `/commit-msg [ticket]` |
| `.claude/skills/explain/` | Explains a file or module to a new joiner, with `file:line` references | `/explain src/billing/` |
| `.claude/skills/plan-task/` | Turns a pasted task into a file-by-file implementation plan | `/plan-task <paste>` |
| `.claude/skills/code-review-basics/` | A review checklist Claude uses when you ask it to review changes | "Review my branch" or `/code-review-basics` |
| `.claude/settings.json` | Safe defaults: read-only git commands allowed, `.env` files blocked | Merge into yours |

All commands are Claude Code **skills** (`.claude/skills/<name>/SKILL.md`), the current format for custom slash commands. The three task commands use `disable-model-invocation: true`, so they only run when you type them.

## Install

**Option A: script** (macOS, Linux, WSL, Git Bash)

```bash
git clone https://github.com/sandeshp1995/claude-code-team-kit.git
./claude-code-team-kit/install.sh /path/to/your/repo
```

The script never overwrites existing files (pass `--force` if you want it to).

**Option B: by hand.** Copy `.claude/skills/` and `CLAUDE.md` into your repo root. If you already have a `.claude/settings.json`, merge the `permissions` block instead of replacing your file.

Then:

1. Fill in `CLAUDE.md`. Running `/init` first gives you a draft to merge in (see `docs/claude-md-explained.md`).
2. Commit `CLAUDE.md` and `.claude/`.
3. Start `claude` in the repo and type `/` to see the new commands.

## Customize

- **Change a command:** edit its `SKILL.md`. The frontmatter controls behaviour (`description`, `allowed-tools`, `disable-model-invocation`); the body is the prompt.
- **Add your own command:** create `.claude/skills/<name>/SKILL.md`. Copy `explain` as a starting point.
- **Personal tweaks:** put them in `CLAUDE.local.md` (gitignored), not in the shared file.

Official docs: [Skills](https://code.claude.com/docs/en/skills) · [CLAUDE.md and memory](https://code.claude.com/docs/en/memory) · [Settings](https://code.claude.com/docs/en/settings)

## Pro edition

The [Pro edition](https://racecraft9.gumroad.com/l/claude-code-team-kit) is the full team setup:

- **Stack templates**: a tuned Python `CLAUDE.md` with path-scoped rules for tests, APIs and migrations (more stacks coming)
- **8 team workflow commands**: `/review`, `/mr-description`, `/release-notes`, `/test-changed`, `/safe-refactor`, `/onboard`, `/ticket-to-plan`, `/mr-status`
- **4 deep review checklists**: security, performance, accessibility, API design, plus a read-only reviewer subagent
- **Team rollout guide**: how a tech lead introduces Claude Code to a team in two weeks, with conventions and do's and don'ts
- **Jira and GitLab helpers**: turn a ticket into a plan, or a merge request into a stakeholder update

One-time purchase, free updates for the v1 line.

## Compatibility

Checked against the Claude Code documentation as of October 2026. Claude Code changes quickly; if something stops working, please open an issue.

## License

MIT. See [LICENSE](LICENSE). Not affiliated with or endorsed by Anthropic. "Claude" and "Claude Code" are trademarks of Anthropic, PBC.
