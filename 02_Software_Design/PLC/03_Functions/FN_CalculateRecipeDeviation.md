# Function

FN_CalculateRecipeDeviation

---

# Function

FN_CalculateRecipeDeviation

---

# Purpose

Calculates the deviation between the planned recipe quantity and the actual dispensed quantity.

This function is used to verify recipe execution accuracy and determine whether the dispensing process stayed within the allowable production tolerance.

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
| Return | REAL | Recipe deviation (%) |

---

# Formula

```text
RecipeDeviation =
((DispensedQuantity - RecipeQuantity)
/
RecipeQuantity)
× 100
```

Positive values indicate overfeeding.

Negative values indicate underfeeding.

---

# Logic

```text
IF RecipeQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF DispensedQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        ((DispensedQuantity - RecipeQuantity) * 100.0) /
        RecipeQuantity;

END_IF;
```

---

# Rules

- RecipeQuantity shall be greater than zero.
- DispensedQuantity shall be zero or greater.
- Division by zero shall be prevented.
- Positive values indicate more material than planned.
- Negative values indicate less material than planned.
- Zero indicates perfect recipe execution.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Exact dispensing | 0.0% |
| Overfeeding | Positive percentage |
| Underfeeding | Negative percentage |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Recipe validation
- Dosing performance analysis
- Production quality monitoring
- Automatic recipe verification
- Historical production reports
- KPI calculations

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
| 100 kg | 100 kg | 0% |
| 100 kg | 105 kg | +5% |
| 100 kg | 95 kg | -5% |
| 100 kg | 110 kg | +10% |
| 100 kg | 90 kg | -10% |
| 0 kg | 100 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the recipe deviation percentage.

It does not:

- Determine the cause of the deviation
- Modify recipe parameters
- Automatically compensate dosing values
- Detect equipment failures
- Store production history
- Generate operator alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedVariance.md
- FN_CalculateFeedAccuracy.md
- FN_IsRecipeValid.md
- FB_RecipeManager.md
- FB_Dosing.md
- TEST_Functions.md

---

# Revision

Version 1.0