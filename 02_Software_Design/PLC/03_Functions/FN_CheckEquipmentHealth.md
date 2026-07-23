# Function

FN_CheckEquipmentHealth

---

# Function

FN_CheckEquipmentHealth

---

# Purpose

Evaluates the general health condition of an equipment unit based on available status information.

This function provides a common health evaluation method for equipment diagnostics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CommunicationOK | BOOL | Communication status |
| FaultActive | BOOL | Equipment fault status |
| ReadyStatus | BOOL | Equipment ready status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Equipment health status |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | NOT_AVAILABLE |
| 1 | FAULT |
| 2 | READY |
| 3 | HEALTHY |

---

# Logic

```text
IF CommunicationOK = FALSE THEN

    Return := 0;

ELSIF FaultActive = TRUE THEN

    Return := 1;

ELSIF ReadyStatus = TRUE THEN

    Return := 3;

ELSE

    Return := 2;

END_IF;
```

---

# Rules

- Communication failure has priority over equipment status.
- Active fault shall be reported before normal states.
- Ready equipment shall be considered healthy.
- The function shall only evaluate health status.
- The function shall not control equipment.
- The function shall not reset faults.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Communication unavailable | 0 |
| Fault active | 1 |
| Available but not ready | 2 |
| Ready and healthy | 3 |

---

# Typical Usage

- Equipment diagnostics
- HMI status display
- Maintenance monitoring
- System health overview

---

# Used By

- FB_DiagnosticsManager
- FB_HealthMonitor
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Comm | Fault | Ready | Expected |
|------|-------|-------|----------|
| FALSE | FALSE | FALSE | 0 |
| TRUE | TRUE | FALSE | 1 |
| TRUE | FALSE | FALSE | 2 |
| TRUE | FALSE | TRUE | 3 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only equipment health state.

It does not:

- Read physical inputs
- Communicate with drives
- Generate alarms
- Control equipment
- Store history

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsCommunicationHealthy.md
- FN_CheckFaultCondition.md
- FB_DiagnosticsManager.md

---

# Revision

Version 1.0