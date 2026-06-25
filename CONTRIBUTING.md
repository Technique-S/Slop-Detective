# Contributing

Thanks for considering a contribution to Repository Excellence Suite.
This project is a set of Claude Code skills, so "contributing" mostly
means improving markdown — SKILL.md instructions, templates,
checklists, workflows, and documentation — rather than writing
application code. That doesn't make it lower-stakes: a vague
instruction in a SKILL.md can produce inconsistent behavior across
many runs, so precision matters as much here as it would in code.

## Ways to contribute

- **Fix unclear or incorrect instructions** in any `SKILL.md`,
  `README.md`, or `workflows/*.md`.
- **Improve a template** in any `skills/*/templates/` folder — e.g. a
  field that's commonly left blank in practice probably needs better
  guidance text.
- **Add or improve an example** in `examples/` — see
  [`docs/examples/README.md`](docs/examples/README.md) for what makes
  a good one.
- **Report a gap** between what a skill's `SKILL.md` says it does and
  what it actually does when invoked.
- **Propose a new skill** for the pipeline — see
  [`ROADMAP.md`](ROADMAP.md) for the bar this would need to clear.
- **Improve documentation** under `docs/` or this repository's root.

## Before opening a pull request

1. **Check the artifact contract.** If you're changing a skill's
   inputs or outputs, update
   [`orchestrator/artifact_contracts.md`](orchestrator/artifact_contracts.md)
   and [`orchestrator/quality_gates.md`](orchestrator/quality_gates.md)
   in the same PR — these three things drift out of sync easily and
   that's the single most common source of confusing behavior in this
   suite.
2. **Update the matching example.** If you change a template's
   structure, update the corresponding file under `examples/` so it
   stays representative.
3. **Check cross-links.** Every internal markdown link should resolve.
   A broken relative link between `skills/`, `docs/`, and `examples/`
   is an easy mistake when moving files — search for the old path
   before you remove or rename anything.
4. **Run the pre-release validation checklist** in
   [`docs/release_process.md`](docs/release_process.md) even for a
   small PR — it catches most of the issues above quickly.

## Coding/writing conventions for this repository

- Write SKILL.md instructions the way you'd brief a careful, literal-
  minded colleague: state the constraint, then state why it matters.
  "Never delete suspected dead code" is a rule; "...because dynamic
  imports can make live code look unreferenced" is the reasoning that
  keeps someone from accidentally working around the rule later.
- Keep each skill's forbidden/allowed lists explicit rather than
  implied — ambiguity here is exactly what the four-stage separation
  is meant to eliminate.
- Templates should guide with HTML comments (`<!-- like this -->`)
  rather than pre-filled example text that might get mistaken for real
  content.

## Branching and PRs

- Branch from `main`, name branches descriptively
  (`fix/dead-code-template-wording`, `feat/python-dependency-audit`).
- Keep PRs scoped to one skill or one cross-cutting concern at a time
  where possible — a PR that touches all five skills' `SKILL.md` files
  for unrelated reasons is harder to review than five small ones.
- Reference the issue you're addressing, if one exists.

## Versioning

This project follows the versioning strategy in
[`docs/release_process.md`](docs/release_process.md). If your change
would break an existing artifact contract or required directory
structure, say so explicitly in your PR description — it changes how
the maintainers will version the next release.

## Code of conduct

Be direct, be kind, assume good faith. Disagreements about how a skill
should behave are welcome and expected — this suite encodes a lot of
judgment calls about where the line between "safe refactor" and "too
risky" sits, and reasonable people will draw that line differently in
different contexts.
