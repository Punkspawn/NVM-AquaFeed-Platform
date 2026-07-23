# Function

FN_CalculateLineEfficiency

---

# Function

FN_CalculateLineEfficiency

---

# Purpose

Calculates the production efficiency of a feeding line by comparing the actual production rate with the theoretical maximum production rate.

This function is used for production analysis, performance monitoring, OEE calculations, and HMI dashboards.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualRate | REAL | Actual production rate (kg/min) |
| MaximumRate | REAL | Maximum theoretical production rate (kg/min) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Line efficiency (%) |

---

# Formula

```text
LineEfficiency =
(ActualRate /
MaximumRate)
× 100
```

---

# Logic

```text
IF MaximumRate <= 0.0 THEN

    Return := 0.0;

ELSIF ActualRate < 0.0 THEN

    Return := 0.0;

ELSIF ActualRate >= MaximumRate THEN

    Return := 100.0;

ELSE

    Return :=
        (ActualRate * 100.0) /
        MaximumRate;

END_IF;
```

---

# Rules

- MaximumRate shall be greater than zero.
- ActualRate shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- Values exceeding the theoretical maximum shall be limited to 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Calculated efficiency (%) |
| ActualRate ≥ MaximumRate | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production line monitoring
- HMI efficiency display
- OEE calculations
- Performance analysis
- Production reporting
- Historical statistics

---

# Used By

- FB_LineManager
- FB_ProductionManager
- FB_StatisticsManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Actual Rate | Maximum Rate | Expected |
|------------:|-------------:|---------:|
| 80 kg/min | 100 kg/min | 80% |
| 100 kg/min | 100 kg/min | 100% |
| 120 kg/min | 100 kg/min | 100% |
| 0 kg/min | 100 kg/min | 0% |
| 50 kg/min | 0 kg/min | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the production efficiency of a line.

It does not:

- Calculate OEE
- Detect equipment failures
- Analyze production losses
- Control production equipment
- Store historical data
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateEfficiency.md
- FN_CalculatePerformance.md
- FN_CalculateProductionRate.md
- FB_LineManager.md
- FB_ProductionManager.md
- TEST_Functions.md

---

# Revision

Version 1.0