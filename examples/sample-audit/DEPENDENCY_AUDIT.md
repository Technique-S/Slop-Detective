# DEPENDENCY_AUDIT.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14

## Dependency Graph Summary

7 internal modules under `src/`, 6 external packages declared in
`package.json` (5 production, 1 dev). `src/utils/validate.js` has the
highest internal fan-in (imported by 3 other modules); see Internal
Coupling Hotspots below.

## Circular Dependencies

- **Issue:** `taskService.js` and `userService.js` require each other
  directly.
- **Location:** `src/services/taskService.js:3`, `src/services/userService.js:4`
- **Evidence:** `taskService.js` imports `userService` to look up task
  assignees; `userService.js` imports `taskService` to populate a
  user's `assignedTaskCount` field.
- **Severity:** high
- **Confidence:** high
- **Risk:** constrains how either module can be tested or refactored
  in isolation; see `ARCHITECTURE_AUDIT.md`'s Boundary Violations
  section for the related direct-cache-access issue between the same
  two files.
- **Recommendation:** extract a shared `userTaskLookup.js` module that
  both services depend on for the cross-cutting lookups, removing the
  need for either to import the other directly.

## Unused / Outdated External Dependencies

- **Package:** `moment` (declared in `package.json`, version `2.29.4`)
  — imported only in the dead `src/legacy/oldTaskHandler.js`. Once that
  file is removed (see `DEAD_CODE_REPORT.md`), this dependency becomes
  fully unused. `moment` is also in maintenance mode upstream as of
  this audit; the codebase's only other date handling (in
  `validate.js`) already uses the native `Date` object, so no
  replacement library is needed once `moment` is dropped.

## Risky External Dependencies

- None identified with verified critical vulnerabilities at the time of
  this audit. (This check is time-sensitive — re-verify against current
  advisories before relying on this section in a later review.)

## Internal Coupling Hotspots

`src/utils/validate.js` (and its near-duplicate `validation.js` — see
`DUPLICATION_REPORT.md`) is imported by 3 of the 7 internal modules.
Once consolidated into a single file per `DUPLICATION_REPORT.md`'s
recommendation, that one file becomes the highest fan-in module in the
codebase — repository-surgeon should treat changes to it with extra
care and re-run the full test suite (not a scoped subset) after any
edit to it.
