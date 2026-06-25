# DUPLICATION_REPORT.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14
- **Method:** manual review of structurally similar files (flagged by
  similar names and similar import sets), confirmed by direct
  line-by-line comparison.

## Duplicate Clusters

### Cluster 1

- **Locations:** `src/utils/validate.js:1-40`, `src/utils/validation.js:1-36`
- **Similarity:** near-identical (logic identical, naming differs:
  `validate.js` uses `isValidEmail`/`isValidTaskTitle`, `validation.js`
  uses `checkEmail`/`checkTitle` for the same regex checks)
- **Evidence:** both files implement the same email regex
  (`/^[^\s@]+@[^\s@]+\.[^\s@]+$/`) and the same task-title length check
  (`title.length > 0 && title.length <= 200`). `validate.js` is
  imported by `src/routes/users.js` and `src/services/taskService.js`.
  `validation.js` is imported only by `src/routes/tasks.js`.
- **Severity:** high
- **Confidence:** high
- **Risk:** the two copies have already diverged in one place —
  `validate.js`'s title check additionally trims whitespace before
  measuring length (line 18: `title.trim().length`), while
  `validation.js` does not (line 14: `title.length`). This means a
  title of all-whitespace currently passes validation through one route
  (`tasks.js`, via `validation.js`) but not the other path that reuses
  `taskService.js` directly — a real, already-existing inconsistency
  caused by the duplication.
- **Recommendation:** consolidate into `validate.js` (more callers,
  and the more correct whitespace-handling behavior), update
  `src/routes/tasks.js` to import from `validate.js`, then delete
  `validation.js`.

## Consolidation Priority

Cluster 1 is the only duplication cluster found and should be addressed
first in repository-surgeon's Duplication Consolidation step, both
because it's high severity/high confidence and because it's already
causing a real (if minor) behavioral inconsistency between routes.
