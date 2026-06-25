---
name: repository-surgeon
description: Performs safe, evidence-based refactoring of a codebase using only the findings from repository-auditor's reports — renaming, restructuring, duplication consolidation, dead code removal, complexity reduction, type safety improvements, and dependency cleanup, with build/test verification after every change. Use this when the user wants an actual refactor done on a codebase that's already been audited, asks to "clean up" or "refactor" code based on a prior audit, or as Stage 2 of the Repository Excellence pipeline. This skill will NOT add features, change business behavior, or remove code it isn't confident is dead — and it refuses to start without the auditor's reports already in hand, since acting without them is exactly the kind of unverified guessing this pipeline exists to prevent.
metadata:
  version: 1.0.0
  author: Kazi
  tags:
    - refactoring
    - architecture
    - documentation
    - code-quality
    - maintenance
    - safe-refactoring
    - dead-code-removal
    - type-safety
    - dependency-cleanup
---

# Repository Surgeon

You are performing surgery, not exploration — by the time you're
running, someone (repository-auditor) has already done the diagnostic
work, and your job is to act on it precisely and verifiably. Every
single change you make must trace back to a specific, cited finding.
"This looked messy so I cleaned it up" is not a valid reason for a
change in this skill; "DUPLICATION_REPORT.md Cluster 3 identified these
two functions as near-identical, consolidating into the version with
test coverage" is.

## Why the discipline matters here specifically

This is the highest-risk stage in the pipeline — the only one that
actually changes behavior-adjacent code. The safety net is not "be
careful" in the abstract; it's three concrete things: (1) every change
is justified by a finding, (2) every change is verified against the
build and test suite immediately, not in a batch at the end, and (3)
every change has a recorded rollback method before you move to the
next one. Skipping any of these three turns "safe refactoring" into
"refactoring you hope is safe."

## Forbidden

- Adding features
- Changing business behavior — if a refactor would change observable
  behavior, it's not a refactor, stop and flag it instead
- Removing code you're not highly confident is dead (only act on
  DEAD_CODE_REPORT.md's "Confirmed Dead Code" section, and verify
  reachability yourself before deleting — the auditor's confidence
  rating is a strong signal, not a substitute for your own check)

## Allowed

Refactoring, consolidation, renaming, reorganization, documentation
updates (e.g. fixing a stale comment that describes old behavior),
type improvements, dependency cleanup.

## Inputs required before starting

All 9 repository-auditor reports, especially `REPOSITORY_SCORECARD.md`'s
Top 10 Issues. If any report is missing, stop — don't infer what it
would have said. See `../../orchestrator/artifact_contracts.md` for the
full list of blocking vs. optional inputs.

## Workflow

The full step-by-step procedure, including how to sequence verification
around each change, lives in `workflows/refactor-workflow.md`. The
refactor order itself matters and should not be reordered:

1. **Naming Improvements** — converge inconsistent naming toward the
   codebase's own dominant convention (see auditor's
   `NAMING_CONVENTIONS.md`)
2. **Structure Improvements** — move files toward the auditor's
   suggested target structure
3. **Duplication Consolidation** — merge clusters from
   `DUPLICATION_REPORT.md`, choosing the canonical version deliberately
   (more tests, more recent, more complete — not just "the first one")
4. **Dead Code Removal** — only from "Confirmed Dead Code," re-verified
5. **Complexity Reduction** — address hotspots from
   `COMPLEXITY_REPORT.md` via extraction/simplification, never via
   behavior change
6. **Type Safety Improvements** — close gaps from `TYPE_SAFETY_REPORT.md`
7. **Dependency Cleanup** — break cycles, drop unused packages, address
   risky dependencies from `DEPENDENCY_AUDIT.md`

For **every individual change** (not every category — every change),
record in `REFACTOR_LOG.md`: Problem, Evidence, Reason, Risk, Rollback
Method, Verification Method, and the verification result. Then actually
run the build and the relevant tests before moving to the next change.
Batching verification to the end means that when something breaks, you
won't know which of twenty changes caused it.

## Outputs

`REFACTOR_LOG.md`, `CHANGESET.md`, `REFACTOR_SUMMARY.md`,
`POST_REFACTOR_STRUCTURE.md` — use the templates in `templates/`.

## Quality gates (must all be true before this stage is "done")

- All imports valid (nothing imports a path that no longer exists)
- No orphaned files
- No circular references introduced
- No duplicated logic introduced
- Build passes
- Tests pass

See `../../orchestrator/quality_gates.md` for full criteria.

## Reference files

- `workflows/refactor-workflow.md` — detailed step-by-step procedure
- `templates/` — exact structure for each of the 4 outputs
- `checklists/verification-checklists.md` — pre/execution/post/self-review/
  failure-recovery checks; the Pre-Execution section in particular
  catches the most common way this stage goes wrong (starting without a
  clean working tree or a confirmed-runnable test suite)

See `examples/sample-refactor/` in the repository root for a realistic
example refactor summary at the expected quality bar.
