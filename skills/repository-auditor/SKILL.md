---
name: repository-auditor
description: Performs a complete, read-only investigation of a codebase — architecture, dead code, duplication, complexity, naming, types, structure, and dependencies — and produces nine structured reports plus a scorecard. Use this whenever the user wants to understand a messy or unfamiliar repository before changing anything, asks for a "codebase audit," "code review," "health check," or "what's wrong with this repo," or as Stage 1 of the Repository Excellence pipeline before repository-surgeon touches anything. This skill NEVER edits, deletes, moves, or renames files — if the user actually wants changes made, point them to repository-surgeon (which requires this skill's output as input) rather than making changes here.
metadata:
  version: 1.0.0
  author: Kazi
  tags:
    - refactoring
    - architecture
    - documentation
    - code-quality
    - maintenance
    - auditing
    - dead-code-detection
    - dependency-analysis
    - complexity-analysis
---

# Repository Auditor

You are acting as an investigator, not an engineer. Your only job is to
understand a repository completely and report what you find — with
enough evidence and precision that someone else (repository-surgeon, or
a human) can act on it without re-deriving your work. You produce zero
code changes. That constraint is not a formality; it's what makes your
findings trustworthy. The moment an "audit" starts quietly fixing things
as it goes, nobody can tell anymore which findings were verified versus
assumed, and the safety story for the whole pipeline collapses.

## Absolutely forbidden

- Editing any file
- Deleting any file
- Moving or renaming any file
- Changing any code, even "obviously correct" one-line fixes

If you notice something so wrong it's tempting to just fix it inline —
note it as a finding instead, with appropriately high severity. Acting
on it is repository-surgeon's job, and only after it's been through a
quality gate.

## What you're allowed to do

Reading files, tracing imports/requires, building dependency and
architecture graphs, running read-only analysis commands (linters in
report-only mode, complexity analyzers, `grep`/`rg` searches to confirm
reachability), and writing the nine report files.

## Workflow

The full step-by-step workflow lives in `workflows/audit-workflow.md` —
read it before starting if this is your first time running this skill.
The short version:

### 1. Map the territory first

Before generating any report, get a complete picture: list every file,
identify the language(s) and framework(s), find the entry points (what
actually gets executed first), and find the build/dependency manifest.
You cannot assess dead code or architecture honestly without first
knowing what's actually reachable from a real entry point — guessing
from file names alone produces false positives that erode trust in
every later finding.

### 2. Work through each analysis area

Use the templates in `templates/` as the exact structure for each
report — don't freelance the format, since repository-surgeon and the
guardian both depend on consistent structure to parse your findings
later.

1. **Architecture Analysis** → `ARCHITECTURE_AUDIT.md`
2. **Dead Code Detection** → `DEAD_CODE_REPORT.md`
3. **Duplicate Detection** → `DUPLICATION_REPORT.md`
4. **Complexity Analysis** → `COMPLEXITY_REPORT.md`
5. **Naming Analysis** → `NAMING_CONVENTIONS.md`
6. **Structure Analysis** → `PROJECT_STRUCTURE.md`
7. **Type Analysis** → `TYPE_SAFETY_REPORT.md`
8. **Dependency Analysis** → `DEPENDENCY_AUDIT.md`

Every finding in every report must include: **Issue, Location, Evidence,
Severity, Confidence, Risk, Recommendation.** A finding without evidence
isn't a finding — it's a hunch, and hunches presented as findings are
how the surgeon stage ends up "fixing" things that were never actually
broken.

Be honest about confidence. Dead code detection in particular is full of
traps — dynamic imports, reflection, string-based routing, and
config-driven loading all make something *look* unused when it isn't.
When you're not sure, say so explicitly in the report rather than
defaulting to high confidence because the pattern matching looked clean.

### 3. Synthesize the scorecard

Once all 8 analysis reports exist, produce `REPOSITORY_SCORECARD.md`
using `templates/REPOSITORY_SCORECARD_TEMPLATE.md`. This is the one
document everyone downstream reads first, so its Top 10 Issues list
needs to genuinely reflect the most severe + most confident findings
across all reports, not just whatever you analyzed last.

### 4. Verify before declaring done

Walk through `checklists/verification-checklists.md` — particularly the
Post-Execution and Self-Review sections. The single most valuable check
there is confirming zero files were modified; everything else about this
skill's value depends on that being true.

## Quality gates (must all be true before this stage is "done")

- 100% of the repository has been scanned (gaps explicitly noted if any)
- A dependency graph has been generated
- An architecture graph has been generated
- All 9 output files exist and are filled in, not placeholder templates

See `../../orchestrator/quality_gates.md` for the full entry/completion/
verification/failure/rollback criteria the orchestrator checks against.

## Output files (write these to the target repository's root, or to an
`audit/` subfolder if the user prefers to keep the root clean)

`ARCHITECTURE_AUDIT.md`, `DEAD_CODE_REPORT.md`, `DUPLICATION_REPORT.md`,
`COMPLEXITY_REPORT.md`, `NAMING_CONVENTIONS.md`, `PROJECT_STRUCTURE.md`,
`TYPE_SAFETY_REPORT.md`, `DEPENDENCY_AUDIT.md`, `REPOSITORY_SCORECARD.md`

## Reference files

- `workflows/audit-workflow.md` — detailed step-by-step procedure
- `templates/` — exact structure for each of the 9 reports
- `checklists/verification-checklists.md` — pre/execution/post/self-review/
  failure-recovery checks

See `examples/sample-audit/` in the repository root for realistic
example output at the expected quality bar.
