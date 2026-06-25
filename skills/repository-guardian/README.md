# repository-guardian

Stage 4 (final) of the Repository Excellence pipeline. An independent
review that re-verifies everything the previous three stages claimed,
rather than trusting their self-reports.

**Version:** 1.0.0 · **Tags:** refactoring, architecture, documentation,
code-quality, maintenance, quality-assurance, code-review,
regression-testing

## Mission

Act as the final reviewer. Never trust previous skills. Independently
verify everything.

## Input artifacts (required)

| Artifact | From |
|---|---|
| All 9 audit reports | repository-auditor |
| All 4 refactor outputs | repository-surgeon |
| All 10 documentation outputs | documentation-architect |
| The entire repository | the repo itself |

See [`../../orchestrator/artifact_contracts.md`](../../orchestrator/artifact_contracts.md)
for the full contract.

## Output artifacts

| Artifact | Description |
|---|---|
| `FINAL_REVIEW.md` | Independent re-verification across every category |
| `QUALITY_SCORECARD.md` | Re-assessed scores, before/after, threshold check |
| `REGRESSION_REPORT.md` | Regressions and new issues introduced, with a functionality-preservation verdict |
| `FINAL_APPROVAL.md` | approved / conditionally-approved / rejected, with a traceable basis |

`FINAL_APPROVAL.md`'s status is what the orchestrator checks to decide
whether the pipeline is actually complete.

## What this stage verifies (not just reads)

Architecture, refactors, documentation, naming, complexity, dead code,
dependencies, functionality preservation. For each, the standard is
independent confirmation — re-running tests, re-tracing dependency
graphs, re-checking diffs — not summarizing what earlier stages
self-reported.

## What this stage detects

Missed issues, regressions, unsafe changes, new duplication, new dead
code, architecture violations introduced by the pipeline itself.

## Quality gates

- [ ] No critical issues
- [ ] No severe regressions
- [ ] Documentation complete
- [ ] Architecture valid
- [ ] Functionality preserved
- [ ] Quality score above threshold

## Folder contents

```
repository-guardian/
├── SKILL.md
├── README.md          (this file)
├── workflows/
│   └── review-workflow.md
├── templates/          (one per output document)
└── checklists/
    └── verification-checklists.md
```

## Handoff

This is the terminal stage. If `FINAL_APPROVAL.md` is anything other
than `approved`, the orchestrator treats the pipeline as not complete —
it doesn't round a conditional approval up to a full one.

See [`examples/sample-final-review/`](../../examples/sample-final-review/)
for a realistic example of expected output quality.
