# Quality Gates

For every stage: Entry Criteria, Completion Criteria, Verification
Criteria, Failure Conditions, and Rollback Requirements.
repository-orchestrator checks these directly rather than trusting a
stage's self-reported "done" status.

## repository-auditor

**Entry criteria:** repository is accessible; this is either a fresh
pipeline run or a resume with no unresolved failures blocking this
stage.

**Completion criteria:** all 9 reports generated; `REPOSITORY_SCORECARD.md`
generated; 100% scan coverage (or gaps explicitly documented);
dependency graph generated; architecture graph generated.

**Verification criteria:** spot-check a sample of findings against
actual file content; confirm zero files were modified during the run
(diff against pre-audit state).

**Failure conditions:** any required report missing or empty; scan
coverage gap not documented; a finding presented with confidence higher
than its evidence supports.

**Rollback requirements:** none needed — this stage makes no changes,
so there is nothing to roll back. A failed audit simply means the
stage re-runs or is escalated to a human; the repository is never at
risk from this stage.

---

## repository-surgeon

**Entry criteria:** all 9 auditor reports present and valid; version
control clean; build and test commands located and confirmed runnable;
baseline test run completed.

**Completion criteria:** all imports valid; no orphaned files; no
circular references introduced; no duplicated logic introduced; full
build passes; full test suite passes; all 4 outputs generated.

**Verification criteria:** every `REFACTOR_LOG.md` entry has a recorded
verification method and result; a sample of entries independently
spot-checked against the actual diff; net diff trends toward less code,
less duplication, less complexity (or deviations are explained).

**Failure conditions:** a change breaks the build or tests and can't be
fixed within the same change; an entire refactor category proves too
risky given test coverage; an import points to a file that no longer
exists at its path.

**Rollback requirements:** every individual change must have a recorded,
tested rollback method *before* the next change begins. On failure, the
specific failing change is rolled back immediately — this stage never
rolls back the entire session's work over one bad change.

---

## documentation-architect

**Entry criteria:** all 9 auditor reports and all 4 surgeon outputs
present; repository confirmed to be in its post-refactor state.

**Completion criteria:** every major folder, service, API, and utility
documented; dependency map generated; architecture diagram generated;
all 10 outputs generated.

**Verification criteria:** a sample of documented items independently
spot-checked against actual source; all internal cross-links resolve;
examples in each guide are real, not invented.

**Failure conditions:** a documented item's Purpose/Inputs/Outputs
contradicts the actual source; a required output missing; an internal
link pointing to a nonexistent file.

**Rollback requirements:** none needed — this stage doesn't modify code.
A failed verification simply means the specific document is corrected
and re-checked before the stage is marked complete.

---

## repository-guardian

**Entry criteria:** all outputs from all three previous stages present;
full repository access confirmed.

**Completion criteria:** no critical issues; no severe regressions;
documentation complete; architecture valid; functionality preserved;
quality score above the agreed threshold; all 4 outputs generated.

**Verification criteria:** independent re-run of the test suite;
independently re-traced architecture; independently regenerated
dependency graph; a meaningful sample of `REFACTOR_LOG.md` entries
independently re-checked against the actual diff, weighted toward the
highest-risk categories (dead code removal, dependency cleanup).

**Failure conditions:** any critical issue found that earlier stages
missed; any severe regression in functionality; an approval whose
basis doesn't trace to a specific finding in this stage's own reports.

**Rollback requirements:** this stage doesn't roll back changes itself
— if it finds something that needs rolling back, that's a finding in
`REGRESSION_REPORT.md` with a recommendation to send the specific
change back to repository-surgeon (which retains the original rollback
method recorded in `REFACTOR_LOG.md`).

---

## repository-orchestrator

**Entry criteria:** none for a fresh run. For a resume, `WORKFLOW_STATE.md`
must be present and internally consistent (Current Stage matches what's
actually been completed).

**Completion criteria:** `FINAL_APPROVAL.md` exists with status
`approved`.

**Verification criteria:** every stage's own completion and
verification criteria above were actually checked, not assumed; every
required artifact was confirmed present and non-empty before advancing.

**Failure conditions:** any stage's completion criteria not met; any
required artifact missing; `FINAL_APPROVAL.md` status is
`conditionally-approved` or `rejected`.

**Rollback requirements:** the orchestrator itself makes no code
changes, so it has nothing of its own to roll back. On any failure, it
halts and writes `FAILURE_REPORT.md` rather than attempting to recover
automatically — recovery decisions belong to the user or to a
deliberate re-run of the specific failed stage.
