# COMPLEXITY_REPORT.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14
- **Method:** cyclomatic complexity and nesting depth, measured with
  `eslint` (`complexity` rule) where configurable, supplemented by
  manual count for nesting depth.

## High-Complexity Hotspots

- **Issue:** `createTask()` has cyclomatic complexity 14 and nesting
  depth 5, driven by sequential validation checks each wrapped in its
  own `if`/`else` rather than early returns.
- **Location:** `src/services/taskService.js:40-89`
- **Evidence:** five nested conditionals checking title, description
  length, due date format, assignee existence, and priority value, each
  nested inside the previous one's `else` branch rather than guarded
  with early returns.
- **Severity:** medium
- **Confidence:** high
- **Risk:** every new validation rule added here increases nesting
  further; the current structure makes it easy to accidentally place a
  new check inside the wrong branch.
- **Recommendation:** refactor to a sequence of early-return guard
  clauses; each validation failure should return immediately rather
  than nesting the remaining checks inside an `else`.

- **Issue:** `routes/tasks.js`'s `PATCH /:id` handler has cyclomatic
  complexity 11, mixing request validation, business logic, and
  response formatting in one function.
- **Location:** `src/routes/tasks.js:52-95`
- **Evidence:** the handler validates the request body inline (lines
  54-63), then directly mutates the task object instead of delegating
  to `taskService.updateTask()` (which exists and is used by the `PUT`
  handler two functions above), then formats the response inline.
- **Severity:** medium
- **Confidence:** high
- **Risk:** this handler bypasses `taskService.js`'s validation and
  persistence logic entirely, meaning a future change to how tasks are
  saved (e.g. adding an audit log) would need to be duplicated here to
  take effect for `PATCH` requests.
- **Recommendation:** extract the inline logic into a call to
  `taskService.updateTask()`, consistent with the `PUT` handler.

## Complexity Distribution

| Threshold | Functions exceeding it |
|---|---|
| Cyclomatic complexity > 10 | 2 (`createTask`, `PATCH /:id` handler) |
| Nesting depth > 4 | 1 (`createTask`) |
| Function length > 50 lines | 1 (`createTask`, 49 lines) |

The two flagged functions account for the large majority of this
codebase's complexity budget; everything else in `src/` measures
comfortably under these thresholds.
