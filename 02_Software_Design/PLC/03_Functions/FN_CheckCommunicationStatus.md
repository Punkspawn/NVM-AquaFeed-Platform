# Function

FN_CheckCommunicationStatus

---

# Function

FN_CheckCommunicationStatus

---

# Purpose

Evaluates the current communication status of a device or subsystem.

This function provides a standard communication health evaluation for PLC diagnostics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CommunicationEnabled | BOOL | Communication usage enable status |
| CommunicationOK | BOOL | Current communication status |
| TimeoutActive | BOOL | Communication timeout status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Communication status code |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | DISABLED |
| 1 | ERROR |
| 2 | TIMEOUT |
| 3 | HEALTHY |

---

# Logic

```text
IF CommunicationEnabled = FALSE THEN

    Return := 0;

ELSIF TimeoutActive = TRUE THEN

    Return := 2;

ELSIF CommunicationOK = FALSE THEN

    Return := 1;

ELSE

    Return := 3;

END_IF;
```

---

# Rules

- Disabled communication shall not be reported as an error.
- Timeout condition has priority over general communication error.
- Healthy status requires active communication without timeout.
- The function shall only evaluate communication state.
- The function shall not restart communication.
- The function shall not modify communication parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Communication disabled | 0 |
| Communication error | 1 |
| Timeout active | 2 |
| Communication healthy | 3 |

---

# Typical Usage

- Modbus diagnostics
- Drive communication monitoring
- Equipment health monitoring
- HMI status display

---

# Used By

- FB_DiagnosticsManager
- FB_HealthMonitor
- FB_AlarmManager
- FB_DataLogger

---

# Test Cases

| Enabled | OK | Timeout | Expected |
|---------|----|---------|----------|
| FALSE | FALSE | FALSE | 0 |
| TRUE | FALSE | FALSE | 1 |
| TRUE | TRUE | TRUE | 2 |
| TRUE | TRUE | FALSE | 3 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only communication status.

It does not:

- Configure communication
- Read communication hardware
- Restart devices
- Reset faults
- Manage network settings

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsCommunicationHealthy.md
- FN_CheckFaultCondition.md
- FB_DiagnosticsManager.md

---

# Revision

Version 1.0