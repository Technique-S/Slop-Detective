# The Pipeline

Repository Excellence Suite runs four specialized skills in a fixed
order, each one deliberately restricted to a single kind of work. This
page explains *why* it's structured this way and what to expect at
each stage. For the precise technical contract — exact required
artifacts, exact quality gate criteria — see
[`../orchestrator/pipeline.md`](../orchestrator/pipeline.md),
[`../orchestrator/artifact_contracts.md`](../orchestrator/artifact_contracts.md),
and [`../orchestrator/quality_gates.md`](../orchestrator/quality_gates.md).

## The four stages

**1. repository-auditor** looks at everything and changes nothing. It
produces nine reports covering architecture, dead code, duplication,
complexity, naming, structure, type safety, and dependencies, plus a
scorecard that ranks the most important issues. This is the only stage
that's read-only by design — every finding it produces is evidence
someone else can act on with confidence.

**2. repository-surgeon** acts only on what the audit found. It never
adds features or changes behavior — only naming, structure,
duplication, dead code, complexity, type safety, and dependencies, in
that specific order, with a build-and-test check after every single
change. Every change is logged with a recorded rollback method before
the next change begins.

**3. documentation-architect** writes the documentation a new
contributor would actually want: README, architecture overview,
component/service/utility guides, an API reference, an onboarding
guide, a contributing guide, and a troubleshooting guide — all
describing the repository as it exists *after* the refactor, not
before it.

**4. repository-guardian** trusts none of the above. It independently
re-verifies architecture, refactors, documentation, naming, complexity,
dead code, and dependencies from scratch, then issues a final verdict:
approved, conditionally approved, or rejected.

## Why this order, and why these boundaries

Each stage assumes the one before it did its job honestly, and each
stage is restricted in a way that makes that assumption reasonable:

- The auditor can't quietly fix anything, so its findings are pure
  observation, not observation mixed with unverified intervention.
- The surgeon can't act on anything the auditor didn't find, so its
  changes are traceable to evidence rather than to taste.
- The documentation-architect can't change code, so its docs describe
  what's really there rather than what would be convenient to claim.
- The guardian doesn't take any of the above on faith, so the final
  approval actually means something.

If you only want part of this — say, just an audit, with no changes —
you can invoke `repository-auditor` directly instead of running the
full pipeline through `repository-orchestrator`. See
[`quickstart.md`](./quickstart.md) for the common path and
[`installation.md`](./installation.md) for installing a subset of the
skills.

## Handoffs and failure

Artifacts flow strictly forward — each stage's outputs become the
next stage's required inputs, never the reverse. If a stage can't meet
its quality gate, the pipeline halts and produces a `FAILURE_REPORT.md`
rather than letting a later stage compensate for an earlier one's
problem. See [`../orchestrator/quality_gates.md`](../orchestrator/quality_gates.md)
for exactly what "meeting the gate" requires at each stage, and
[`architecture.md`](./architecture.md) for diagrams of the artifact
flow and the quality-gate decision points.
