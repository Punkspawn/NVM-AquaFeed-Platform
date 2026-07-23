# IF_JobOrder

---

# Purpose

Defines the standard software interface for production job management.

A Job Order represents a complete feeding task that combines the selected line, recipe, feed quantity and execution parameters into a single production command.

This interface standardizes how jobs are created, queued, executed and completed.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables job management. |
| Create | BOOL | Creates a new job. |
| Start | BOOL | Starts the selected job. |
| Pause | BOOL | Pauses the active job. |
| Resume | BOOL | Resumes a paused job. |
| Cancel | BOOL | Cancels the active job. |
| Job | ST_JobOrder | Job order structure. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Job manager is ready. |
| JobCreated | BOOL | Job successfully created. |
| Running | BOOL | Job execution is active. |
| Paused | BOOL | Job execution is paused. |
| Completed | BOOL | Job completed successfully. |
| Cancelled | BOOL | Job cancelled by operator. |
| Fault | BOOL | Job execution fault detected. |
| ActiveJobID | UINT | Currently executing job ID. |
| AlarmCode | UINT | Active job alarm code. |

---

# State Flow

```text
Idle
   │
Create
   │
Ready
   │
Start
   │
Running
```

Pause sequence

```text
Running
    │
Pause
    │
Paused
    │
Resume
    │
Running
```

Completion sequence

```text
Running
    │
Completed
    │
Idle
```

Cancellation sequence

```text
Running
    │
Cancel
    │
Cancelled
    │
Idle
```

Fault sequence

```text
Any State
    │
Fault
    │
Reset
    │
Idle
```

---

# Rules

- Only one job shall be active at any given time.
- A job shall reference one valid recipe.
- A job shall reference one valid feeding line.
- A completed or cancelled job shall not be restarted.
- Job execution shall immediately stop if a system fault occurs.
- `AlarmCode` shall be zero when no job-related alarm is active.

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_LineManager
- FB_RecipeManager
- HMI
- AquaFeed Manager
- Reporting System