# Function

FN_CalculateFeedAccuracy

---

# Function

FN_CalculateFeedAccuracy

---

# Purpose

Calculates the feed accuracy as a percentage by comparing the actual delivered feed quantity with the planned feed quantity.

Feed Accuracy is an important KPI used to evaluate dosing precision, recipe execution, and overall feeding system performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PlannedQuantity | REAL | Planned feed quantity (kg) |
| ActualQuantity | REAL | Actual delivered feed quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Feed accuracy (%) |

---

# Formula

```text
FeedAccuracy =
100 -
(
ABS(PlannedQuantity - ActualQuantity)
/
PlannedQuantity
× 100
)
```

---

# Logic

```text
VAR
    Difference : REAL;
END_VAR

IF PlannedQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ActualQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Difference := ABS(PlannedQuantity - ActualQuantity);

    Return :=
        100.0 -
        ((Difference * 100.0) / PlannedQuantity);

    IF Return < 0.0 THEN
        Return := 0.0;
    END_IF;

END_IF;
```

---

# Rules

- PlannedQuantity shall be greater than zero.
- ActualQuantity shall be zero or greater.
- Division by zero shall be prevented.
- Feed Accuracy shall be limited to the range 0–100%.
- 100% indicates perfect dosing accuracy.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Perfect match | 100% |
| Valid inputs | Calculated accuracy |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Recipe verification
- Dosing performance analysis
- Feeding KPI dashboard
- Production quality reporting
- Historical statistics
- Operator performance evaluation

---

# Used By

- FB_Dosing
- FB_FeedingControlManager
- FB_ReportManager
- FB_HistoryManager
- FB_StatisticsManager

---

# Test Cases

| Planned | Actual | Expected |
|---------:|-------:|---------:|
| 1000 kg | 1000 kg | 100% |
| 1000 kg | 980 kg | 98% |
| 1000 kg | 1020 kg | 98% |
| 1000 kg | 900 kg | 90% |
| 1000 kg | 0 kg | 0% |
| 0 kg | 100 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only feed delivery accuracy.

It does not:

- Correct dosing errors
- Modify recipe parameters
- Control dosing motors
- Detect equipment failures
- Store production statistics
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedVariance.md
- FN_CalculateDeviation.md
- FN_CalculateQuality.md
- FB_Dosing.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0