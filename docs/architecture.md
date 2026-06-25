# Architecture

This page contains the four diagrams that describe how Repository
Excellence Suite is put together: the skill pipeline, the artifact
flow between stages, the quality-gate decision flow, and the overall
lifecycle a target repository goes through during a full run.

## Skill Pipeline

The four worker skills run in a fixed order, coordinated by
`repository-orchestrator`.

```mermaid
flowchart LR
    O[repository-orchestrator] -.coordinates.-> A
    O -.coordinates.-> B
    O -.coordinates.-> C
    O -.coordinates.-> D

    A[repository-auditor<br/>read-only] --> B[repository-surgeon<br/>safe refactor]
    B --> C[documentation-architect<br/>accurate docs]
    C --> D[repository-guardian<br/>independent review]
```

## Artifact Flow

Each stage's outputs become the next stage's required inputs. Nothing
flows backward, and nothing skips a stage.

```mermaid
flowchart TD
    subgraph Stage1[repository-auditor]
        A1[ARCHITECTURE_AUDIT.md]
        A2[DEAD_CODE_REPORT.md]
        A3[DUPLICATION_REPORT.md]
        A4[COMPLEXITY_REPORT.md]
        A5[NAMING_CONVENTIONS.md]
        A6[PROJECT_STRUCTURE.md]
        A7[TYPE_SAFETY_REPORT.md]
        A8[DEPENDENCY_AUDIT.md]
        A9[REPOSITORY_SCORECARD.md]
    end

    subgraph Stage2[repository-surgeon]
        B1[REFACTOR_LOG.md]
        B2[CHANGESET.md]
        B3[REFACTOR_SUMMARY.md]
        B4[POST_REFACTOR_STRUCTURE.md]
    end

    subgraph Stage3[documentation-architect]
        C1[README.md]
        C2[ARCHITECTURE.md]
        C3[COMPONENT_GUIDE.md]
        C4[SERVICE_GUIDE.md]
        C5[UTILITY_GUIDE.md]
        C6[DEPENDENCY_MAP.md]
        C7[API_REFERENCE.md]
        C8[ONBOARDING_GUIDE.md]
        C9[CONTRIBUTING.md]
        C10[TROUBLESHOOTING.md]
    end

    subgraph Stage4[repository-guardian]
        D1[FINAL_REVIEW.md]
        D2[QUALITY_SCORECARD.md]
        D3[REGRESSION_REPORT.md]
        D4[FINAL_APPROVAL.md]
    end

    Stage1 --> Stage2
    Stage2 --> Stage3
    Stage1 -.also read by.-> Stage3
    Stage1 -.also read by.-> Stage4
    Stage2 -.also read by.-> Stage4
    Stage3 --> Stage4
```

## Quality Gate Flow

Every stage is checked against its own gate before the orchestrator
advances the pipeline. A failed gate halts the pipeline rather than
letting a later stage absorb the problem.

```mermaid
flowchart TD
    Start([Stage begins]) --> Run[Stage executes its workflow]
    Run --> Check{Quality gate met?}
    Check -->|Yes| Record[Record outputs + quality score<br/>in WORKFLOW_STATE.md]
    Record --> Next{More stages remaining?}
    Next -->|Yes| Advance[Advance to next stage]
    Advance --> Start
    Next -->|No| Done([Pipeline complete])
    Check -->|No| Fail[Write FAILURE_REPORT.md<br/>Record failure in WORKFLOW_STATE.md]
    Fail --> Halt([Pipeline halts —<br/>human or re-run decides next step])
```

## Repository Lifecycle

The state a target repository moves through over the course of one
full pipeline run.

```mermaid
stateDiagram-v2
    [*] --> Unaudited
    Unaudited --> Audited: repository-auditor completes
    Audited --> Refactored: repository-surgeon completes
    Refactored --> Documented: documentation-architect completes
    Documented --> Reviewed: repository-guardian completes
    Reviewed --> Approved: FINAL_APPROVAL.md = approved
    Reviewed --> ConditionallyApproved: FINAL_APPROVAL.md = conditionally-approved
    Reviewed --> Rejected: FINAL_APPROVAL.md = rejected
    ConditionallyApproved --> Refactored: conditions resolved, re-enter pipeline
    Rejected --> Audited: blocking issues addressed, re-enter pipeline
    Approved --> [*]
```
