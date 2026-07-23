# Function

FN_CheckSelectorMovementTimeout

---

# Function

FN_CheckSelectorMovementTimeout

---

# Purpose

Checks whether the selector movement has exceeded the allowed positioning time.

This function is used to detect selector movement failures when the requested position is not reached within the configured timeout period.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| MoveCommandActive | BOOL | Selector movement command status |
| PositionReached | BOOL | Target position reached status |
| MovementTime | REAL | Elapsed movement time (seconds) |
| MaximumMovementTime | REAL | Allowed maximum movement time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Movement timeout status |

---

# Logic

```text
IF MoveCommandActive = FALSE THEN

    Return := FALSE;

ELSIF PositionReached = TRUE THEN

    Return := FALSE;

ELSIF MovementTime >= MaximumMovementTime THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Timeout control shall only be active during selector movement.
- Reaching the target position shall cancel timeout evaluation.
- MaximumMovementTime shall be greater than zero.
- The function shall only evaluate timeout condition.
- The function shall not stop the motor.
- The function shall not reset faults.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Movement completed | FALSE |
| Movement not active | FALSE |
| Movement exceeded allowed time | TRUE |

---

# Typical Usage

- Selector fault detection
- Automatic sequence protection
- Mechanical movement supervision
- Alarm generation support

---

# Used By

- FB_Selector
- FB_AlarmManager
- FB_RecoveryManager
- FB_LineManager

---

# Test Cases

| Move Active | Position OK | Time | Limit | Expected |
|-------------|-------------|------|-------|----------|
| FALSE | FALSE | 100s | 10s | FALSE |
| TRUE | TRUE | 20s | 10s | FALSE |
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

This function checks only selector movement timeout.

It does not:

- Drive selector motor
- Measure actual movement time
- Read physical sensors
- Execute recovery sequence
- Generate alarms directly

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorPosition.md
- FN_CheckSelectorLimitState.md
- FN_IsTimeout.md
- FB_Selector.md

---

# Revision

Version 1.0