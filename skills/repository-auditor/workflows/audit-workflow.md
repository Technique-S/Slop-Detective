# Audit Workflow

A detailed, step-by-step walkthrough of how repository-auditor should
run. SKILL.md has the condensed version; this is the expanded
reference for anyone (human or Claude) who wants the full procedure.

## Phase 0 — Reconnaissance

1. List every file in the repository (respecting `.gitignore` —
   generated/vendored code is usually out of scope unless the user
   says otherwise).
2. Identify language(s), framework(s), and package manager(s) from
   manifest files (`package.json`, `requirements.txt`, `go.mod`,
   `Cargo.toml`, `pom.xml`, etc.).
3. Identify entry points: `main` files, `index` files, framework
   bootstrap files, CLI entry scripts declared in the manifest.
4. Note anything that will limit scan coverage up front (binary files,
   minified bundles, generated code, files too large to read fully) so
   this can be reported honestly later rather than discovered as a gap
   at the end.

## Phase 1 — Build the graphs

1. **Dependency graph**: walk every import/require statement and build
   an internal module graph plus a list of external packages actually
   imported (cross-reference against the manifest to catch declared-
   but-unused and imported-but-undeclared packages).
2. **Architecture graph**: group files by folder/module and infer
   responsibility from what each module imports and exports. Note
   where the inferred responsibility doesn't match the folder's name.
3. **Reachability set**: starting from the entry points, trace what's
   actually reachable. Anything outside this set is a dead-code
   candidate — but see Phase 2 before reporting it as confirmed.

## Phase 2 — Run each analysis

Work through these in any order (they're independent of each other,
unlike the surgeon's refactor steps which must be sequential):

- **Architecture Analysis** — populate `ARCHITECTURE_AUDIT.md` using
  the graphs from Phase 1. Look specifically for boundary violations:
  a module reaching into another's internals, a layer being skipped.
- **Dead Code Detection** — for everything outside the reachability
  set, check for dynamic-string imports, reflection-based loading, and
  config-driven references before calling it "Confirmed." If any of
  those patterns exist anywhere in the codebase, downgrade confidence
  and move the finding to "Suspected" instead.
- **Duplicate Detection** — look for near-identical function bodies,
  similar import sets, similar names. Token-similarity tools help, but
  always read the actual code for the top candidates before reporting
  — surface-level similarity isn't always real duplication.
- **Complexity Analysis** — measure cyclomatic complexity, nesting
  depth, function length, and parameter count where tooling supports
  it; otherwise estimate from manual reading and say so.
- **Naming Analysis** — tally naming patterns per construct type
  (functions, classes, files, variables) to find the actual dominant
  convention, then flag deviations from that dominant pattern, not from
  an external style guide.
- **Structure Analysis** — compare actual folder contents against what
  their names imply, and draft a suggested target structure.
- **Type Analysis** — for typed languages, find loose typing
  (`any`/untyped) especially at public API boundaries.
- **Dependency Analysis** — find circular dependencies, unused
  packages, and packages with known issues you can actually verify.

## Phase 3 — Synthesize

1. Build `REPOSITORY_SCORECARD.md`: score each dimension, and pull the
   single highest-severity + highest-confidence findings into the Top
   10 list.
2. Run the Post-Execution and Self-Review checklists in
   `checklists/verification-checklists.md`.
3. Confirm zero files were modified during the run.

## Common pitfalls

- Treating "no static reference found" as proof of dead code without
  checking for dynamic loading patterns.
- Reporting structural suggestions without anchoring them to the
  repository's own conventions (importing an external "best practice"
  that doesn't fit this codebase).
- Letting confidence creep upward across many findings of the same
  type — each one needs its own evidence check.
