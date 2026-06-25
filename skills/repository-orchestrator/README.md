# repository-orchestrator

The single entry point for the Repository Excellence Suite. Users
install and invoke this one skill; it coordinates the other four
behind the scenes and enforces every quality gate between them.

**Version:** 1.0.0 · **Tags:** refactoring, architecture, documentation,
code-quality, maintenance, orchestration, pipeline-automation,
workflow-management

## Why a separate orchestrator

The four worker stages have deliberately conflicting incentives if you
let them run unsupervised:

- The auditor is rewarded for finding *everything*, including things
  that turn out to be false positives.
- The surgeon is rewarded for fixing things, which left unchecked tends
  toward over-eager changes.
- The documentation-architect just writes down whatever it's told,
  accurate or not.
- The guardian's entire job is to distrust the other three.

A single skill trying to do all of this at once tends to blur those
boundaries — "I'll just fix this while I'm auditing it" is the most
common failure mode in these kinds of pipelines. The orchestrator's
entire value is refusing to let that happen, while giving the user one
simple command to run instead of four.

## Pipeline

```
repository-auditor → repository-surgeon → documentation-architect → repository-guardian
```

Full documentation: [`../../orchestrator/pipeline.md`](../../orchestrator/pipeline.md)

## Input artifacts

None at start — this is the entry point. On resume, it reads whatever
`WORKFLOW_STATE.md` already exists in the target repository's root.

## Output artifacts

- `WORKFLOW_STATE.md` — kept current throughout the run
- `FAILURE_REPORT.md` — only if a stage's quality gate fails

## Required artifacts before advancing each stage

| Advancing to | Requires from previous stage |
|---|---|
| repository-surgeon | All 9 auditor reports + REPOSITORY_SCORECARD.md |
| documentation-architect | REFACTOR_LOG.md, CHANGESET.md, POST_REFACTOR_STRUCTURE.md; build & tests passing |
| repository-guardian | All 10 documentation-architect outputs |
| Pipeline complete | FINAL_APPROVAL.md with an approved status |

Full contract: [`../../orchestrator/artifact_contracts.md`](../../orchestrator/artifact_contracts.md)

## Blocking conditions

The orchestrator halts the pipeline (does not invoke the next stage) if:
- Required artifacts from the current stage are missing or empty
- A stage's own quality gates aren't met
- The guardian rejects or conditionally approves the final state

In every blocking case, a `FAILURE_REPORT.md` is produced and the user is
told exactly what's blocking progress and what would unblock it.

## Resuming a partial run

This pipeline is designed to be safely interrupted and resumed at any
stage. As long as `WORKFLOW_STATE.md` is intact, re-invoking this skill
will pick up exactly where it left off rather than re-running completed
stages.

## Folder contents

```
repository-orchestrator/
├── SKILL.md
├── README.md          (this file)
├── workflows/
│   └── orchestration-workflow.md
├── templates/
│   ├── WORKFLOW_STATE_TEMPLATE.md
│   └── FAILURE_REPORT_TEMPLATE.md
└── checklists/
    └── orchestrator-checklist.md
```
