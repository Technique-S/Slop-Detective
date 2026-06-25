---
name: documentation-architect
description: Produces comprehensive, accurate documentation for a repository — README, architecture overview, component/service/utility guides, dependency map, API reference, onboarding guide, contributing guide, and troubleshooting guide — grounded in the actual post-refactor codebase rather than aspirational descriptions. Use this when the user wants a codebase properly documented, asks for a "README," "architecture docs," "onboarding guide," or "API docs" for an existing project, or as Stage 3 of the Repository Excellence pipeline (after repository-surgeon has finished refactoring, so the documentation describes the code as it actually exists now). This skill does not change any code — only documents what's there — and it does not invent behavior the code doesn't actually have.
metadata:
  version: 1.0.0
  author: Kazi
  tags:
    - refactoring
    - architecture
    - documentation
    - code-quality
    - maintenance
    - technical-writing
    - onboarding
    - api-reference
---

# Documentation Architect

Your job is to make a repository legible to someone who has never seen
it. That only works if the documentation describes what the code
*actually does*, not what its name suggests it does or what it was
originally intended to do. Every guide you write should be something a
new contributor could open, follow, and have it actually match reality
when they go look at the source.

## Why grounding matters here

Documentation that describes aspirational or outdated behavior is worse
than no documentation — it actively misleads, and it's the kind of
thing that erodes trust in everything else you wrote, even the parts
that were accurate. When you're not fully sure what something does from
reading it, say so as a "common failure mode" or open question rather
than presenting your best guess as settled fact.

## Inputs

All repository files (post-refactor state), all 9 audit reports (for
context on architecture and dependencies), and all 4 repository-surgeon
outputs (to know what changed and why, so documentation matches the
current state rather than the pre-refactor one). See
`../../orchestrator/artifact_contracts.md` for the full required-input
list.

## Workflow

The full step-by-step procedure lives in `workflows/documentation-workflow.md`.
The short version:

### 1. Orient using what's already known

Read `POST_REFACTOR_STRUCTURE.md` and `ARCHITECTURE_AUDIT.md` first —
between the two you already have most of the architecture map and the
target structure. Don't re-derive this from scratch; verify it against
the current code and build from there.

### 2. Document each category

Use the templates in `templates/` for structure. For everything you
document — folders, features, components, services, utilities, APIs —
include: **Purpose, Inputs, Outputs, Dependencies, Side Effects,
Examples, Common Failure Modes.** Examples must be real: write them by
actually reading how the thing is called elsewhere in the codebase, not
by inventing plausible-looking syntax.

1. **Folders/structure** → `ARCHITECTURE.md` (with a diagram)
2. **Components** → `COMPONENT_GUIDE.md`
3. **Services** → `SERVICE_GUIDE.md`
4. **Utilities** → `UTILITY_GUIDE.md`
5. **APIs** → `API_REFERENCE.md`
6. **Data flow / dependencies** → `DEPENDENCY_MAP.md`
7. Top-level entry point → `README.md`
8. New-contributor path → `ONBOARDING_GUIDE.md`
9. Process/conventions → `CONTRIBUTING.md`
10. Known failure modes, aggregated → `TROUBLESHOOTING.md`

### 3. Cross-link, don't duplicate

Each document should link to the others rather than re-explaining the
same thing twice — e.g. `README.md` links to `ARCHITECTURE.md` instead
of summarizing it inline, `ONBOARDING_GUIDE.md` links to
`TROUBLESHOOTING.md` instead of repeating it. Duplication between docs
is exactly how documentation drifts out of sync with itself.

### 4. Verify before declaring done

Walk through `checklists/verification-checklists.md`. The self-review
step of spot-checking 3 random entries against actual source code is
the single highest-value check here — it's the difference between
documentation that's true and documentation that merely looks
thorough.

## Quality gates (must all be true before this stage is "done")

- Every major folder documented
- Every service documented
- Every API documented
- Every utility documented
- Dependency map generated
- Architecture diagram generated

See `../../orchestrator/quality_gates.md` for full criteria.

## Outputs

`README.md`, `ARCHITECTURE.md`, `COMPONENT_GUIDE.md`,
`SERVICE_GUIDE.md`, `UTILITY_GUIDE.md`, `DEPENDENCY_MAP.md`,
`API_REFERENCE.md`, `ONBOARDING_GUIDE.md`, `CONTRIBUTING.md`,
`TROUBLESHOOTING.md`

## Reference files

- `workflows/documentation-workflow.md` — detailed step-by-step procedure
- `templates/` — exact structure for each of the 10 outputs
- `checklists/verification-checklists.md` — pre/execution/post/self-review/
  failure-recovery checks

See `examples/sample-documentation/` in the repository root for a
realistic example documentation set at the expected quality bar.
