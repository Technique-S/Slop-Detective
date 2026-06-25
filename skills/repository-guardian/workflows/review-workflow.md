# Review Workflow

A detailed, step-by-step walkthrough of how repository-guardian should
run. SKILL.md has the condensed version; this is the expanded
reference.

## Phase 0 — Gather everything, trust nothing yet

Confirm all 9 auditor reports, all 4 surgeon outputs, and all 10
documentation outputs are present. Get access to the actual repository
— this review is impossible to do honestly from reports alone.

## Phase 1 — Independent re-verification

For each area, the standard is re-derivation, not re-reading:

1. **Architecture** — re-trace at least the major module boundaries
   yourself by reading actual imports, then compare against
   `ARCHITECTURE.md` and `ARCHITECTURE_AUDIT.md`. Note any mismatch.
2. **Refactors** — sample `REFACTOR_LOG.md` entries, weighted toward
   dead code removal and dependency cleanup (the highest-risk
   categories). For each sampled entry, check the actual diff against
   the claimed change and re-run the claimed verification yourself.
3. **Documentation** — spot-check a sample of entries in
   `COMPONENT_GUIDE.md`, `SERVICE_GUIDE.md`, `UTILITY_GUIDE.md`, and
   `API_REFERENCE.md` against the actual source.
4. **Naming** — confirm the convention `NAMING_CONVENTIONS.md` and
   `CONTRIBUTING.md` claim is dominant actually is, post-refactor.
5. **Complexity** — for a sample of claimed complexity reductions,
   confirm the complexity actually went down rather than just moving
   to a different function.
6. **Dead Code** — for everything `CHANGESET.md` lists as deleted,
   confirm independently that nothing still references it, including
   via dynamic-string imports or reflection.
7. **Dependencies** — regenerate the dependency graph yourself and diff
   it against `DEPENDENCY_MAP.md`.
8. **Functionality Preservation** — run the full test suite yourself.
   For critical flows without test coverage, manually exercise them if
   feasible and say explicitly what you checked.

## Phase 2 — Hunt for newly introduced problems

Specifically search for: new duplication introduced by a
"consolidation" that actually left a second copy somewhere, new dead
code left orphaned by a refactor, new architecture violations, and any
regression the surgeon's own verification didn't catch.

## Phase 3 — Write the verdict

1. `FINAL_REVIEW.md` — document what you checked in every category and
   what you found, including the issues you found that earlier stages
   missed.
2. `QUALITY_SCORECARD.md` — re-assess every dimension independently;
   don't carry the auditor's original numbers forward without
   re-justifying them against the current state.
3. `REGRESSION_REPORT.md` — an explicit functionality-preservation
   verdict, not an implied one.
4. `FINAL_APPROVAL.md` — `approved`, `conditionally-approved`, or
   `rejected`, with every claim in "Basis for This Status" traceable
   to one of the other three documents.

## Common pitfalls

- Summarizing the previous stages' self-reports instead of
  independently checking them.
- Approving with unresolved critical issues because they seem minor in
  isolation.
- Leaving "Functionality Preservation" implicit rather than stating a
  clear verdict.
