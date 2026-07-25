# Legacy Mixed Job Order Structure

> **Status:** Legacy / Superseded  
> **Reason archived:** Mixed Desktop master, history, user, schedule, and PLC execution fields.  
> **Replacements:** `03_Desktop/Domain/JobOrder.md` and `ST_JobExecution.md`

---

# ST_JobOrder

---

# Purpose

Represents a feeding job to be executed by the PLC.

A Job Order defines what recipe will be executed, on which line, and under what conditions.

---

# Structure

```iecst
TYPE ST_JobOrder :
STRUCT

    JobId               : UDINT;

    Enabled             : BOOL;

    JobState            : E_JobState;

    Priority            : USINT;

    LineId              : USINT;

    RecipeId            : UINT;

    FeedAmountKg        : REAL;

    FeedingTimeSec      : UDINT;

    StartTime           : DT;

    EndTime             : DT;

    RequestedBy         : UINT;

    ExecutedBy          : UINT;

    ProgressPercent     : REAL;

    RetryCount          : USINT;

    LastError           : UINT;

END_STRUCT
END_TYPE
```

---

# Updated By

Desktop Application

Job Scheduler

---

# Read By

FB_SchedulerManager

FB_FeedingControlManager

FB_LineManager

---

# Description

JobId

Unique job identifier.

---

Enabled

Job available for execution.

---

JobState

Current execution state.

---

Priority

Execution priority.

Lower value means higher priority.

---

LineId

Target feeding line.

---

RecipeId

Recipe to execute.

---

FeedAmountKg

Requested feed quantity.

---

FeedingTimeSec

Requested feeding duration.

---

StartTime

Execution start time.

---

EndTime

Execution finish time.

---

RequestedBy

Operator who created the job.

---

ExecutedBy

Operator supervising execution.

---

ProgressPercent

Current execution progress.

---

RetryCount

Automatic retry counter.

---

LastError

Latest execution error.

---

# Rules

JobId shall be unique.

Only Enabled jobs may execute.

Completed jobs are read-only.

Cancelled jobs cannot restart.

---

# State Flow

```text
Created
    │
    ▼
Waiting
    │
    ▼
Running
    │
 ┌──┴──┐
 ▼     ▼
Done  Error
       │
       ▼
Retry
```

---

# Lifetime

Stored permanently in the database.

PLC executes only the active job.

Completed jobs remain in history.

---

# Example

```iecst
JobQueue[1]
JobQueue[2]
JobQueue[3]
...
JobQueue[100]
```