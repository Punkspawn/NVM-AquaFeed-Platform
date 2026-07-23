# Function

FN_CheckRecoveryTimeout

---

# Function

FN_CheckRecoveryTimeout

---

# Purpose

Checks whether a recovery operation has exceeded the allowed recovery time.

This function is used to detect unsuccessful recovery attempts when the system does not return to normal operation within the configured timeout period.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RecoveryActive | BOOL | Recovery sequence active status |
| RecoveryCompleted | BOOL | Recovery completed status |
| RecoveryTime | REAL | Elapsed recovery time (seconds) |
| MaximumRecoveryTime | REAL | Allowed recovery duration (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Recovery timeout status |

---

# Logic

```text
IF RecoveryActive = FALSE THEN

    Return := FALSE;

ELSIF RecoveryCompleted = TRUE THEN

    Return := FALSE;

ELSIF MaximumRecoveryTime <= 0.0 THEN

    Return := FALSE;

ELSIF RecoveryTime >= MaximumRecoveryTime THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Timeout evaluation shall only be active during recovery operation.
- Completed recovery shall cancel timeout evaluation.
- MaximumRecoveryTime shall be greater than zero.
- The function shall only evaluate recovery timeout condition.
- The function shall not stop equipment.
- The function shall not reset faults.
- The function shall not restart equipment.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Recovery completed | FALSE |
| Recovery not active | FALSE |
| Recovery time exceeded | TRUE |
| Recovery within limit | FALSE |

---

# Typical Usage

- Recovery sequence monitoring
- Fault handling
- Automatic recovery supervision
- Diagnostic reporting

---

# Used By

- FB_RecoveryManager
- FB_AlarmManager
- FB_DiagnosticsManager

---

# Test Cases

| Active | Completed | Time | Limit | Expected |
|--------|-----------|-----:|------:|----------|
| FALSE | FALSE | 100s | 10s | FALSE |
| TRUE | TRUE | 100s | 10s | FALSE |
| TRUE | FALSE | 5s | 10s | FALSE |
| TRUE | FALSE | 15s | 10s | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only recovery timeout status.

It does not:

- Execute recovery steps
- Reset alarms
- Restart drives
- Control motors
- Modify system state

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckRecoveryPermission.md
- FN_CheckAutoRestartCondition.md
- FN_CheckAlarmResetPermission.md
- FB_RecoveryManager.md

---

# Revision

Version 1.0