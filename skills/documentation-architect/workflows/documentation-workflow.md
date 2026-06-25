# Documentation Workflow

A detailed, step-by-step walkthrough of how documentation-architect
should run. SKILL.md has the condensed version; this is the expanded
reference.

## Phase 0 — Orient

1. Read `POST_REFACTOR_STRUCTURE.md` and `ARCHITECTURE_AUDIT.md` for
   the architecture map and target structure.
2. Read `REFACTOR_SUMMARY.md` for what changed and why, so descriptions
   match current behavior rather than pre-refactor behavior.
3. Skim the actual repository to confirm the above still matches —
   treat the prior stages' documents as a strong starting point, not
   ground truth that needs no checking.

## Phase 1 — Document each category

For every item you document, gather all seven required fields before
writing the entry: Purpose, Inputs, Outputs, Dependencies, Side
Effects, Examples, Common Failure Modes. If you can't fill one in with
confidence, write what you observed and flag the uncertainty rather
than guessing.

1. **`ARCHITECTURE.md`** — module map, a diagram (Mermaid or ASCII),
   data flow for the 1–2 most important flows, key decisions.
2. **`COMPONENT_GUIDE.md`** — one entry per component.
3. **`SERVICE_GUIDE.md`** — one entry per service.
4. **`UTILITY_GUIDE.md`** — one entry per shared utility.
5. **`API_REFERENCE.md`** — one entry per public API surface, with
   request/response or call/return examples taken from real call
   sites.
6. **`DEPENDENCY_MAP.md`** — internal + external dependency graph,
   reflecting the post-refactor state.
7. **`README.md`** — top-level overview, linking out to everything
   else rather than repeating it.
8. **`ONBOARDING_GUIDE.md`** — written for someone who's never seen
   this repo; point at the 2–4 most important files to read first, in
   the order that builds understanding fastest.
9. **`CONTRIBUTING.md`** — actual current conventions (pulled from the
   post-refactor `NAMING_CONVENTIONS.md`), not aspirational ones.
10. **`TROUBLESHOOTING.md`** — aggregate every Common Failure Mode
    written across the other documents into one searchable place.

## Phase 2 — Cross-link and verify

1. Make sure every internal link between documents resolves to a file
   that actually exists.
2. Spot-check at least 3 documented items against the actual source
   file.
3. Confirm every major folder, every service, every utility, and every
   public API is represented somewhere in the documentation set.

## Common pitfalls

- Documenting what a function's name implies instead of what it
  actually does.
- Copying an example from documentation rather than from a real call
  site in the codebase.
- Letting `README.md` re-explain the architecture instead of linking
  to `ARCHITECTURE.md`.
