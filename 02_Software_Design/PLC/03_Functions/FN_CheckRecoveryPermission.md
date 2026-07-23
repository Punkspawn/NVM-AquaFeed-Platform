# Function

FN_CheckRecoveryPermission

---

# Function

FN_CheckRecoveryPermission

---

# Purpose

Checks whether automatic recovery operation is permitted after a fault condition.

This function evaluates the basic conditions required before starting a recovery sequence.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FaultActive | BOOL | Current fault status |
| ResetPermission | BOOL | Alarm reset permission status |
| SystemReady | BOOL | General system ready status |
| RecoveryEnabled | BOOL | Automatic recovery enable status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Recovery permission status |

---

# Logic

```text
IF RecoveryEnabled = FALSE THEN

    Return := FALSE;

ELSIF FaultActive = TRUE THEN

    Return := FALSE;

ELSIF ResetPermission = FALSE THEN

    Return := FALSE;

ELSIF SystemReady = FALSE THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- Recovery shall only be allowed when automatic recovery is enabled.
- Active faults shall prevent recovery permission.
- Reset conditions shall be satisfied before recovery.
- System readiness shall be confirmed.
- The function shall only evaluate recovery permission.
- The function shall not reset faults.
- The function shall not restart equipment.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Recovery conditions satisfied | TRUE |
| Fault active | FALSE |
| Recovery disabled | FALSE |
| System not ready | FALSE |

---

# Typical Usage

- Automatic fault recovery
- Restart preparation
- Equipment recovery sequence
- System restart management

---

# Used By

- FB_RecoveryManager
- FB_AlarmManager
- FB_LineManager

---

# Test Cases

| Recovery | Fault | Reset | Ready | Expected |
|----------|-------|-------|-------|----------|
| FALSE | FALSE | TRUE | TRUE | FALSE |
| TRUE | TRUE | TRUE | TRUE | FALSE |
| TRUE | FALSE | FALSE | TRUE | FALSE |
| TRUE | FALSE | TRUE | TRUE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only recovery permission.

It does not:

- Reset alarms
- Restart motors
- Move selector
- Start blower
- Start dosing

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckAlarmResetPermission.md
- FN_CheckFaultCondition.md
- FN_IsEquipmentReady.md
- FB_RecoveryManager.md

---

# Revision

Version 1.0