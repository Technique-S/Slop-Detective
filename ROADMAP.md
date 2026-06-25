# Roadmap

This roadmap is intentionally modest for a v1.0 release — the priority
right now is making sure the five existing skills are reliable and
well-documented before adding scope.

## v1.0 (current)

- [x] Four-stage pipeline: repository-auditor, repository-surgeon,
      documentation-architect, repository-guardian
- [x] repository-orchestrator as a single entry point
- [x] Full artifact contracts and quality gates
- [x] Realistic examples for every pipeline stage
- [x] Installation, quickstart, pipeline, and architecture documentation

## v1.x (planned)

- [ ] Language/framework-specific guidance baked into the auditor's
      templates (current templates are intentionally language-agnostic;
      e.g. Python-specific dead-code patterns around `__init__.py`
      re-exports, or TypeScript-specific type-safety checks, could be
      called out more explicitly)
- [ ] A lighter-weight "audit only" quickstart path for users who only
      want repository-auditor without committing to the full pipeline
- [ ] Contributed example sets for additional project types (currently
      one fictional Node.js/Express example covers all four stages —
      a second example in a different language would stress-test
      whether the templates generalize)
- [ ] Screenshots/recordings of a real pipeline run (see
      [`assets/screenshots/README.md`](assets/screenshots/README.md))

## v2.0 (exploratory — not committed)

- [ ] Per-skill independent versioning, if the skills' release cadences
      diverge enough to justify it (currently all five version together
      — see [`docs/release_process.md`](docs/release_process.md))
- [ ] An optional "dry run" mode for repository-surgeon that produces
      `REFACTOR_LOG.md`-style entries without applying any change, for
      teams who want a previewable refactor plan before approving it
- [ ] Deeper integration with CI — e.g. a GitHub Action that runs
      repository-auditor on every PR and posts the scorecard as a
      comment (this is a meaningfully different operating mode than
      the current interactive-session design, so it needs its own
      design pass rather than a quick bolt-on)

## Explicitly out of scope (for now)

- **A fifth pipeline stage beyond the current four.** Each additional
  stage adds a handoff boundary that needs its own contract and gate;
  new stages should clear a high bar of "this is a genuinely distinct
  kind of work" rather than just splitting an existing stage's
  responsibilities differently.
- **Automatic, unsupervised application of refactors without human
  review of `FINAL_APPROVAL.md`.** The whole design point of having a
  guardian stage is an explicit approval checkpoint; removing the human
  review step would undermine that.

## How to propose something for this roadmap

Open an issue describing the gap and, ideally, which existing skill it
would extend versus whether it needs a new one. See
[`CONTRIBUTING.md`](CONTRIBUTING.md) for how proposals get evaluated.
