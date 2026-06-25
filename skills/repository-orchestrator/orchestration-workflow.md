# Orchestration Workflow

A detailed, step-by-step walkthrough of how repository-orchestrator
should run. SKILL.md has the condensed version; this is the expanded
reference. See `../../../orchestrator/pipeline.md` for the full
pipeline documentation shared across all stages.

## Phase 0 — Initialize or resume

1. Look for `WORKFLOW_STATE.md` in the target repository's root.
2. If absent, create it from `templates/WORKFLOW_STATE_TEMPLATE.md`,
   set Current Stage to `repository-auditor`, mark all stages Pending.
3. If present, read it and resume from the recorded Current Stage.
   Resolve any unresolved Failures before advancing.

## Phase 1 — Run each stage with validation gates between them

For each of the four stages, in order:

1. **Check prerequisites** — verify every required input artifact for
   this stage (per `../../../orchestrator/artifact_contracts.md`)
   exists and is non-empty. If not, halt and report what's missing
   rather than guessing or proceeding anyway.
2. **Invoke the stage** — hand it the repository and its required
   inputs. Don't intervene in its internal methodology.
3. **Validate outputs** — verify every required output artifact for
   this stage exists, and check the stage's quality gates from
   `../../../orchestrator/quality_gates.md` directly, rather than
   trusting the stage's own "done" signal.
4. **Update `WORKFLOW_STATE.md`** — move the stage to Completed,
   advance Current Stage, record Quality Scores and Artifact Status.
5. **If validation fails** — write `FAILURE_REPORT.md`, record the
   failure in `WORKFLOW_STATE.md`, and stop. Do not advance to the next
   stage.

## Phase 2 — Final state

Once repository-guardian's `FINAL_APPROVAL.md` exists:

1. Record its approval status verbatim in `WORKFLOW_STATE.md` —
   `approved`, `conditionally-approved`, and `rejected` are NOT
   interchangeable; only `approved` means the pipeline is complete.
2. If approved, mark the pipeline Completed and summarize for the user:
   what changed, what's now documented, where the final reports live.
3. If conditionally-approved or rejected, summarize exactly what's
   blocking, citing the specific items from `FINAL_APPROVAL.md`.

## Common pitfalls

- Advancing a stage because it claims success, without independently
  checking its quality gates.
- Letting a partially-failed stage's output get silently passed to the
  next stage instead of halting.
- Treating a conditional approval as equivalent to a full approval when
  reporting back to the user.
