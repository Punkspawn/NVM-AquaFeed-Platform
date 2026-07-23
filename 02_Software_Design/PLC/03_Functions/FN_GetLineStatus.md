# Function

FN_GetLineStatus

---

# Purpose

Determines the overall operating status of a feeding line based on the states of its associated equipment.

This function provides a standardized line status evaluation for HMI visualization, diagnostics, reporting, and supervisory control.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SelectorReady | BOOL | Selector is in the requested position |
| BlowerRunning | BOOL | Blower is operating |
| DosingRunning | BOOL | Dosing unit is operating |
| FaultActive | BOOL | Any active fault on the line |
| EmergencyStop | BOOL | Emergency stop is active |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | UINT | Line status code |

---

# Status Codes

| Value | Status |
|------:|--------|
| 0 | Offline |
| 1 | Ready |
| 2 | Running |
| 3 | Warning |
| 4 | Fault |
| 5 | Emergency Stop |

---

# Logic

```text
IF EmergencyStop THEN
    Return := 5;

ELSIF FaultActive THEN
    Return := 4;

ELSIF BlowerRunning AND DosingRunning THEN
    Return := 2;

ELSIF SelectorReady THEN
    Return := 1;

ELSE
    Return := 0;

END_IF;
```

---

# Rules

- Emergency Stop has the highest priority.
- Fault conditions override Ready and Running states.
- Running status requires both the blower and dosing unit to be operating.
- Ready status requires the selector to be positioned correctly.
- The function shall execute within a single PLC scan.
- No internal memory shall be used.

---

# Return Value

| Condition | Status |
|-----------|--------|
| Emergency Stop active | Emergency Stop |
| Fault active | Fault |
| Blower + Dosing running | Running |
| Selector ready | Ready |
| Otherwise | Offline |

---

# Typical Usage

- HMI line overview
- Supervisor dashboards
- Alarm summaries
- Production reports
- Remote monitoring
- System diagnostics

---

# Used By

- FB_LineManager
- FB_SystemManager
- FB_HMIManager
- FB_ReportManager
- FB_JobManager

---

# Test Cases

| Selector | Blower | Dosing | Fault | E-Stop | Expected |
|-----------|---------|---------|--------|---------|----------|
| FALSE | FALSE | FALSE | FALSE | FALSE | Offline |
| TRUE | FALSE | FALSE | FALSE | FALSE | Ready |
| TRUE | TRUE | TRUE | FALSE | FALSE | Running |
| TRUE | TRUE | TRUE | TRUE | FALSE | Fault |
| TRUE | TRUE | TRUE | TRUE | TRUE | Emergency Stop |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates and returns the current line status.

It does not:

- Start or stop equipment
- Reset faults
- Acknowledge alarms
- Change system states
- Control feeding operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_LineManager.md
- FB_SystemManager.md
- FB_HMIManager.md
- TEST_Functions.md

---

# Revision

Version 1.0