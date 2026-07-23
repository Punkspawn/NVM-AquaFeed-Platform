# Function

FN_CalculateDeviation

---

# Purpose

Calculates the deviation between a measured value and its target (setpoint).

This function provides a standardized method for evaluating process accuracy and is commonly used in control logic, alarm generation, diagnostics, and performance monitoring.

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
| Return | REAL | Deviation (ActualValue − Setpoint) |

---

# Formula

```text
Deviation = ActualValue - Setpoint
```

---

# Logic

```text
Return := ActualValue - Setpoint;
```

---

# Rules

- The function shall always return the signed deviation.
- A positive result indicates the measured value is above the target.
- A negative result indicates the measured value is below the target.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| ActualValue = Setpoint | 0 |
| ActualValue > Setpoint | Positive value |
| ActualValue < Setpoint | Negative value |

---

# Typical Usage

- Feed rate monitoring
- Blower speed comparison
- Motor speed verification
- Pressure monitoring
- Temperature control
- Diagnostic calculations

---

# Used By

- FB_Blower
- FB_Dosing
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
| 95 | 100 | -5 |
| 0 | 50 | -50 |
| 75 | 50 | 25 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the signed difference between two values.

It does not:

- Calculate percentage deviation
- Apply tolerance limits
- Generate alarms
- Correct process values
- Trigger control actions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePercentage.md
- FN_CheckRange.md
- FB_SystemManager.md
- TEST_Functions.md

---

# Revision

Version 1.0