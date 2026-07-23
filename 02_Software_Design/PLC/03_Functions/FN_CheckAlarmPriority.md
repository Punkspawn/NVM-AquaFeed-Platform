# Function

FN_CheckAlarmPriority

---

# Function

FN_CheckAlarmPriority

---

# Purpose

Determines the priority level of an active alarm.

This function is used to classify alarms according to their importance for operator notification and system response.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmCode | DINT | Alarm identifier |
| EmergencyActive | BOOL | Emergency condition status |
| FaultActive | BOOL | Fault condition status |
| WarningActive | BOOL | Warning condition status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Alarm priority level |

---

# Priority Codes

| Value | Description |
|------:|-------------|
| 0 | No alarm |
| 1 | Warning |
| 2 | Fault |
| 3 | Emergency |

---

# Logic

```text
IF AlarmCode <= 0 THEN

    Return := 0;

ELSIF EmergencyActive = TRUE THEN

    Return := 3;

ELSIF FaultActive = TRUE THEN

    Return := 2;

ELSIF WarningActive = TRUE THEN

    Return := 1;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Emergency alarms have the highest priority.
- Fault alarms have higher priority than warnings.
- Warning alarms represent non-critical conditions.
- The function shall only evaluate priority.
- The function shall not activate alarms.
- The function shall not stop equipment.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Emergency alarm | 3 |
| Fault alarm | 2 |
| Warning alarm | 1 |
| No active alarm | 0 |

---

# Typical Usage

- Alarm display
- Operator notification
- Alarm sorting
- Diagnostic reporting

---

# Used By

- FB_AlarmManager
- FB_HMIManager
- FB_DiagnosticsManager
- FB_DataLogger

---

# Test Cases

| Alarm Code | Emergency | Fault | Warning | Expected |
|-----------:|-----------|-------|---------|----------|
| 0 | FALSE | FALSE | FALSE | 0 |
| 101 | FALSE | FALSE | TRUE | 1 |
| 205 | FALSE | TRUE | FALSE | 2 |
| 301 | TRUE | TRUE | TRUE | 3 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only alarm priority.

It does not:

- Detect alarm conditions
- Store alarm history
- Reset alarms
- Control outputs
- Stop machines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CreateAlarmCode.md
- FN_IsAlarmActive.md
- FN_CheckFaultCondition.md
- FB_AlarmManager.md

---

# Revision

Version 1.0