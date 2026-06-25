# repository-auditor

Stage 1 of the Repository Excellence pipeline. A strictly read-only
investigation skill: it understands a repository in full depth and
writes down what it finds, but never changes a single file.

**Version:** 1.0.0 · **Tags:** refactoring, architecture, documentation,
code-quality, maintenance, auditing, dead-code-detection,
dependency-analysis, complexity-analysis

## Mission

Understand the repository completely. Never modify code.

## Input artifacts

| Artifact | Required? |
|---|---|
| The repository itself | required |
| Build/dependency manifest (package.json, requirements.txt, etc.) | required for dependency analysis — fall back to import-scanning if absent |

This is the pipeline's entry stage — it has no upstream artifact
dependencies. See [`../../orchestrator/artifact_contracts.md`](../../orchestrator/artifact_contracts.md)
for the full contract.

## Output artifacts

| Artifact | Description |
|---|---|
| `ARCHITECTURE_AUDIT.md` | Module map, patterns, boundary violations |
| `DEAD_CODE_REPORT.md` | Confirmed and suspected unreferenced code |
| `DUPLICATION_REPORT.md` | Duplicate/near-duplicate code clusters |
| `COMPLEXITY_REPORT.md` | Cyclomatic complexity and nesting hotspots |
| `NAMING_CONVENTIONS.md` | Naming consistency and misleading names |
| `PROJECT_STRUCTURE.md` | Current structure + suggested target structure |
| `TYPE_SAFETY_REPORT.md` | Type safety gaps, weighted by API surface |
| `DEPENDENCY_AUDIT.md` | Dependency graph, cycles, unused/risky packages |
| `REPOSITORY_SCORECARD.md` | Scored summary + top 10 issues across all reports |

All nine are required artifacts for repository-surgeon to begin.

## Boundaries

**Forbidden:** editing, deleting, moving, or renaming any file; changing
any code, including trivial fixes.

**Allowed:** reading files, tracing dependencies/imports, building
architecture and dependency graphs, running analysis in report-only
mode, writing the report files above.

## Quality gates

- [ ] 100% repository scan completed
- [ ] Dependency graph generated
- [ ] Architecture graph generated
- [ ] All 9 reports generated
- [ ] Scorecard generated

## Folder contents

```
repository-auditor/
├── SKILL.md
├── README.md          (this file)
├── workflows/
│   └── audit-workflow.md
├── templates/          (one per output report)
└── checklists/
    └── verification-checklists.md
```

## Handoff

Everything in this skill's output becomes repository-surgeon's input.
The surgeon is not permitted to act on anything that isn't backed by a
finding in one of these reports — so vague or evidence-free findings
here become a hard blocker two stages later. When in doubt, write the
finding down with low confidence rather than omitting it, but never
write a finding with confidence higher than the evidence supports.

See [`examples/sample-audit/`](../../examples/sample-audit/) for a
realistic example of expected output quality.
