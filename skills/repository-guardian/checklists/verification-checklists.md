# repository-guardian — Verification Checklists

## Pre-Execution Checklist

- [ ] All 9 auditor reports present
- [ ] All 4 surgeon outputs present
- [ ] All 10 documentation-architect outputs present
- [ ] Confirmed access to the actual repository, not just the reports
      about it — this review is independent verification, which is
      impossible without reading the real code

## Execution Checklist

- [ ] Architecture independently re-traced, not just read about
- [ ] A sample of REFACTOR_LOG.md entries (prioritize dead code removal
      and dependency cleanup — highest risk categories) independently
      re-verified against the actual diff
- [ ] A sample of documentation entries independently spot-checked
      against actual source
- [ ] Test suite run independently, results compared against what
      repository-surgeon claimed
- [ ] Dependency graph re-generated independently and compared against
      DEPENDENCY_MAP.md for discrepancies
- [ ] Searched specifically for: new duplication, new dead code, new
      architecture violations, regressions in behavior

## Post-Execution Checklist

- [ ] FINAL_REVIEW.md covers all required sections: architecture,
      refactor, documentation, naming, complexity, dead code,
      dependencies, functionality preservation
- [ ] QUALITY_SCORECARD.md scores are independently re-assessed, not
      copied from the auditor's original scorecard
- [ ] REGRESSION_REPORT.md's Functionality Preservation Verdict is
      explicit (not implied) — either "preserved" or a specific list of
      what wasn't
- [ ] FINAL_APPROVAL.md's approval status is one of approved /
      conditionally-approved / rejected, with a basis that traces to
      the other three documents

## Self-Review Checklist

- [ ] Before finalizing FINAL_APPROVAL.md, ask: if I'm wrong about
      "approved" and something breaks in production, what would I have
      needed to check that I didn't? If there's a real answer to that,
      go check it now
- [ ] Re-read the Quality Gate Status sections from all three earlier
      stages — does this review actually confirm those gates were met,
      or did it just take their word for it?

## Failure Recovery Checklist

- [ ] If a critical issue or severe regression is found: do NOT approve.
      Set status to rejected or conditionally-approved, list the
      specific blocking issues, and recommend which stage needs to
      re-run (often repository-surgeon, to apply a fix and re-verify)
- [ ] If this review itself can't be completed (e.g. test suite won't
      run in this environment, repository access is incomplete): say so
      explicitly in FINAL_APPROVAL.md rather than defaulting to
      "approved" by omission — an incomplete review is not the same as
      a clean one
