# Artifact Contracts

This document defines exactly what each stage requires before it may
start, what it must produce before the next stage may start, and how
those artifacts are validated. **No stage may start without its
required artifacts.** This is the mechanism, not a guideline —
repository-orchestrator checks this contract literally before invoking
each stage.

## Contract format

Each stage below lists:

- **REQUIRED_ARTIFACTS** — block the stage from starting if missing
- **OPTIONAL_ARTIFACTS** — used if present, don't block if absent
- **BLOCKING_ARTIFACTS** — required outputs the *next* stage cannot
  start without
- **Validation rules** — what "exists" actually means here (not just
  present on disk, but non-empty and structurally valid)

---

## repository-auditor

**REQUIRED_ARTIFACTS (inputs):** none — this is the pipeline's entry
stage.

**OPTIONAL_ARTIFACTS (inputs):** build/dependency manifest
(`package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, etc.). If
absent, dependency analysis falls back to import-scanning and notes
the reduced confidence.

**OUTPUT_ARTIFACTS / BLOCKING_ARTIFACTS for repository-surgeon:**

- `ARCHITECTURE_AUDIT.md`
- `DEAD_CODE_REPORT.md`
- `DUPLICATION_REPORT.md`
- `COMPLEXITY_REPORT.md`
- `NAMING_CONVENTIONS.md`
- `PROJECT_STRUCTURE.md`
- `TYPE_SAFETY_REPORT.md`
- `DEPENDENCY_AUDIT.md`
- `REPOSITORY_SCORECARD.md`

**Validation rules:** all nine files must exist, must be non-empty, and
must not contain unfilled template placeholders (e.g. a literal
`<!-- ... -->` comment standing in for real content in a required
field). `REPOSITORY_SCORECARD.md`'s Quality Gate Status checklist must
be fully checked.

---

## repository-surgeon

**REQUIRED_ARTIFACTS (inputs):** all nine repository-auditor outputs
listed above.

**OPTIONAL_ARTIFACTS (inputs):** none beyond the required set.

**OUTPUT_ARTIFACTS / BLOCKING_ARTIFACTS for documentation-architect:**

- `REFACTOR_LOG.md`
- `CHANGESET.md`
- `REFACTOR_SUMMARY.md`
- `POST_REFACTOR_STRUCTURE.md`
- A passing build (verified by actually running it)
- A passing test suite (verified by actually running it)

**Validation rules:** `REFACTOR_LOG.md` must contain at least one entry
per category actually executed, each with all required fields
(Problem, Evidence, Reason, Risk, Rollback Method, Verification Method,
Verification Result). `CHANGESET.md`'s file lists must match the
actual diff. Build and test results are re-verified by
repository-orchestrator independently, not taken from
`REFACTOR_SUMMARY.md`'s self-report.

---

## documentation-architect

**REQUIRED_ARTIFACTS (inputs):**

- All 9 repository-auditor outputs
- All 4 repository-surgeon outputs (`REFACTOR_LOG.md`, `CHANGESET.md`,
  `REFACTOR_SUMMARY.md`, `POST_REFACTOR_STRUCTURE.md`)
- The post-refactor repository itself

**OPTIONAL_ARTIFACTS (inputs):** none beyond the required set.

**OUTPUT_ARTIFACTS / BLOCKING_ARTIFACTS for repository-guardian:**

- `README.md`
- `ARCHITECTURE.md`
- `COMPONENT_GUIDE.md`
- `SERVICE_GUIDE.md`
- `UTILITY_GUIDE.md`
- `DEPENDENCY_MAP.md`
- `API_REFERENCE.md`
- `ONBOARDING_GUIDE.md`
- `CONTRIBUTING.md`
- `TROUBLESHOOTING.md`

**Validation rules:** all ten files must exist and be non-empty. Every
item documented must include all seven required fields (Purpose,
Inputs, Outputs, Dependencies, Side Effects, Examples, Common Failure
Modes). Internal links between documents must resolve.

---

## repository-guardian

**REQUIRED_ARTIFACTS (inputs):**

- All 9 repository-auditor outputs
- All 4 repository-surgeon outputs
- All 10 documentation-architect outputs
- The entire repository itself

**OPTIONAL_ARTIFACTS (inputs):** none beyond the required set.

**OUTPUT_ARTIFACTS / BLOCKING_ARTIFACTS for pipeline completion:**

- `FINAL_REVIEW.md`
- `QUALITY_SCORECARD.md`
- `REGRESSION_REPORT.md`
- `FINAL_APPROVAL.md` — with an explicit status of `approved`,
  `conditionally-approved`, or `rejected`

**Validation rules:** `FINAL_APPROVAL.md`'s "Basis for This Status"
must trace to specific content in `FINAL_REVIEW.md` or
`REGRESSION_REPORT.md` — a status with no traceable basis is treated as
invalid output, not as a valid rejection or approval.

---

## repository-orchestrator

**REQUIRED_ARTIFACTS (inputs):** none at start. On resume, reads
`WORKFLOW_STATE.md` if present.

**OUTPUT_ARTIFACTS:**

- `WORKFLOW_STATE.md` — kept current throughout the run
- `FAILURE_REPORT.md` — only produced if a stage's quality gate fails

**Validation rules:** `WORKFLOW_STATE.md` must always reflect the true
current state — Completed Stages, Current Stage, Failures, Warnings,
Quality Scores, Approval Status, and Artifact Status must all be kept
in sync with what actually happened, not what was planned to happen.
