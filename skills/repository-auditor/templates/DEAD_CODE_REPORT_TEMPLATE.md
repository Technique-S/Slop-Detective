# DEAD_CODE_REPORT.md

## Overview

- **Repository:**
- **Date:**
- **Method:** <!-- static analysis, reference-graph traversal, entry-point reachability, etc. -->

## Confirmed Dead Code

<!-- Code with zero references anywhere in the reachable graph, including
     no dynamic-string imports, no reflection, no test references, no
     config-driven loading. Use the standard finding format. -->

- **Issue:**
- **Location:**
- **Evidence:** <!-- show the reference search that came up empty -->
- **Severity:**
- **Confidence:**
- **Risk:** <!-- usually low to remove, but note if removal could break a
                 public API/export surface -->
- **Recommendation:**

## Suspected Dead Code (lower confidence)

<!-- Things that LOOK unreferenced but might be loaded dynamically,
     exported for external consumers, used only in a build step, etc.
     Never recommend automatic removal for these — flag for human
     judgment instead. -->

## Explicitly Excluded From This Report

<!-- Anything that looks dead but is intentionally kept (e.g. public API
     surface, plugin entry points, feature flags). List so the surgeon
     doesn't accidentally treat silence as permission. -->
