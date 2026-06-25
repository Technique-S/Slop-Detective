# About This Example

Every example in `/examples` is drawn from the same small, fictional
project — **TaskFlow API**, a Node.js/Express REST API for managing
tasks and users, backed by a lightweight JSON file store. It has the
kind of issues a real AI-assisted or fast-moving codebase accumulates:
a duplicated validation module, one dead legacy handler left over from
a prior refactor, a few naming inconsistencies, and a circular
dependency between two services.

TaskFlow API isn't a real published project — it exists only to give
these examples concrete, consistent file paths and line numbers so you
can see what a *specific, evidence-backed* finding looks like, rather
than a generic placeholder. The same project, the same handful of
files, and the same issues are referenced across `sample-audit/`,
`sample-refactor/`, `sample-documentation/`, and `sample-final-review/`
so you can follow one issue (e.g. the duplicated validation logic) all
the way from "found by the auditor" to "fixed by the surgeon" to
"documented" to "independently re-verified by the guardian."

## TaskFlow API's (fictional) structure, pre-refactor

```
taskflow-api/
├── src/
│   ├── index.js
│   ├── routes/
│   │   ├── tasks.js
│   │   └── users.js
│   ├── services/
│   │   ├── taskService.js
│   │   └── userService.js
│   ├── utils/
│   │   ├── validate.js
│   │   └── validation.js        ← near-duplicate of validate.js
│   ├── legacy/
│   │   └── oldTaskHandler.js     ← unreferenced since the Express migration
│   └── models/
│       └── Task.js
├── package.json
└── tests/
    └── tasks.test.js
```
