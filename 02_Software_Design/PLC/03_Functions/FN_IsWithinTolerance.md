# Function

FN_IsWithinTolerance

---

# Purpose

Determines whether a measured value is within an acceptable tolerance band around a specified setpoint.

This function standardizes tolerance checking across the AquaFeed Platform and can be used for process validation, alarm suppression, quality checks, and equipment verification.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualValue | REAL | Measured process value |
| Setpoint | REAL | Desired target value |
| Tolerance | REAL | Allowed deviation (±) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the measured value is within tolerance |

---

# Formula

```text
ABS(ActualValue - Setpoint) <= Tolerance
```

---

# Logic

```text
IF Tolerance < 0 THEN
    Return := FALSE;

ELSIF ABS(ActualValue - Setpoint) <= Tolerance THEN
    Return := TRUE;

ELSE
    Return := FALSE;
END_IF;
```

---

# Rules

- Tolerance shall be zero or greater.
- Boundary values are considered valid.
- Negative tolerance values are invalid.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Absolute deviation ≤ Tolerance | TRUE |
| Absolute deviation > Tolerance | FALSE |
| Tolerance < 0 | FALSE |

---

# Typical Usage

- Feed quantity verification
- Blower speed validation
- Motor speed monitoring
- Sensor accuracy checking
- Recipe verification
- Quality control

---

# Used By

- FB_Dosing
- FB_Blower
- FB_LineManager
- FB_RecipeManager
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Actual | Setpoint | Tolerance | Expected |
|--------:|---------:|----------:|----------|
| 100 | 100 | 5 | TRUE |
| 104 | 100 | 5 | TRUE |
| 95 | 100 | 5 | TRUE |
| 106 | 100 | 5 | FALSE |
| 100 | 100 | -1 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates whether a value lies within a specified tolerance band.

It does not:

- Calculate the deviation magnitude (see `FN_CalculateAbsoluteDeviation`)
- Apply automatic corrections
- Generate alarms
- Log events
- Modify process values

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDeviation.md
- FN_CalculateAbsoluteDeviation.md
- FN_CheckRange.md
- TEST_Functions.md

---

# Revision

Version 1.0