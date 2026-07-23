# Function

FN_CheckFaultCondition

---

# Function

FN_CheckFaultCondition

---

# Purpose

Evaluates fault conditions and determines whether a system fault is present.

This function provides a common fault evaluation method for equipment and subsystem diagnostics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| DriveFault | BOOL | Drive fault status |
| CommunicationFault | BOOL | Communication fault status |
| SensorFault | BOOL | Sensor fault status |
| TimeoutFault | BOOL | Timeout fault status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Fault active status |

---

# Logic

```text
IF DriveFault = TRUE THEN

    Return := TRUE;

ELSIF CommunicationFault = TRUE THEN

    Return := TRUE;

ELSIF SensorFault = TRUE THEN

    Return := TRUE;

ELSIF TimeoutFault = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Any active fault condition shall result in fault status.
- Fault sources shall be evaluated independently.
- The function shall only combine fault conditions.
- The function shall not reset faults.
- The function shall not stop equipment.
- The function shall not store fault history.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Any fault active | TRUE |
| No fault active | FALSE |

---

# Typical Usage

- Alarm management
- Equipment diagnostics
- Line fault evaluation
- System status monitoring

---

# Used By

- FB_AlarmManager
- FB_DiagnosticsManager
- FB_LineManager
- FB_HealthMonitor

---

# Test Cases

| Drive | Comm | Sensor | Timeout | Expected |
|------|------|--------|---------|----------|
| FALSE | FALSE | FALSE | FALSE | FALSE |
| TRUE | FALSE | FALSE | FALSE | TRUE |
| FALSE | TRUE | FALSE | FALSE | TRUE |
| FALSE | FALSE | TRUE | FALSE | TRUE |
| FALSE | FALSE | FALSE | TRUE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only combined fault status.

It does not:

- Generate alarm codes
- Assign priority
- Store events
- Reset faults
- Control machine outputs

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsAlarmActive.md
- FN_CheckAlarmPriority.md
- FN_IsCommunicationHealthy.md
- FB_AlarmManager.md

---

# Revision

Version 1.0