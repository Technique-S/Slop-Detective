# Orchestrator Checklist

Use this before invoking a stage and again before advancing past it.
The whole point of this checklist is to catch the moment where it would
be tempting to just trust a stage's self-report instead of verifying.

## Before invoking any stage

- [ ] `WORKFLOW_STATE.md` exists and Current Stage matches the stage
      you're about to invoke
- [ ] Every artifact the stage's README.md lists under
      `INPUT_ARTIFACTS` / `REQUIRED_ARTIFACTS` actually exists on disk
- [ ] Those artifacts are non-empty and look like real content, not
      placeholder text left over from a template
- [ ] No unresolved entry in the Failures table blocks this stage

## Before advancing past a stage

- [ ] Every artifact the stage's README.md lists under
      `OUTPUT_ARTIFACTS` exists
- [ ] The stage's own quality gates (listed in its README.md) are met —
      re-check them yourself rather than accepting "done"
- [ ] If the stage is repository-surgeon specifically: build passes and
      tests pass, confirmed by actually running them, not by reading the
      surgeon's claim that it did
- [ ] If the stage is repository-guardian specifically: the approval
      status in FINAL_APPROVAL.md is read and recorded verbatim — don't
      round "conditionally-approved" up to "approved"
- [ ] `WORKFLOW_STATE.md` updated: stage moved to Completed, Current
      Stage advanced, Quality Scores recorded

## If anything above fails

Stop. Write `FAILURE_REPORT.md` from the template. Do not invoke the
next stage. Surface this to the user before doing anything else.
