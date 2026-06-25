# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
See [`docs/release_process.md`](docs/release_process.md) for what
qualifies as MAJOR / MINOR / PATCH for this suite.

## [Unreleased]

### Planned

- See [`ROADMAP.md`](ROADMAP.md) for planned v1.x work.

## [1.0.0] — 2026-06-26

### Added

- Initial public release of the Repository Excellence Suite.
- Five Claude Code skills under `skills/`: `repository-auditor`,
  `repository-surgeon`, `documentation-architect`, `repository-guardian`,
  and `repository-orchestrator` (the single entry point coordinating
  the other four).
- Each skill ships with `SKILL.md`, `README.md`, `workflows/`,
  `templates/`, and `checklists/`.
- Suite-wide pipeline documentation in `orchestrator/`: `pipeline.md`,
  `artifact_contracts.md`, `quality_gates.md`, and
  `workflow_state_template.md`.
- User-facing documentation in `docs/`: `installation.md`,
  `quickstart.md`, `pipeline.md`, `architecture.md` (with Mermaid
  diagrams for the skill pipeline, artifact flow, quality gate flow,
  and repository lifecycle), and `release_process.md`.
- Realistic example outputs for every pipeline stage under `examples/`,
  built around one consistent fictional project (TaskFlow API) so the
  same issues can be traced from audit finding through refactor,
  documentation, and final review.
- Diagram source files under `assets/diagrams/`.
- This `CHANGELOG.md`, `CONTRIBUTING.md`, `ROADMAP.md`, and `LICENSE`.

### Changed

- Renamed the orchestrator skill from the original internal name
  `repository-excellence-orchestrator` to `repository-orchestrator` for
  the public release.
- Restructured the repository from a flat collection of skill folders
  into the `skills/` / `orchestrator/` / `docs/` / `examples/` /
  `assets/` layout described in [`docs/architecture.md`](docs/architecture.md).
- Added a `workflows/` subfolder to every skill, separating the
  condensed instructions in `SKILL.md` from a fully expanded,
  step-by-step procedure.
- Added full skill metadata (`version`, `author`, `tags`) to every
  `SKILL.md` frontmatter block.
- Added an `Artifact Status` section to `WORKFLOW_STATE.md` (and its
  template), tracking per-stage artifact presence/verification
  explicitly rather than only stage-level completion.
