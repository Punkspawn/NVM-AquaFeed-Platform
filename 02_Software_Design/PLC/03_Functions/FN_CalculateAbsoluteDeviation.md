# Function

FN_CalculateAbsoluteDeviation

---

# Purpose

Calculates the absolute deviation between a measured value and its target (setpoint).

Unlike `FN_CalculateDeviation`, this function always returns a non-negative value representing the magnitude of the error, regardless of its direction.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualValue | REAL | Measured process value |
| Setpoint | REAL | Desired target value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Absolute deviation |

---

# Formula

```text
AbsoluteDeviation = ABS(ActualValue - Setpoint)
```

---

# Logic

```text
Return := ABS(ActualValue - Setpoint);
```

---

# Rules

- The returned value shall always be greater than or equal to zero.
- The function shall not modify input values.
- No internal memory shall be used.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| ActualValue = Setpoint | 0 |
| ActualValue ≠ Setpoint | Positive deviation |

---

# Typical Usage

- Process accuracy evaluation
- Tolerance checking
- Alarm deadband calculations
- Recipe verification
- Quality monitoring
- Performance statistics

---

# Used By

- FB_Dosing
- FB_Blower
- FB_LineManager
- FB_SystemManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Actual | Setpoint | Expected |
|--------:|---------:|---------:|
| 100 | 100 | 0 |
| 105 | 100 | 5 |
| 95 | 100 | 5 |
| 0 | 50 | 50 |
| 75 | 50 | 25 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the magnitude of the deviation.

It does not:

- Indicate whether the value is above or below the setpoint
- Apply tolerance limits
- Generate alarms
- Trigger corrective actions
- Modify process values

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDeviation.md
- FN_CheckRange.md
- FB_SystemManager.md
- TEST_Functions.md

---

# Revision

Version 1.0