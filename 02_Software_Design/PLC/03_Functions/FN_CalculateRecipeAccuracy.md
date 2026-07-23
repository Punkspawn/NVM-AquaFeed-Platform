# Function

FN_CalculateRecipeAccuracy

---

# Function

FN_CalculateRecipeAccuracy

---

# Purpose

Calculates the execution accuracy of a recipe by comparing the actual dispensed quantity with the target recipe quantity.

Recipe Accuracy is a key performance indicator used to verify dispensing precision, recipe compliance, and overall feeding quality.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RecipeQuantity | REAL | Target recipe quantity (kg) |
| DispensedQuantity | REAL | Actual dispensed quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Recipe accuracy (%) |

---

# Formula

```text
RecipeAccuracy =
100 -
(
ABS(RecipeQuantity - DispensedQuantity)
/
RecipeQuantity
× 100
)
```

---

# Logic

```text
VAR
    Difference : REAL;
END_VAR

IF RecipeQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF DispensedQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Difference :=
        ABS(RecipeQuantity - DispensedQuantity);

    Return :=
        100.0 -
        ((Difference * 100.0) / RecipeQuantity);

    IF Return < 0.0 THEN
        Return := 0.0;
    END_IF;

END_IF;
```

---

# Rules

- RecipeQuantity shall be greater than zero.
- DispensedQuantity shall be zero or greater.
- Division by zero shall be prevented.
- Recipe Accuracy shall be limited to the range 0–100%.
- A value of 100% indicates perfect recipe execution.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Exact dispensing | 100.0% |
| Valid inputs | Calculated accuracy |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Recipe verification
- Batch validation
- Feeding quality analysis
- Production KPI calculations
- Historical reporting
- HMI quality dashboard

---

# Used By

- FB_RecipeManager
- FB_Dosing
- FB_FeedingControlManager
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Recipe | Dispensed | Expected |
|--------:|----------:|---------:|
| 100 kg | 100 kg | 100% |
| 100 kg | 98 kg | 98% |
| 100 kg | 102 kg | 98% |
| 100 kg | 90 kg | 90% |
| 100 kg | 0 kg | 0% |
| 0 kg | 50 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only recipe execution accuracy.

It does not:

- Modify recipe parameters
- Compensate dosing errors
- Detect equipment failures
- Validate recipe limits
- Store production history
- Generate quality reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRecipeDeviation.md
- FN_CalculateFeedAccuracy.md
- FN_IsRecipeValid.md
- FB_RecipeManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0