# Release Process

How Repository Excellence Suite is versioned and released.

## Versioning Strategy

This project follows [Semantic Versioning](https://semver.org/)
(`MAJOR.MINOR.PATCH`), applied at the suite level — all five skills
ship and version together, since they're built as a coordinated
pipeline and a version mismatch between, say, `repository-auditor` and
`repository-surgeon` could mean their artifact contract silently
drifts out of sync.

- **MAJOR** — a breaking change to an artifact contract (a required
  field renamed or removed, an output file renamed, a quality gate
  tightened in a way that could fail previously-passing repositories),
  or a change to the required skill directory structure.
- **MINOR** — a new template field, a new optional artifact, a new
  checklist item, a new example, or expanded documentation that doesn't
  break any existing contract.
- **PATCH** — wording fixes, typo corrections, clarified instructions
  that don't change behavior or structure.

Each skill's `SKILL.md` carries its own `version` field, which should
match the suite version at release time (this suite doesn't currently
support independent per-skill versioning — see
[`ROADMAP.md`](../ROADMAP.md)).

## Release Checklist

1. Update the `version` field in all five `SKILL.md` files.
2. Update [`CHANGELOG.md`](../CHANGELOG.md) with a new dated entry
   under the new version, following [Keep a Changelog](https://keepachangelog.com/)
   format (Added / Changed / Fixed / Removed).
3. Run the validation pass described below.
4. Tag the release in git: `git tag vX.Y.Z && git push --tags`.
5. Create a GitHub Release from the tag, with the relevant
   `CHANGELOG.md` section as the release notes.

## Pre-Release Validation

Before tagging any release, confirm:

- [ ] Every skill folder under `skills/` contains `SKILL.md`,
      `README.md`, `workflows/`, `templates/`, and `checklists/`
- [ ] Every `SKILL.md` has complete frontmatter: `name`, `description`,
      `version`, `author`, `tags`
- [ ] Every internal markdown link resolves to a file that actually
      exists (no broken relative links between skills, docs, examples)
- [ ] `examples/` contains realistic output for all four pipeline
      stages
- [ ] `docs/installation.md`'s commands are accurate against the
      current `skills/` folder names
- [ ] The orchestrator's artifact contracts in
      `orchestrator/artifact_contracts.md` match what each skill's
      `SKILL.md`/`README.md` actually declares as inputs/outputs
- [ ] `CHANGELOG.md` has an entry for this version

## Suggested GitHub Labels

| Label | Purpose |
|---|---|
| `bug` | Something doesn't work as documented |
| `enhancement` | New feature or capability request |
| `documentation` | Docs-only changes |
| `skill:auditor` | Scoped to repository-auditor |
| `skill:surgeon` | Scoped to repository-surgeon |
| `skill:documentation-architect` | Scoped to documentation-architect |
| `skill:guardian` | Scoped to repository-guardian |
| `skill:orchestrator` | Scoped to repository-orchestrator |
| `good first issue` | Suitable for new contributors |
| `needs-triage` | Not yet assessed |
| `breaking-change` | Requires a MAJOR version bump |

## Suggested GitHub Milestones

| Milestone | Theme |
|---|---|
| v1.0 | Initial public release — all five skills, full docs, examples |
| v1.x | Stability, bug fixes, additional language/framework coverage in templates |
| v2.0 | Any breaking artifact-contract changes (see [`ROADMAP.md`](../ROADMAP.md)) |

## Support Channel

Use GitHub Issues for bug reports and feature requests. See
[`CONTRIBUTING.md`](../CONTRIBUTING.md) for how to file a good one.
