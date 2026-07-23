# Function

FN_IsLineAvailable

---

# Purpose

Determines whether a feeding line is available to accept a new feeding job.

A line is considered available only when it is enabled, not occupied by another job, free of active faults, and not in Emergency Stop or Maintenance mode.

This function provides a centralized availability check for the AquaFeed scheduling system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| LineEnabled | BOOL | Line is enabled for operation |
| JobRunning | BOOL | A feeding job is currently active |
| FaultActive | BOOL | Line has an active fault |
| EmergencyStop | BOOL | Emergency Stop is active |
| MaintenanceMode | BOOL | Line is in maintenance mode |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the line is available |

---

# Logic

```text
IF NOT LineEnabled THEN
    Return := FALSE;

ELSIF EmergencyStop THEN
    Return := FALSE;

ELSIF MaintenanceMode THEN
    Return := FALSE;

ELSIF FaultActive THEN
    Return := FALSE;

ELSIF JobRunning THEN
    Return := FALSE;

ELSE
    Return := TRUE;

END_IF;
```

---

# Rules

- Disabled lines shall never be available.
- Emergency Stop has the highest priority.
- A line with an active fault shall not accept new jobs.
- A running job prevents assignment of another job.
- Maintenance mode makes the line unavailable.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Line ready for a new job | TRUE |
| Any blocking condition exists | FALSE |

---

# Typical Usage

- Automatic job scheduler
- Recipe execution
- Job assignment
- Multi-line coordination
- Operator HMI
- Startup validation

---

# Used By

- FB_JobManager
- FB_LineManager
- FB_RecipeManager
- FB_SystemManager
- FB_FeedingControlManager

---

# Test Cases

| Enabled | Job | Fault | E-Stop | Maintenance | Expected |
|----------|-----|-------|--------|-------------|----------|
| TRUE | FALSE | FALSE | FALSE | FALSE | TRUE |
| TRUE | TRUE | FALSE | FALSE | FALSE | FALSE |
| TRUE | FALSE | TRUE | FALSE | FALSE | FALSE |
| TRUE | FALSE | FALSE | TRUE | FALSE | FALSE |
| TRUE | FALSE | FALSE | FALSE | TRUE | FALSE |
| FALSE | FALSE | FALSE | FALSE | FALSE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates whether a line is currently available for scheduling.

It does not:

- Reserve the line
- Start a feeding job
- Change the line state
- Reset alarms
- Allocate recipes
- Synchronize multiple lines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_LineManager.md
- FB_JobManager.md
- FB_FeedingControlManager.md
- FN_GetLineStatus.md
- TEST_Functions.md

---

# Revision

Version 1.0