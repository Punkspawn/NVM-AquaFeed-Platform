# Function

FN_CheckAlarmResetPermission

---

# Function

FN_CheckAlarmResetPermission

---

# Purpose

Checks whether an alarm reset operation is allowed.

This function verifies that the related fault condition has been cleared before allowing alarm reset processing.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ResetCommand | BOOL | Operator reset command |
| AlarmActive | BOOL | Current alarm status |
| FaultConditionActive | BOOL | Current fault condition status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Reset permission status |

---

# Logic

```text
IF ResetCommand = FALSE THEN

    Return := FALSE;

ELSIF FaultConditionActive = TRUE THEN

    Return := FALSE;

ELSIF AlarmActive = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Reset shall only be evaluated when reset command is active.
- Active fault conditions shall prevent reset permission.
- Alarm reset shall not be allowed while the fault source remains active.
- The function shall only evaluate reset permission.
- The function shall not clear alarm memory.
- The function shall not control equipment.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Reset command and fault cleared | TRUE |
| Fault still active | FALSE |
| No reset command | FALSE |

---

# Typical Usage

- Alarm reset sequence
- Operator reset handling
- Fault recovery logic
- Diagnostic management

---

# Used By

- FB_AlarmManager
- FB_RecoveryManager
- FB_HMIManager

---

# Test Cases

| Reset | Alarm Active | Fault Active | Expected |
|-------|--------------|--------------|----------|
| FALSE | TRUE | FALSE | FALSE |
| TRUE | TRUE | FALSE | TRUE |
| TRUE | TRUE | TRUE | FALSE |
| TRUE | FALSE | FALSE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only reset permission.

It does not:

- Reset alarm memory
- Clear fault registers
- Restart equipment
- Control outputs
- Perform recovery sequence

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsAlarmActive.md
- FN_CheckFaultCondition.md
- FN_CheckAlarmPriority.md
- FB_AlarmManager.md

---

# Revision

Version 1.0