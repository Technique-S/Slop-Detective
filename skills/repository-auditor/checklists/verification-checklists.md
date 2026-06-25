# repository-auditor — Verification Checklists

## Pre-Execution Checklist

- [ ] Confirmed this is a read-only task — no edit/delete/move/rename tool
      calls will be made against repository source files
- [ ] Repository root identified and confirmed accessible
- [ ] Build/package files identified (package.json, requirements.txt,
      go.mod, Cargo.toml, etc.) so dependency analysis has a real source
      of truth
- [ ] Entry points identified (main files, index files, app
      bootstrapping) so reachability analysis has a starting point

## Execution Checklist

- [ ] Every file in scope has been read at least once — not sampled
- [ ] Architecture map covers every top-level module/folder
- [ ] Dependency graph includes both internal and external dependencies
- [ ] Every finding uses the standard format: Issue, Location, Evidence,
      Severity, Confidence, Risk, Recommendation
- [ ] Findings are evidence-based — each one points at an actual
      file:line or actual reference search, not a generalization
- [ ] Low-confidence findings are marked as such rather than presented
      with unwarranted certainty

## Post-Execution Checklist

- [ ] All 9 reports generated: ARCHITECTURE_AUDIT.md, DEAD_CODE_REPORT.md,
      DUPLICATION_REPORT.md, COMPLEXITY_REPORT.md, NAMING_CONVENTIONS.md,
      PROJECT_STRUCTURE.md, TYPE_SAFETY_REPORT.md, DEPENDENCY_AUDIT.md,
      REPOSITORY_SCORECARD.md
- [ ] REPOSITORY_SCORECARD.md's Quality Gate Status section is fully
      checked off
- [ ] No report contains an unfilled template placeholder
- [ ] Confirmed zero source files were modified during this run (diff
      the repo against its state before the audit started, if possible)

## Self-Review Checklist

- [ ] Re-read REPOSITORY_SCORECARD.md's Top 10 Issues — does this
      actually match what the other 8 reports found, or did something
      get lost in summarization?
- [ ] Spot-check 3 random findings against the actual file — does the
      evidence cited actually say what the finding claims?
- [ ] Check for contradictions between reports (e.g. a function flagged
      dead in DEAD_CODE_REPORT.md but also flagged high-complexity,
      implying it's actually called somewhere)

## Failure Recovery Checklist

- [ ] If scan coverage couldn't reach 100% (e.g. a file too large to
      read, a binary format, a generated file): note the gap explicitly
      in PROJECT_STRUCTURE.md and REPOSITORY_SCORECARD.md rather than
      silently presenting partial coverage as complete
- [ ] If a tool/script needed for analysis isn't available in this
      environment: fall back to manual reading and note the reduced
      confidence level on affected findings
- [ ] If the repository is too large to fully audit in one pass: audit
      module-by-module, merging into the same 9 reports, and note in
      WORKFLOW_STATE.md (if running under the orchestrator) which
      modules are covered so far
