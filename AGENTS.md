# Repository Excellence Suite — Agent Onboarding

This repository contains the **Repository Excellence Suite**, a four-stage AI skill pipeline that audits, refactors, documents, and independently reviews any codebase.

## What's here

| Path | Contents |
|------|----------|
| `skills/repository-auditor/SKILL.md` | Read-only codebase audit (9 reports + scorecard) |
| `skills/repository-surgeon/SKILL.md` | Evidence-based refactoring from audit findings |
| `skills/documentation-architect/SKILL.md` | Grounded documentation of post-refactor code |
| `skills/repository-guardian/SKILL.md` | Independent final re-verification |
| `orchestrator/SKILL.md` | Single entry point coordinating all 4 stages |
| `skill.json` | Universal manifest describing all skills |
| `opencode.json` | Native OpenCode config with commands |
| `.well-known/skills/index.json` | URL-based skill discovery |

## How to install

**If you're running on the user's machine:**
1. Clone this repo
2. Run `install.sh` (Unix) or `install.ps1` (Windows) — it auto-detects the platform and copies skills to the correct directory
3. No install script available? Copy each `skills/<name>/` folder into the platform's skills directory (e.g. `~/.claude/skills/`, `~/.config/opencode/skills/`, `~/.gemini/skills/`)

**If you received this repo URL from the user:**
1. Read `skill.json` to find all 5 skills and their descriptions
2. Read each `SKILL.md` for the full instructions
3. Determine which platform you're running on
4. Copy the skill directories to the platform's skills location

## Pipeline order

```
repository-auditor → repository-surgeon → documentation-architect → repository-guardian
```

Each stage produces artifacts that the next stage consumes. Never skip stages or run them out of order. The orchestrator skill automates this sequence.

## Key rules

- **repository-auditor** NEVER edits files — it only reads and reports
- **repository-surgeon** ONLY makes changes backed by specific audit findings
- **documentation-architect** documents what actually exists, not what should exist
- **repository-guardian** re-verifies everything from scratch — never trusts earlier stages' self-reports
