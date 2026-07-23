# Function

FN_CheckSelectorPosition

---

# Function

FN_CheckSelectorPosition

---

# Purpose

Checks whether the selector mechanical position matches the requested target position.

This function is used to verify selector positioning before enabling feeding operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetPosition | INT | Requested selector position |
| ActualPosition | INT | Detected selector position from sensors |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Position match status |

---

# Logic

```text
IF TargetPosition = ActualPosition THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- TargetPosition represents the requested mechanical position.
- ActualPosition represents the position detected by selector sensors.
- The function shall only compare position values.
- The function shall not control selector movement.
- The function shall not drive motors.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Selector at requested position | TRUE |
| Selector not at requested position | FALSE |

---

# Typical Usage

- Selector positioning verification
- Feeding line preparation
- Automatic sequence permission
- Position safety check

---

# Used By

- FB_Selector
- FB_LineManager
- FB_Dosing
- FB_RecoveryManager

---

# Test Cases

| Target Position | Actual Position | Expected |
|----------------|----------------|----------|
| 1 | 1 | TRUE |
| 2 | 2 | TRUE |
| 1 | 2 | FALSE |
| 3 | 1 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only checks selector position equality.

It does not:

- Move selector motor
- Read physical sensors
- Control outputs
- Detect mechanical faults
- Manage positioning sequence

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsValidTransition.md
- FN_IsEquipmentReady.md
- FN_CheckSensorState.md
- FB_Selector.md

---

# Revision

Version 1.0