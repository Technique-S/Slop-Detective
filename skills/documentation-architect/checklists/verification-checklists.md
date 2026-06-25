# documentation-architect — Verification Checklists

## Pre-Execution Checklist

- [ ] repository-surgeon's REFACTOR_LOG.md, CHANGESET.md,
      REFACTOR_SUMMARY.md, and POST_REFACTOR_STRUCTURE.md all exist
- [ ] Confirmed the repository is in its post-refactor state (not
      documenting a version that's about to change again)
- [ ] All 9 auditor reports still available for reference — the audit's
      architecture/dependency findings remain useful context even after
      refactoring confirmed/changed some of them

## Execution Checklist

- [ ] Every top-level folder has a corresponding entry somewhere in the
      documentation set — nothing is documented by omission
- [ ] Every service is documented in SERVICE_GUIDE.md
- [ ] Every component (or equivalent unit) is documented in
      COMPONENT_GUIDE.md
- [ ] Every utility is documented in UTILITY_GUIDE.md
- [ ] Every externally-callable API surface is documented in
      API_REFERENCE.md
- [ ] Every documented item includes all required fields: Purpose,
      Inputs, Outputs, Dependencies, Side Effects, Examples, Common
      Failure Modes
- [ ] Examples are real and runnable against the actual current code —
      not invented syntax that looks plausible but doesn't match
- [ ] Architecture diagram reflects the POST-refactor structure, cross-
      checked against POST_REFACTOR_STRUCTURE.md, not the original
      pre-refactor architecture

## Post-Execution Checklist

- [ ] All 10 outputs generated: README.md, ARCHITECTURE.md,
      COMPONENT_GUIDE.md, SERVICE_GUIDE.md, UTILITY_GUIDE.md,
      DEPENDENCY_MAP.md, API_REFERENCE.md, ONBOARDING_GUIDE.md,
      CONTRIBUTING.md, TROUBLESHOOTING.md
- [ ] Dependency map generated and matches DEPENDENCY_AUDIT.md plus
      whatever the surgeon changed
- [ ] Architecture diagram generated
- [ ] Internal links between documents (e.g. README.md linking to
      ARCHITECTURE.md) all resolve to files that actually exist

## Self-Review Checklist

- [ ] Pick 3 documented items at random and verify against the actual
      source file — does the documented Purpose/Inputs/Outputs actually
      match the code, or does it match what the code "should" do?
- [ ] Read ONBOARDING_GUIDE.md as if you'd never seen this repo — does
      "Where to Start Reading" actually point somewhere useful?
- [ ] Check CONTRIBUTING.md's "Coding Conventions" against
      NAMING_CONVENTIONS.md as it stood after the surgeon stage, not
      the pre-refactor version

## Failure Recovery Checklist

- [ ] If a service/component/utility's actual behavior is ambiguous from
      reading the code alone: say so in the Common Failure Modes or as
      an inline note, rather than presenting a guess as documented fact
- [ ] If the repository is too large to document exhaustively in one
      pass: prioritize the highest fan-in modules and the public API
      surface first (per DEPENDENCY_AUDIT.md's coupling hotspots), and
      note explicitly in TROUBLESHOOTING.md or ONBOARDING_GUIDE.md what
      hasn't been documented yet
- [ ] If documentation reveals a discrepancy the surgeon stage missed
      (e.g. a function whose actual behavior contradicts its name even
      after the naming pass): note it rather than silently documenting
      around it — this is exactly the kind of thing repository-guardian
      needs to know about
