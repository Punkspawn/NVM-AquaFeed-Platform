# Function

FN_GetSystemMode

---

# Purpose

Determines the current operating mode of the AquaFeed system based on the status of operator commands, automatic scheduling, maintenance conditions, and emergency signals.

This function provides a single, standardized source for determining the active system mode, ensuring consistent behavior across all Function Blocks and HMI displays.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AutoModeEnabled | BOOL | Automatic operation selected |
| ManualModeEnabled | BOOL | Manual operation selected |
| MaintenanceModeEnabled | BOOL | Maintenance mode selected |
| EmergencyStop | BOOL | Emergency stop active |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | UINT | Current system mode |

---

# System Modes

| Value | Mode |
|------:|------|
| 0 | Undefined |
| 1 | Manual |
| 2 | Automatic |
| 3 | Maintenance |
| 4 | Emergency Stop |

---

# Logic

```text
IF EmergencyStop THEN
    Return := 4;

ELSIF MaintenanceModeEnabled THEN
    Return := 3;

ELSIF AutoModeEnabled THEN
    Return := 2;

ELSIF ManualModeEnabled THEN
    Return := 1;

ELSE
    Return := 0;

END_IF;
```

---

# Rules

- Emergency Stop has the highest priority.
- Maintenance mode overrides Manual and Automatic modes.
- Automatic mode has priority over Manual mode if both are requested simultaneously.
- Undefined conditions shall return `0`.
- The function shall execute within a single PLC scan.
- No internal memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Emergency Stop | 4 |
| Maintenance Mode | 3 |
| Automatic Mode | 2 |
| Manual Mode | 1 |
| Undefined | 0 |

---

# Typical Usage

- System Manager
- HMI status display
- Job execution control
- Equipment enable logic
- Event logging
- Diagnostic reporting

---

# Used By

- FB_SystemManager
- FB_HMIManager
- FB_JobManager
- FB_LineManager
- FB_ReportManager

---

# Test Cases

| Auto | Manual | Maintenance | E-Stop | Expected |
|------|--------|-------------|--------|----------|
| FALSE | FALSE | FALSE | FALSE | Undefined |
| FALSE | TRUE | FALSE | FALSE | Manual |
| TRUE | FALSE | FALSE | FALSE | Automatic |
| TRUE | TRUE | FALSE | FALSE | Automatic |
| FALSE | TRUE | TRUE | FALSE | Maintenance |
| TRUE | TRUE | TRUE | TRUE | Emergency Stop |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates the current operating mode.

It does not:

- Change the operating mode
- Start or stop equipment
- Reset emergency conditions
- Execute operating sequences
- Store operating mode history

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_SystemManager.md
- FB_JobManager.md
- SYSTEM_ARCHITECTURE.md
- TEST_Functions.md

---

# Revision

Version 1.0