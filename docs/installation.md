# Installation

Repository Excellence Suite ships as five Claude Code skills under
[`skills/`](../skills/). Each one is a self-contained folder — install
them by copying into a Claude Code skills directory.

## Global Installation

Installs the suite for every project on your machine.

```bash
git clone https://github.com/<your-org>/repository-excellence-suite.git
cd repository-excellence-suite

mkdir -p ~/.claude/skills
cp -r skills/repository-auditor ~/.claude/skills/
cp -r skills/repository-surgeon ~/.claude/skills/
cp -r skills/documentation-architect ~/.claude/skills/
cp -r skills/repository-guardian ~/.claude/skills/
cp -r skills/repository-orchestrator ~/.claude/skills/
```

Your skills directory should now look like:

```
~/.claude/skills/
├── repository-auditor/
├── repository-surgeon/
├── documentation-architect/
├── repository-guardian/
└── repository-orchestrator/
```

## Project Installation

Installs the suite for a single project only — useful if you want to
pin a specific version per-repository, or you don't have (or want)
global skill access.

```bash
cd your-project
mkdir -p .claude/skills
cp -r /path/to/repository-excellence-suite/skills/repository-auditor .claude/skills/
cp -r /path/to/repository-excellence-suite/skills/repository-surgeon .claude/skills/
cp -r /path/to/repository-excellence-suite/skills/documentation-architect .claude/skills/
cp -r /path/to/repository-excellence-suite/skills/repository-guardian .claude/skills/
cp -r /path/to/repository-excellence-suite/skills/repository-orchestrator .claude/skills/
```

Resulting layout:

```
your-project/
├── .claude/
│   └── skills/
│       ├── repository-auditor/
│       ├── repository-surgeon/
│       ├── documentation-architect/
│       ├── repository-guardian/
│       └── repository-orchestrator/
└── (your existing project files)
```

> **Note:** the exact skills directory Claude Code reads from can vary
> by client/version. If `~/.claude/skills/` or `.claude/skills/` isn't
> picked up automatically, check your Claude Code client's
> documentation for the currently-correct skills path, and use that
> instead.

## Partial Installation

You don't have to install all five. If you only ever want the read-only
audit, for example, just copy `skills/repository-auditor/` on its own —
each skill works independently. You only need `repository-orchestrator`
if you want the full four-stage pipeline run automatically.

## Verification Steps

1. Restart or reload Claude Code so it picks up the new skills
   directory contents.
2. Ask: *"What skills do you have available?"* or *"List your
   skills."* — `repository-auditor`, `repository-surgeon`,
   `documentation-architect`, `repository-guardian`, and
   `repository-orchestrator` should all appear.
3. Try a low-risk smoke test: *"Use repository-auditor to audit this
   repository, read-only."* You should see it produce the nine report
   files described in
   [`skills/repository-auditor/README.md`](../skills/repository-auditor/README.md).

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Skill doesn't appear in the skill list | Wrong skills directory, or Claude Code not reloaded | Confirm the path matches what your Claude Code client expects; restart the client |
| Skill appears but never triggers | The request doesn't match the skill's description closely enough | Be explicit: name the skill directly, e.g. "use repository-auditor to..." |
| Orchestrator runs but stages don't hand off correctly | `WORKFLOW_STATE.md` got hand-edited in a Completed Stages or Quality Scores field | Those fields are orchestrator-managed; if corrupted, delete `WORKFLOW_STATE.md` and restart the pipeline from stage one |
| A stage refuses to start | A required upstream artifact is missing or empty | Check [`../orchestrator/artifact_contracts.md`](../orchestrator/artifact_contracts.md) for that stage's required inputs, and confirm the previous stage actually produced them |
| Build/test verification fails in repository-surgeon | Build or test command not found, or test suite was already failing pre-refactor | Confirm the commands work manually first; if tests were already failing, that's noted rather than blocking — but new failures introduced during refactoring are not |

## Recommended Folder Layout

For teams adopting this suite across multiple repositories, a project
installation per-repo (pinned to a specific suite version via your
normal dependency/vendoring process) is usually more predictable than a
shared global install, since the suite's quality gates and templates
can evolve between releases. See [`CHANGELOG.md`](../CHANGELOG.md) for
version history before upgrading an existing installation.
