# Function

FN_CalculateMaterialLoss

---

# Function

FN_CalculateMaterialLoss

---

# Purpose

Calculates the total material loss by comparing the expected material quantity with the actual delivered quantity.

This function is used to detect feed losses caused by pipe leakage, dosing inaccuracies, spills, equipment malfunction, or measurement errors.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ExpectedQuantity | REAL | Expected material quantity (kg) |
| ActualQuantity | REAL | Actual delivered quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Material loss (kg) |

---

# Formula

```text
MaterialLoss =
ExpectedQuantity -
ActualQuantity
```

---

# Logic

```text
IF ExpectedQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ActualQuantity < 0.0 THEN
    Return := 0.0;

ELSIF ActualQuantity >= ExpectedQuantity THEN
    Return := 0.0;

ELSE
    Return :=
        ExpectedQuantity -
        ActualQuantity;

END_IF;
```

---

# Rules

- ExpectedQuantity shall be greater than zero.
- ActualQuantity shall be zero or greater.
- Material loss shall never be negative.
- If ActualQuantity exceeds ExpectedQuantity, the returned value shall be zero.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| ExpectedQuantity > ActualQuantity | Difference (kg) |
| ActualQuantity ≥ ExpectedQuantity | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Feed loss monitoring
- Production variance analysis
- Inventory reconciliation
- Material balance calculations
- Daily production reports
- Historical KPI calculations

---

# Used By

- FB_ReportManager
- FB_ProductionManager
- FB_HistoryManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Expected | Actual | Expected Result |
|----------:|-------:|----------------:|
| 1000 kg | 980 kg | 20 kg |
| 500 kg | 500 kg | 0 kg |
| 800 kg | 820 kg | 0 kg |
| 0 kg | 0 kg | 0 kg |
| 100 kg | -5 kg | 0 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the material loss quantity.

It does not:

- Determine the cause of the loss
- Detect equipment failures
- Calculate financial loss
- Generate inventory adjustments
- Store production history
- Trigger alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateWastePercentage.md
- FN_CalculateRejectRate.md
- FN_CalculateEfficiency.md
- FB_ProductionManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0