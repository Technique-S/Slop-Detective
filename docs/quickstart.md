# Quickstart

Five steps from "installed" to "reviewed and approved."

## Step 1 — Install the skill suite

Follow [`installation.md`](./installation.md). The short version:

```bash
cp -r skills/repository-auditor skills/repository-surgeon \
      skills/documentation-architect skills/repository-guardian \
      skills/repository-orchestrator ~/.claude/skills/
```

## Step 2 — Run the orchestrator

Open Claude Code in the repository you want to improve, and ask:

> Run Repository Excellence Suite on this repository.

or, equivalently:

> Use repository-orchestrator to audit, refactor, document, and review
> this codebase end to end.

The orchestrator will initialize `WORKFLOW_STATE.md` and begin Stage 1
(`repository-auditor`) automatically. You don't need to invoke the
other four skills yourself — the orchestrator hands artifacts between
them and checks each stage's quality gate before advancing.

## Step 3 — Review outputs as they're produced

Each stage finishes with a distinct set of files at your repository
root. Worth reading at each checkpoint:

| After this stage | Read this first |
|---|---|
| repository-auditor | `REPOSITORY_SCORECARD.md` |
| repository-surgeon | `REFACTOR_SUMMARY.md` |
| documentation-architect | `README.md` (the new one it generated for your project) |
| repository-guardian | `FINAL_APPROVAL.md` |

You can interrupt at any checkpoint — `WORKFLOW_STATE.md` tracks
progress, so asking the orchestrator to continue later picks up exactly
where it left off rather than restarting.

## Step 4 — Approve (or push back on) the changes

Before merging anything, look at `CHANGESET.md` (from
repository-surgeon) the way you'd look at a pull request diff. If
something looks wrong, you don't need to accept it wholesale — you can
ask Claude to revert a specific entry from `REFACTOR_LOG.md` using its
recorded rollback method, or ask repository-guardian to take another
look at a specific concern before you approve.

## Step 5 — Read the final review

`FINAL_APPROVAL.md` will say one of three things:

- **`approved`** — the pipeline considers the repository
  production-ready. Read `FINAL_REVIEW.md` and `QUALITY_SCORECARD.md`
  for the reasoning behind that call.
- **`conditionally-approved`** — there are specific, listed conditions
  to resolve first. These point back to findings in `FINAL_REVIEW.md`
  or `REGRESSION_REPORT.md`.
- **`rejected`** — something blocking was found. The blocking issues
  are listed explicitly, usually with a recommendation to send a
  specific change back through repository-surgeon.

That's the whole loop. For a deeper look at what each stage actually
does and why the order matters, see [`pipeline.md`](./pipeline.md).
