# ARCHITECTURE_AUDIT.md

## Overview

- **Repository:** taskflow-api
- **Date:** 2026-03-14
- **Scan coverage:** 100% of `src/`, 100% of `tests/`. Excluded:
  `node_modules/`, `package-lock.json` (dependency manifest, reviewed
  separately in DEPENDENCY_AUDIT.md).

## High-Level Architecture Map

| Module/Folder | Responsibility | Depended on by | Depends on |
|---|---|---|---|
| `src/routes/` | HTTP route definitions, request parsing | `src/index.js` | `src/services/` |
| `src/services/` | Business logic, data persistence | `src/routes/` | `src/models/`, `src/utils/` |
| `src/models/` | Data shape definitions | `src/services/` | (none) |
| `src/utils/` | Shared validation/formatting helpers | `src/services/`, `src/routes/` | (none) |
| `src/legacy/` | Pre-Express request handlers | (none found) | `src/models/` |

## Architectural Patterns Observed

The codebase follows a fairly conventional layered structure — routes
call services, services call models and utils — and that pattern holds
consistently across `tasks.js`/`taskService.js` and
`users.js`/`userService.js`. The one folder that breaks the pattern is
`src/legacy/`, which doesn't fit the layered model at all and isn't
wired into `src/index.js`'s route registration; see Dead Code Detection
in `DEAD_CODE_REPORT.md`.

## Boundary Violations

- **Issue:** `taskService.js` reaches directly into `userService.js`'s
  internal state rather than going through its exported functions.
- **Location:** `src/services/taskService.js:34`
- **Evidence:** `const user = userService._userCache[userId]` accesses
  an underscore-prefixed (intended-private) property directly, instead
  of calling the exported `userService.getUser(userId)` at line 12 of
  the same file.
- **Severity:** medium
- **Confidence:** high
- **Risk:** any internal change to `userService.js`'s cache
  implementation will silently break `taskService.js` without touching
  its public API, so the break won't be obvious from `userService.js`'s
  own tests.
- **Recommendation:** replace the direct cache access with a call to
  `userService.getUser(userId)`.

- **Issue:** circular dependency between `taskService.js` and
  `userService.js`.
- **Location:** `src/services/taskService.js:3`, `src/services/userService.js:4`
- **Evidence:** `taskService.js` line 3: `const userService =
  require('./userService')`; `userService.js` line 4: `const
  taskService = require('./taskService')` — each module requires the
  other.
- **Severity:** high
- **Confidence:** high
- **Risk:** load-order-dependent bugs (whichever module finishes
  `require`-ing first gets a partially-initialized export of the
  other), and it makes either module very difficult to test in
  isolation.
- **Recommendation:** see also `DEPENDENCY_AUDIT.md`'s Circular
  Dependencies section — extracting the shared user-lookup logic into
  a separate module both services can depend on would break the cycle.

## Architectural Risks Summary

The circular dependency between `taskService.js` and `userService.js`
is the single highest-priority architectural issue — it's both high
severity and high confidence, and it constrains how safely either
service can be refactored further. The `src/legacy/` folder's
disconnection from the rest of the architecture is lower risk but
should be resolved via dead code removal rather than left ambiguous.
