# SERVICE_GUIDE.md

## taskService

- **Location:** `src/services/taskService.js`
- **Purpose:** Create, read, update, and delete tasks; enforces task
  validation rules before persistence.
- **Inputs:** task objects of shape `{ title: string, description?:
  string, dueDate?: string (ISO 8601), assigneeEmail?: string,
  priority?: 'low'|'medium'|'high' }`
- **Outputs:** persisted task objects including a generated `id` and
  `createdAt` timestamp.
- **Dependencies:** `src/models/Task.js` for persistence,
  `src/utils/validate.js` for title/email validation,
  `src/services/userTaskLookup.js` for assignee task-count tracking.
- **Side effects:** writes to the JSON file store via `models/Task.js`;
  calls `userTaskLookup.incrementAssignedTaskCount()` when a task is
  created with an assignee, and
  `userTaskLookup.decrementAssignedTaskCount()` when a task is deleted
  or reassigned.
- **Example usage:**

```js
const taskService = require('./services/taskService');

const task = await taskService.createTask({
  title: 'Write Q2 report',
  assigneeEmail: 'alex@example.com',
  priority: 'high',
});
// => { id: 'task_7f2a', title: 'Write Q2 report', ..., createdAt: '2026-03-15T10:00:00Z' }
```

- **Common failure modes:** `createTask()` throws a `ValidationError`
  if `title` is empty or longer than 200 characters, or if
  `assigneeEmail` is present but not a valid email format. If
  `assigneeEmail` doesn't correspond to an existing user,
  `createTask()` still succeeds but the task is created with no
  assignee task-count increment — this is a known soft-failure
  documented further in `TROUBLESHOOTING.md`.

## userService

- **Location:** `src/services/userService.js`
- **Purpose:** Create and look up users; tracks each user's current
  assigned-task count.
- **Inputs:** user objects of shape `{ email: string, name: string }`.
- **Outputs:** persisted user objects including `assignedTaskCount`.
- **Dependencies:** `src/utils/validate.js` for email validation,
  `src/services/userTaskLookup.js` for task-count synchronization.
- **Side effects:** writes to the JSON file store.
- **Example usage:**

```js
const userService = require('./services/userService');

const user = await userService.getUser('alex@example.com');
// => { email: 'alex@example.com', name: 'Alex Kim', assignedTaskCount: 3 }
```

- **Common failure modes:** `getUser()` returns `null` (not a thrown
  error) for a nonexistent email — callers that don't explicitly check
  for `null` before accessing a property will get a runtime
  `TypeError`. This is the most common integration mistake found
  during the documentation pass; see `TROUBLESHOOTING.md`.
