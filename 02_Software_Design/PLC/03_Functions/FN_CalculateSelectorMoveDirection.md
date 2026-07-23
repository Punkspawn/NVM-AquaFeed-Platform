# Function

FN_CalculateSelectorMoveDirection

---

# Function

FN_CalculateSelectorMoveDirection

---

# Purpose

Determines the required selector movement direction by comparing the current selector position with the requested target position.

This function is used to determine the movement command required for selector positioning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentPosition | INT | Current detected selector position |
| TargetPosition | INT | Requested selector position |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Movement direction |

---

# Status Codes

| Value | Description |
|------:|-------------|
| -1 | Move negative direction |
| 0 | Position already reached |
| 1 | Move positive direction |

---

# Logic

```text
IF CurrentPosition = TargetPosition THEN

    Return := 0;

ELSIF TargetPosition > CurrentPosition THEN

    Return := 1;

ELSE

    Return := -1;

END_IF;
```

---

# Rules

- CurrentPosition shall represent the actual selector position.
- TargetPosition shall represent the requested selector position.
- The function shall only calculate movement direction.
- The function shall not energize motor outputs.
- The function shall not perform position control.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Target position reached | 0 |
| Positive direction required | 1 |
| Negative direction required | -1 |

---

# Typical Usage

- Selector positioning sequence
- Automatic silo selection
- Mechanical direction control
- Movement preparation

---

# Used By

- FB_Selector
- FB_LineManager
- FB_RecoveryManager

---

# Test Cases

| Current Position | Target Position | Expected |
|----------------:|----------------:|---------:|
| 1 | 1 | 0 |
| 1 | 2 | 1 |
| 2 | 1 | -1 |
| 3 | 5 | 1 |
| 5 | 3 | -1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only movement direction.

It does not:

- Control selector motor
- Read position sensors
- Execute movement timing
- Check mechanical limits
- Generate alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorPosition.md
- FN_CheckSelectorLimitState.md
- FN_IsValidTransition.md
- FB_Selector.md

---

# Revision

Version 1.0