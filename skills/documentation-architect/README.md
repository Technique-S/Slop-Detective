# documentation-architect

Stage 3 of the Repository Excellence pipeline. Documents the repository
as it actually is, post-refactor — never invents behavior, never
describes aspirational architecture.

**Version:** 1.0.0 · **Tags:** refactoring, architecture, documentation,
code-quality, maintenance, technical-writing, onboarding, api-reference

## Mission

Create comprehensive repository documentation grounded in the current,
post-refactor codebase.

## Input artifacts (required)

| Artifact | From |
|---|---|
| All repository files (post-refactor) | the repo itself |
| All 9 audit reports | repository-auditor |
| `REFACTOR_LOG.md`, `CHANGESET.md`, `REFACTOR_SUMMARY.md`, `POST_REFACTOR_STRUCTURE.md` | repository-surgeon |

See [`../../orchestrator/artifact_contracts.md`](../../orchestrator/artifact_contracts.md)
for the full contract.

## Output artifacts

| Artifact | Description |
|---|---|
| `README.md` | Top-level project overview and doc index |
| `ARCHITECTURE.md` | Module map, diagram, data flow, key decisions |
| `COMPONENT_GUIDE.md` | One entry per component |
| `SERVICE_GUIDE.md` | One entry per service |
| `UTILITY_GUIDE.md` | One entry per shared utility |
| `DEPENDENCY_MAP.md` | Internal + external dependency graph |
| `API_REFERENCE.md` | One entry per public API surface |
| `ONBOARDING_GUIDE.md` | Path for a brand-new contributor |
| `CONTRIBUTING.md` | Process, conventions, PR/test expectations |
| `TROUBLESHOOTING.md` | Aggregated known failure modes |

All 10 are required artifacts for repository-guardian to begin.

## Boundaries

This skill never changes code. It documents what's there. If it finds
behavior that contradicts a name or a prior assumption, it notes the
discrepancy rather than silently documenting around it or "fixing" the
name itself (that's a surgeon concern, and only with re-verification).

## Quality gates

- [ ] Every major folder documented
- [ ] Every service documented
- [ ] Every API documented
- [ ] Every utility documented
- [ ] Dependency map generated
- [ ] Architecture diagram generated

## Folder contents

```
documentation-architect/
├── SKILL.md
├── README.md          (this file)
├── workflows/
│   └── documentation-workflow.md
├── templates/          (one per output document)
└── checklists/
    └── verification-checklists.md
```

## Handoff

repository-guardian treats every claim in this stage's output as
something to independently re-verify, not something to trust — so
accuracy here matters more than completeness. A smaller set of fully
accurate docs is more valuable to the pipeline than a complete set with
guessed-at behavior mixed in.

See [`examples/sample-documentation/`](../../examples/sample-documentation/)
for a realistic example of expected output quality.
