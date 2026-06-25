# Refactor Workflow

A detailed, step-by-step walkthrough of how repository-surgeon should
run. SKILL.md has the condensed version; this is the expanded
reference.

## Phase 0 — Preflight

1. Confirm all 9 auditor reports exist and are non-empty.
2. Confirm version control is clean — no uncommitted changes. If it
   isn't, stop and ask the user to commit or stash first; otherwise
   there's no clean baseline to roll back to.
3. Locate the build command and the test command. Run both once now to
   get a baseline. If the test suite is already failing before any
   refactor work starts, note that explicitly — this stage is not
   responsible for fixing pre-existing failures, only for not adding
   new ones.

## Phase 1 — Work the refactor order

For each category, in order, repeat this loop for every individual
change (not once per category):

1. Pick the next finding from the relevant auditor report.
2. Write the planned change into `REFACTOR_LOG.md`: Problem, Evidence,
   Reason, Risk, Rollback Method — **before** making the change.
3. Make the change.
4. Run the build.
5. Run the relevant tests (the full suite if the change touches
   something widely depended-on; a scoped subset is fine for low-risk,
   narrowly-used code, but say which subset and why).
6. Record the Verification Method and result in the same
   `REFACTOR_LOG.md` entry.
7. If it failed: roll back immediately using the recorded method, mark
   the entry's result as "fail," and move to the next finding.

The seven categories, in required order:

1. **Naming Improvements** — rename toward the dominant convention
   identified in `NAMING_CONVENTIONS.md`. Update every reference to a
   renamed symbol in the same change, not as a follow-up.
2. **Structure Improvements** — move files toward
   `PROJECT_STRUCTURE.md`'s suggested target. Update imports affected
   by the move in the same change.
3. **Duplication Consolidation** — for each cluster in
   `DUPLICATION_REPORT.md`, pick the canonical version deliberately
   (most test coverage > most recent > most complete, in that priority
   order unless there's a clear reason to deviate) and redirect all
   call sites to it.
4. **Dead Code Removal** — only from "Confirmed Dead Code." Before
   deleting, re-run a reference search yourself; the auditor's
   confidence rating is a strong signal, not a substitute.
5. **Complexity Reduction** — extract/simplify hotspots from
   `COMPLEXITY_REPORT.md`. The behavior must be identical before and
   after; if you can't make a complexity-reducing change without
   altering behavior, don't make it — flag it for a human instead.
6. **Type Safety Improvements** — close gaps from
   `TYPE_SAFETY_REPORT.md`, prioritizing public API boundaries.
7. **Dependency Cleanup** — break cycles from `DEPENDENCY_AUDIT.md`,
   remove unused packages, address risky ones where a safe upgrade
   path exists.

## Phase 2 — Synthesize

1. Build `CHANGESET.md` from the full set of changes.
2. Build `REFACTOR_SUMMARY.md`, including the "What Was Deliberately
   NOT Changed" section — be explicit about findings you chose not to
   act on and why.
3. Build `POST_REFACTOR_STRUCTURE.md`, mapped against the auditor's
   suggested target.
4. Run the full build and full test suite one final time.

## Common pitfalls

- Batching several changes before running tests, which makes failures
  hard to attribute.
- Treating "consolidation" as copy-paste into a new file instead of
  actually removing the duplicate and redirecting references.
- Deleting something from "Suspected Dead Code" instead of only
  "Confirmed Dead Code."
