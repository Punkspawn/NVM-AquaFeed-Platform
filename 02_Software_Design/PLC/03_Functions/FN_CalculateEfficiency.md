# Function

FN_CalculateEfficiency

---

# Purpose

Calculates the efficiency of a process by comparing the actual output with the expected output and expressing the result as a percentage.

This function provides a consistent method for evaluating equipment, feeding operations, and production performance throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualOutput | REAL | Measured output value |
| ExpectedOutput | REAL | Target or expected output value |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Efficiency (%) |

---

# Formula

```text
Efficiency = (ActualOutput / ExpectedOutput) × 100
```

---

# Logic

```text
IF ExpectedOutput <= 0 THEN
    Return := 0.0;
ELSE
    Return := (ActualOutput / ExpectedOutput) * 100.0;
END_IF;
```

---

# Rules

- ExpectedOutput shall be greater than zero.
- Division by zero shall be prevented.
- The returned efficiency may exceed 100%.
- The function shall not modify input values.
- No persistent variables shall be used.
- Execution shall complete within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| ExpectedOutput > 0 | Calculated efficiency (%) |
| ExpectedOutput ≤ 0 | 0.0 |

---

# Typical Usage

- Feeding efficiency calculation
- Recipe execution analysis
- Daily production statistics
- Equipment performance evaluation
- Production reporting
- Historical KPI calculations

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_JobManager
- FB_SystemManager
- FB_HistoryManager

---

# Test Cases

| Actual | Expected | Expected Result |
|--------:|---------:|----------------:|
| 100 | 100 | 100 |
| 95 | 100 | 95 |
| 120 | 100 | 120 |
| 0 | 100 | 0 |
| 100 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only the mathematical efficiency calculation.

It does not:

- Judge whether the efficiency is acceptable
- Apply performance limits
- Generate alarms
- Store KPI values
- Produce reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePercentage.md
- FN_CalculateAverage.md
- FB_ReportManager.md
- FB_RuntimeManager.md
- TEST_Functions.md

---

# Revision

Version 1.0