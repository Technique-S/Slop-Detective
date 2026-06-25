# REPOSITORY_SCORECARD.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14

## Scores

| Dimension | Score (/10) | Basis |
|---|---|---|
| Architecture | 6 | One high-severity circular dependency, one medium boundary violation (see ARCHITECTURE_AUDIT.md) |
| Dead Code | 7 | Two small confirmed dead items, low risk to remove (see DEAD_CODE_REPORT.md) |
| Duplication | 5 | One high-severity cluster that has already caused a real behavioral inconsistency (see DUPLICATION_REPORT.md) |
| Complexity | 7 | Two medium-severity hotspots, both with clear extraction-based fixes (see COMPLEXITY_REPORT.md) |
| Naming Consistency | 7 | Mixed camelCase variants across the duplicated validation files (see NAMING_CONVENTIONS.md) |
| Type Safety | 8 | Plain JavaScript project with light JSDoc coverage; no major gaps at API boundaries (see TYPE_SAFETY_REPORT.md) |
| Dependency Health | 6 | One circular dependency, one soon-to-be-unused package (see DEPENDENCY_AUDIT.md) |
| Structure | 8 | Mostly consistent layered structure; one disconnected legacy folder (see PROJECT_STRUCTURE.md) |

## Overall Score

**6.75 / 10.** Weighted down slightly from the simple average because
the circular dependency (Architecture + Dependency Health) constrains
how safely several other fixes can be made, so it's prioritized first
in the Top 10 list below.

## Top 10 Issues Across All Reports

1. Circular dependency between `taskService.js` and `userService.js` (high severity, high confidence) — DEPENDENCY_AUDIT.md / ARCHITECTURE_AUDIT.md
2. Duplicated validation logic with an already-diverged whitespace bug (high severity, high confidence) — DUPLICATION_REPORT.md
3. Direct access to `userService`'s private cache from `taskService.js` (medium severity, high confidence) — ARCHITECTURE_AUDIT.md
4. `createTask()` high complexity / deep nesting (medium severity, high confidence) — COMPLEXITY_REPORT.md
5. `PATCH /:id` handler bypasses `taskService.updateTask()` (medium severity, high confidence) — COMPLEXITY_REPORT.md
6. Dead legacy handler `src/legacy/oldTaskHandler.js` (low severity, high confidence) — DEAD_CODE_REPORT.md
7. `moment` dependency about to become fully unused (low severity, high confidence) — DEPENDENCY_AUDIT.md
8. Dead `formatLegacyDate()` function (low severity, high confidence) — DEAD_CODE_REPORT.md
9. Naming inconsistency between `validate.js`/`validation.js` function names (low severity, high confidence) — NAMING_CONVENTIONS.md
10. Suspected-but-unconfirmed dead `_debugDumpCache()` export (low severity, low confidence — flagged for human judgment, not automatic removal) — DEAD_CODE_REPORT.md

## Quality Gate Status

- [x] 100% repository scan completed
- [x] Dependency graph generated
- [x] Architecture graph generated
- [x] All 9 reports generated
- [x] This scorecard generated
