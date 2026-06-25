# DEAD_CODE_REPORT.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14
- **Method:** entry-point reachability analysis starting from
  `src/index.js`, cross-checked with a repo-wide search for both static
  `require()` calls and dynamic `require(variable)` patterns.

## Confirmed Dead Code

- **Issue:** `src/legacy/oldTaskHandler.js` is never imported anywhere
  in the reachable graph.
- **Location:** `src/legacy/oldTaskHandler.js` (entire file, 47 lines)
- **Evidence:** repo-wide search for `oldTaskHandler` and for
  `require('./legacy` / `require("../legacy` returns zero matches
  outside the file itself. `src/index.js`'s route registration (lines
  8–15) only references `src/routes/tasks.js` and `src/routes/users.js`.
  Git history shows this file was the pre-Express request handler,
  superseded when the project migrated to Express (commit
  `a3f9e21`, "migrate to express routing").
- **Severity:** low
- **Confidence:** high
- **Risk:** essentially none to remove — no dynamic loading pattern
  exists anywhere in this codebase (confirmed via repo-wide search for
  `require(` with a non-string-literal argument: zero matches), so
  there's no mechanism by which this file could be loaded indirectly.
- **Recommendation:** delete `src/legacy/oldTaskHandler.js` and the
  now-empty `src/legacy/` directory.

- **Issue:** `formatLegacyDate()` function is unreferenced.
- **Location:** `src/utils/validate.js:58-64`
- **Evidence:** only reference to `formatLegacyDate` anywhere in the
  repo is its own definition; no caller in `src/`, `tests/`, or
  `package.json` scripts.
- **Severity:** low
- **Confidence:** high
- **Risk:** none — it's a pure function with no side effects and no
  exports consumed elsewhere.
- **Recommendation:** delete the function.

## Suspected Dead Code (lower confidence)

- **Item:** `userService.js`'s exported `_debugDumpCache()` function
  (line 71) has no caller within `src/` or `tests/`, but its name and a
  comment above it (`// invoke from REPL during debugging`) suggest
  it's intended for manual use rather than being truly dead. Not
  recommended for removal — flagged for human judgment only.

## Explicitly Excluded From This Report

- All exports from `src/services/taskService.js` and
  `src/services/userService.js` are kept even where a given exported
  function has no current internal caller, since both modules are
  documented in `package.json`'s `"main"` field as the project's
  intended public API surface for downstream consumers.
