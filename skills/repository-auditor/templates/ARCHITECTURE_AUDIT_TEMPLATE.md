# ARCHITECTURE_AUDIT.md

## Overview

- **Repository:**
- **Date:**
- **Scan coverage:** <!-- e.g. "100% of src/, 100% of lib/, excluded: node_modules, dist" -->

## High-Level Architecture Map

<!-- Describe the major layers/modules and how they relate. A simple
     directory-to-responsibility table works well: -->

| Module/Folder | Responsibility | Depended on by | Depends on |
|---|---|---|---|

## Architectural Patterns Observed

<!-- e.g. layered architecture, MVC, feature-folders, service layer,
     repository pattern — describe what's actually there, not what's
     idealized. Note inconsistencies (e.g. "most features follow
     feature-folder structure except X and Y"). -->

## Boundary Violations

<!-- Cases where a module reaches into another module's internals,
     skips an intended layer, or creates a dependency that contradicts
     the dominant pattern. Each one uses the standard finding format
     below. -->

### Finding Format (use for every entry in this and other audit reports)

- **Issue:**
- **Location:** <!-- file:line -->
- **Evidence:** <!-- the actual code/import/structure that demonstrates the issue -->
- **Severity:** <!-- critical | high | medium | low -->
- **Confidence:** <!-- high | medium | low — how sure are you this is real, not a false positive -->
- **Risk:** <!-- what breaks, or what gets harder, if this is left alone -->
- **Recommendation:** <!-- what repository-surgeon should do about it, if anything -->

## Architectural Risks Summary

<!-- Roll up the most severe findings here so the surgeon's prioritization
     step doesn't require re-reading the whole report. -->
