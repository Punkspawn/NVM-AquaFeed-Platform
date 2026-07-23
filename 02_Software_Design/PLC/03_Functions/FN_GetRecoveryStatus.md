# Function

FN_GetRecoveryStatus

---

# Function

FN_GetRecoveryStatus

---

# Purpose

Returns the standardized status code of a recovery operation.

This function converts recovery operation conditions into a common status code for monitoring and diagnostics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RecoveryActive | BOOL | Recovery sequence active status |
| RecoveryCompleted | BOOL | Recovery completed status |
| RecoveryFailed | BOOL | Recovery failure status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Recovery status code |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | IDLE |
| 1 | RUNNING |
| 2 | COMPLETED |
| 3 | FAILED |

---

# Logic

```text
IF RecoveryFailed = TRUE THEN

    Return := 3;

ELSIF RecoveryCompleted = TRUE THEN

    Return := 2;

ELSIF RecoveryActive = TRUE THEN

    Return := 1;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Failed recovery has the highest priority.
- Completed recovery shall be reported before idle state.
- Active recovery shall be reported while the sequence is running.
- The function shall only evaluate recovery status.
- The function shall not execute recovery actions.
- The function shall not reset faults.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Recovery failed | 3 |
| Recovery completed | 2 |
| Recovery active | 1 |
| No recovery operation | 0 |

---

# Typical Usage

- HMI recovery display
- Diagnostic monitoring
- Event logging
- Recovery sequence supervision

---

# Used By

- FB_RecoveryManager
- FB_HMIManager
- FB_DiagnosticsManager
- FB_DataLogger

---

# Test Cases

| Active | Completed | Failed | Expected |
|--------|-----------|--------|----------|
| FALSE | FALSE | FALSE | 0 |
| TRUE | FALSE | FALSE | 1 |
| FALSE | TRUE | FALSE | 2 |
| TRUE | FALSE | TRUE | 3 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only recovery status.

It does not:

- Start recovery
- Reset alarms
- Restart equipment
- Control motors
- Modify system operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckRecoveryPermission.md
- FN_CheckAutoRestartCondition.md
- FN_CheckRecoveryTimeout.md
- FB_RecoveryManager.md

---

# Revision

Version 1.0