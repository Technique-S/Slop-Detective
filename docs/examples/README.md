# Examples

This page indexes the realistic example outputs that ship with the
suite. The actual example files live at the repository root under
[`/examples`](../../examples/), organized by pipeline stage rather than
under `docs/` — keeping generated-style content out of the
documentation tree makes it easier to tell "explanation of the system"
apart from "sample of what the system produces."

| Stage | Example folder | Demonstrates |
|---|---|---|
| repository-auditor | [`examples/sample-audit/`](../../examples/sample-audit/) | Architecture Audit, Dead Code Report, Duplication Report, Complexity Report, Dependency Audit |
| repository-surgeon | [`examples/sample-refactor/`](../../examples/sample-refactor/) | Refactor Summary |
| documentation-architect | [`examples/sample-documentation/`](../../examples/sample-documentation/) | A representative documentation output |
| repository-guardian | [`examples/sample-final-review/`](../../examples/sample-final-review/) | Final Review, Quality Scorecard |

## How to use these

These are intentionally based on a small, realistic example codebase —
not a toy "foo/bar" example and not a sanitized best-case scenario.
They're meant to show the *quality bar* expected of each output: how
specific the evidence should be, how a finding should read, how a
scorecard should be justified. When in doubt about how detailed a
report should be, compare against the matching example here before
asking the skill to redo it.

If you're contributing a new template or modifying an existing one,
update the matching example to stay consistent — a template and its
example drifting apart is confusing for anyone using this suite for
the first time.
