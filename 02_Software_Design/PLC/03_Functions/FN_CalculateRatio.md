# Function

FN_CalculateRatio

---

# Purpose

Calculates the ratio between two numeric values.

This function provides a standardized method for determining proportional relationships used in process calculations, equipment monitoring, and engineering analysis.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Numerator | REAL | Dividend value |
| Denominator | REAL | Divisor value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Calculated ratio |

---

# Formula

```text
Ratio = Numerator / Denominator
```

---

# Logic

```text
IF Denominator = 0 THEN
    Return := 0.0;
ELSE
    Return := Numerator / Denominator;
END_IF;
```

---

# Rules

- Denominator shall not be zero.
- The returned ratio may be less than, equal to, or greater than 1.
- Negative values are permitted when appropriate for the application.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Denominator ≠ 0 | Numerator / Denominator |
| Denominator = 0 | 0.0 |

---

# Typical Usage

- Feed conversion calculations
- Process performance analysis
- Sensor comparison
- Production statistics
- Equipment utilization
- Engineering calculations

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_SystemManager
- FB_HistoryManager
- FB_RecipeManager

---

# Test Cases

| Numerator | Denominator | Expected |
|----------:|------------:|---------:|
| 10 | 2 | 5 |
| 5 | 10 | 0.5 |
| 0 | 10 | 0 |
| 10 | 1 | 10 |
| 10 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only a mathematical ratio calculation.

It does not:

- Convert the ratio to a percentage (see `FN_CalculatePercentage`)
- Validate engineering limits
- Interpret the calculated ratio
- Generate alarms or events
- Store calculated values

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePercentage.md
- FN_CalculateEfficiency.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0