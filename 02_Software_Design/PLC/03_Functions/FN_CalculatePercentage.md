# Function

FN_CalculatePercentage

---

# Purpose

Calculates the percentage that a value represents relative to a specified total.

This function provides a standardized method for calculating utilization, progress, filling level, production efficiency, and other percentage-based values used throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Value | REAL | Current value |
| Total | REAL | Maximum or reference value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Percentage (%) |

---

# Formula

```text
Percentage = (Value / Total) × 100
```

---

# Logic

```text
IF Total <= 0 THEN
    Return := 0.0;
ELSE
    Return := (Value / Total) * 100.0;
END_IF;
```

---

# Rules

- Total shall be greater than zero.
- Division by zero shall be prevented.
- Negative totals are considered invalid.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No internal state shall be maintained.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Total > 0 | Calculated percentage |
| Total ≤ 0 | 0.0 |

---

# Typical Usage

- Feed silo level (%)
- Recipe completion (%)
- Feeding job progress (%)
- Motor load percentage
- Production completion
- Daily production statistics

---

# Used By

- FB_HMIManager
- FB_ReportManager
- FB_RecipeManager
- FB_JobManager
- FB_SystemManager

---

# Test Cases

| Value | Total | Expected |
|------:|------:|---------:|
| 50 | 100 | 50 |
| 25 | 200 | 12.5 |
| 100 | 100 | 100 |
| 0 | 100 | 0 |
| 50 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only a mathematical percentage calculation.

It does not:

- Limit the result to 0–100%
- Validate engineering constraints
- Generate warnings or alarms
- Interpret the calculated percentage

If the result must remain within a defined range, `FN_LimitValue` should be applied by the calling Function Block.

---

# Related Documents

- FN_MapValue.md
- FN_LimitValue.md
- FN_CalculateAverage.md
- TEST_Functions.md

---

# Revision

Version 1.0