# Function

FN_IsAlarmActive

---

# Function

FN_IsAlarmActive

---

# Purpose

Determines whether an alarm condition is currently active.

This function provides a standard evaluation method for alarm condition checks used by the alarm management system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmCondition | BOOL | Current alarm condition state |
| AlarmEnabled | BOOL | Alarm enable status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Alarm active status |

---

# Logic

```text
IF AlarmEnabled = FALSE THEN

    Return := FALSE;

ELSIF AlarmCondition = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Disabled alarms shall not become active.
- Active alarm condition shall require alarm enable permission.
- The function shall only evaluate alarm state.
- The function shall not store alarm history.
- The function shall not generate alarm messages.
- The function shall not control equipment.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Enabled and condition active | TRUE |
| Alarm disabled | FALSE |
| Condition inactive | FALSE |

---

# Typical Usage

- Alarm manager
- Diagnostic systems
- HMI alarm display
- Equipment monitoring

---

# Used By

- FB_AlarmManager
- FB_DiagnosticsManager
- FB_HMIManager
- FB_DataLogger

---

# Test Cases

| Alarm Enabled | Condition | Expected |
|--------------|-----------|----------|
| FALSE | FALSE | FALSE |
| FALSE | TRUE | FALSE |
| TRUE | FALSE | FALSE |
| TRUE | TRUE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only alarm activation state.

It does not:

- Create alarm codes
- Assign alarm priority
- Store alarm history
- Reset alarms
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CreateAlarmCode.md
- FN_CheckAlarmPriority.md
- FN_CheckFaultCondition.md
- FB_AlarmManager.md

---

# Revision

Version 1.0