# Function

FN_CheckAutoRestartCondition

---

# Function

FN_CheckAutoRestartCondition

---

# Purpose

Checks whether automatic restart is allowed after a fault recovery condition.

This function evaluates the conditions required before automatically continuing operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AutoRestartEnabled | BOOL | Automatic restart enable status |
| FaultCleared | BOOL | Fault condition cleared status |
| EquipmentReady | BOOL | Equipment ready status |
| RestartLimitReached | BOOL | Restart attempt limit status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Automatic restart permission |

---

# Logic

```text
IF AutoRestartEnabled = FALSE THEN

    Return := FALSE;

ELSIF FaultCleared = FALSE THEN

    Return := FALSE;

ELSIF EquipmentReady = FALSE THEN

    Return := FALSE;

ELSIF RestartLimitReached = TRUE THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- Automatic restart shall only operate when enabled.
- Fault condition shall be cleared before restart.
- Equipment readiness shall be confirmed.
- Restart attempt limits shall prevent continuous restart loops.
- The function shall only evaluate restart permission.
- The function shall not restart equipment.
- The function shall not clear alarms.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All restart conditions valid | TRUE |
| Auto restart disabled | FALSE |
| Fault not cleared | FALSE |
| Equipment not ready | FALSE |
| Restart limit reached | FALSE |

---

# Typical Usage

- Automatic recovery sequence
- Fault restart preparation
- Equipment restart management
- Recovery decision logic

---

# Used By

- FB_RecoveryManager
- FB_AlarmManager
- FB_LineManager

---

# Test Cases

| Auto | Fault Clear | Ready | Limit | Expected |
|------|-------------|-------|-------|----------|
| FALSE | TRUE | TRUE | FALSE | FALSE |
| TRUE | FALSE | TRUE | FALSE | FALSE |
| TRUE | TRUE | FALSE | FALSE | FALSE |
| TRUE | TRUE | TRUE | TRUE | FALSE |
| TRUE | TRUE | TRUE | FALSE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only automatic restart permission.

It does not:

- Restart motors
- Reset drives
- Move selector
- Start blower
- Start dosing

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckRecoveryPermission.md
- FN_CheckAlarmResetPermission.md
- FN_CheckFaultCondition.md
- FB_RecoveryManager.md

---

# Revision

Version 1.0