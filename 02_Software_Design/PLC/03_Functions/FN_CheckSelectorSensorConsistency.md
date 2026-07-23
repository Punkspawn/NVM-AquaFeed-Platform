# Function

FN_CheckSelectorSensorConsistency

---

# Function

FN_CheckSelectorSensorConsistency

---

# Purpose

Checks whether selector position sensor feedback signals are consistent.

This function detects invalid sensor combinations where the selector position cannot be determined reliably.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActiveSensorCount | DINT | Number of active selector position sensors |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Sensor consistency status |

---

# Logic

```text
IF ActiveSensorCount = 1 THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Only one position feedback shall be active at a time.
- Zero active sensors indicate unknown selector position.
- More than one active sensor indicates invalid feedback.
- The function shall only evaluate sensor consistency.
- The function shall not control selector movement.
- The function shall not generate alarms directly.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid single position feedback | TRUE |
| No position feedback | FALSE |
| Multiple position feedbacks | FALSE |

---

# Typical Usage

- Selector position validation
- Movement sequence permission
- Fault detection support
- Automatic feeding preparation

---

# Used By

- FB_Selector
- FB_LineManager
- FB_DiagnosticsManager
- FB_AlarmManager

---

# Test Cases

| Active Sensor Count | Expected |
|--------------------:|----------|
| 0 | FALSE |
| 1 | TRUE |
| 2 | FALSE |
| 3 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only sensor feedback consistency.

It does not:

- Read physical inputs
- Filter sensor signals
- Control selector motor
- Determine mechanical position
- Execute recovery actions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorLimitState.md
- FN_CheckSelectorPosition.md
- FN_CheckSensorState.md
- FB_Selector.md

---

# Revision

Version 1.0