# repository-surgeon

Stage 2 of the Repository Excellence pipeline. Performs safe refactors,
but only ones justified by repository-auditor's findings — never
guesses, never adds features, never changes behavior.

**Version:** 1.0.0 · **Tags:** refactoring, architecture, documentation,
code-quality, maintenance, safe-refactoring, dead-code-removal,
type-safety, dependency-cleanup

## Mission

Perform safe refactors based solely on auditor reports.

## Input artifacts (required)

| Artifact | From |
|---|---|
| `ARCHITECTURE_AUDIT.md` | repository-auditor |
| `DEAD_CODE_REPORT.md` | repository-auditor |
| `DUPLICATION_REPORT.md` | repository-auditor |
| `COMPLEXITY_REPORT.md` | repository-auditor |
| `NAMING_CONVENTIONS.md` | repository-auditor |
| `PROJECT_STRUCTURE.md` | repository-auditor |
| `TYPE_SAFETY_REPORT.md` | repository-auditor |
| `DEPENDENCY_AUDIT.md` | repository-auditor |
| `REPOSITORY_SCORECARD.md` | repository-auditor |

All nine are blocking — this skill should refuse to start refactoring
without them. See [`../../orchestrator/artifact_contracts.md`](../../orchestrator/artifact_contracts.md).

## Output artifacts

| Artifact | Description |
|---|---|
| `REFACTOR_LOG.md` | One entry per change: problem, evidence, reason, risk, rollback, verification |
| `CHANGESET.md` | Every file changed/added/deleted, with a net diff summary |
| `REFACTOR_SUMMARY.md` | Roll-up by category + before/after scorecard comparison |
| `POST_REFACTOR_STRUCTURE.md` | Resulting structure mapped against the auditor's suggested target |

These four (plus a passing build/test run) are required artifacts for
documentation-architect to begin.

## Boundaries

**Forbidden:** adding features, changing business behavior, removing
code without high-confidence dead-code evidence.

**Allowed:** refactoring, consolidation, renaming, reorganization, doc
updates, type improvements, dependency cleanup.

## Refactor order

Naming → Structure → Duplication Consolidation → Dead Code Removal →
Complexity Reduction → Type Safety → Dependency Cleanup. This order is
deliberate — see `workflows/refactor-workflow.md` for why each step
depends on the ones before it.

## Quality gates

- [ ] All imports valid
- [ ] No orphaned files
- [ ] No circular references introduced
- [ ] No duplicated logic introduced
- [ ] Build passes
- [ ] Tests pass

## Folder contents

```
repository-surgeon/
├── SKILL.md
├── README.md          (this file)
├── workflows/
│   └── refactor-workflow.md
├── templates/          (one per output document)
└── checklists/
    └── verification-checklists.md
```

## Handoff

documentation-architect reads this stage's outputs to understand *what
changed and why* so the documentation it writes describes the actual
current repository, not the pre-refactor one. repository-guardian later
independently re-verifies every claim in REFACTOR_SUMMARY.md rather than
trusting it.

See [`examples/sample-refactor/`](../../examples/sample-refactor/) for a
realistic example of expected output quality.
