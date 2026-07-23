# IF_Line

---

# Purpose

Defines the standard software interface for a feeding line.

Every Function Block that controls or monitors a feeding line shall use this interface to ensure consistent communication throughout the PLC software.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the line. |
| Start | BOOL | Starts a feeding cycle. |
| Stop | BOOL | Stops the feeding cycle. |
| Reset | BOOL | Clears faults and alarms. |
| Recipe | ST_Recipe | Active feeding recipe. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Line is ready for operation. |
| Running | BOOL | Feeding cycle is active. |
| Busy | BOOL | Line is occupied. |
| Completed | BOOL | Feeding cycle completed successfully. |
| Fault | BOOL | Line has an active fault. |
| AlarmCode | UINT | Active alarm code. |

---

# State Flow

```text
Disabled
    │
Enable
    │
Ready
    │
Start
    │
Running
    │
Completed
    │
Ready
```

Fault condition

```text
Any State
    │
Fault
    │
Reset
    │
Ready
```

---

# Rules

- A line shall not start unless `Ready = TRUE`.
- `Busy` shall remain TRUE during an active feeding cycle.
- `Completed` shall remain TRUE for one PLC scan after successful completion.
- `Fault` has priority over all operational states.
- `AlarmCode` shall be zero when no alarm is active.

---

# Used By

- FB_LineManager
- FB_FeedingControlManager
- FB_SchedulerManager
- AquaFeed Manager
- HMI