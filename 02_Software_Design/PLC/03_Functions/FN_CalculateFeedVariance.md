# Function

FN_CalculateFeedVariance

---

# Function

FN_CalculateFeedVariance

---

# Purpose

Calculates the difference between the planned feed quantity and the actual delivered feed quantity.

Feed variance is used to evaluate dosing accuracy, recipe execution, and overall feeding performance. A positive value indicates underfeeding, while a negative value indicates overfeeding.

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
| Return | REAL | Feed variance (kg) |

---

# Formula

```text
FeedVariance =
PlannedQuantity -
ActualQuantity
```

---

# Logic

```text
IF PlannedQuantity < 0.0 THEN
    Return := 0.0;

ELSIF ActualQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        PlannedQuantity -
        ActualQuantity;

END_IF;
```

---

# Rules

- PlannedQuantity shall be zero or greater.
- ActualQuantity shall be zero or greater.
- A positive result indicates underfeeding.
- A negative result indicates overfeeding.
- A zero result indicates the target quantity was delivered exactly.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Planned > Actual | Positive variance |
| Planned = Actual | 0.0 |
| Planned < Actual | Negative variance |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Recipe verification
- Dosing accuracy analysis
- Feed performance reporting
- Historical production analysis
- Operator performance evaluation
- KPI dashboard calculations

---

# Used By

- FB_Dosing
- FB_FeedingControlManager
- FB_ReportManager
- FB_HistoryManager
- FB_StatisticsManager

---

# Test Cases

| Planned | Actual | Expected Result |
|---------:|-------:|----------------:|
| 1000 kg | 980 kg | +20 kg |
| 1000 kg | 1000 kg | 0 kg |
| 1000 kg | 1025 kg | -25 kg |
| 0 kg | 0 kg | 0 kg |
| -100 kg | 50 kg | 0 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the quantity variance.

It does not:

- Calculate percentage deviation
- Determine the cause of the variance
- Modify recipe parameters
- Adjust dosing equipment
- Store production statistics
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDeviation.md
- FN_CalculateMaterialLoss.md
- FN_CalculateFeedAmount.md
- FB_Dosing.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0