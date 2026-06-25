# repository-surgeon — Verification Checklists

## Pre-Execution Checklist

- [ ] All 9 auditor reports exist and are non-empty
- [ ] REPOSITORY_SCORECARD.md's Top 10 Issues read and understood
- [ ] Version control is clean (no uncommitted changes) so every refactor
      change can be cleanly attributed and rolled back — if it isn't,
      stop and ask the user to commit or stash first
- [ ] Test suite located and confirmed runnable BEFORE any change is made
      (run it once now to get a baseline — if it's already failing,
      that's not this stage's problem to fix, but it changes what
      "tests pass" can mean going forward)
- [ ] Build command located and confirmed runnable

## Execution Checklist

- [ ] Refactor steps are being applied in order: Naming → Structure →
      Duplication Consolidation → Dead Code Removal → Complexity
      Reduction → Type Safety → Dependency Cleanup
- [ ] Every change traces back to a specific finding in the auditor's
      reports — nothing is being changed "while I'm in here" without a
      cited finding
- [ ] No new feature is being added; no business behavior is changing
- [ ] No deletion happens against anything from DEAD_CODE_REPORT.md's
      "Suspected Dead Code" or "Explicitly Excluded" sections — only the
      "Confirmed Dead Code" section justifies deletion, and even then,
      double-check reachability yourself before deleting
- [ ] After each individual change (not each category — each change):
      build run, tests run, result logged in REFACTOR_LOG.md
- [ ] Rollback method recorded in REFACTOR_LOG.md before moving to the
      next change, not after several changes have piled up

## Post-Execution Checklist

- [ ] REFACTOR_LOG.md has one entry per change, fully filled in
- [ ] CHANGESET.md accounts for every file touched, added, or deleted
- [ ] REFACTOR_SUMMARY.md's "What Was Deliberately NOT Changed" section
      is filled in — silence here would look like an oversight later
- [ ] POST_REFACTOR_STRUCTURE.md generated and mapped against the
      auditor's suggested target structure
- [ ] Full build run one final time, full test suite run one final time,
      both passing
- [ ] No orphaned imports (something imports a file that no longer
      exists at that path)
- [ ] No new circular dependency introduced (re-check the dependency
      graph, don't just assume reorganization didn't create one)
- [ ] No duplicated logic introduced as a side effect of "consolidating"
      (e.g. copy-pasting the canonical version into a new location
      instead of properly importing/referencing it)

## Self-Review Checklist

- [ ] Pick 3 changes at random from REFACTOR_LOG.md and verify the
      "Change made" actually matches what's in the diff
- [ ] Confirm the net diff in CHANGESET.md trends toward less code, less
      duplication, less complexity — if it grew instead, that needs an
      explanation, not just a number
- [ ] Re-read the Before/After Scorecard Comparison in
      REFACTOR_SUMMARY.md — does every "After" score that improved have
      a corresponding entry in REFACTOR_LOG.md that explains why?

## Failure Recovery Checklist

- [ ] If a change breaks the build or tests: roll it back immediately
      using the recorded rollback method, log the failure in
      REFACTOR_LOG.md with verification result "fail," and move to the
      next change rather than trying to force it through
- [ ] If a whole category of changes turns out to be too risky given
      test coverage (e.g. dead code removal in a module with zero
      tests): stop that category, document why in REFACTOR_SUMMARY.md's
      "Deliberately NOT Changed" section, and continue with the
      remaining categories
- [ ] If the build or test commands themselves can't be found or run in
      this environment: stop before making any change, surface this to
      the user/orchestrator — verification-free refactoring is not a
      degraded version of this skill, it's a different and much riskier
      activity that needs explicit sign-off
