# Function

FN_CalculateYieldLoss

---

# Function

FN_CalculateYieldLoss

---

# Purpose

Calculates the production yield loss percentage by comparing the produced quantity with the accepted (good) quantity.

This KPI is used to evaluate production efficiency and identify losses caused by rejects, process deviations, or equipment issues.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProducedQuantity | DINT | Total produced quantity |
| GoodQuantity | DINT | Quantity accepted as good product |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Yield loss (%) |

---

# Formula

```text
YieldLoss =
((ProducedQuantity - GoodQuantity)
/
ProducedQuantity)
× 100
```

---

# Logic

```text
IF ProducedQuantity <= 0 THEN

    Return := 0.0;

ELSIF GoodQuantity < 0 THEN

    Return := 0.0;

ELSIF GoodQuantity >= ProducedQuantity THEN

    Return := 0.0;

ELSE

    Return :=
        (REAL(ProducedQuantity - GoodQuantity) * 100.0)
        /
        REAL(ProducedQuantity);

END_IF;
```

---

# Rules

- ProducedQuantity shall be greater than zero.
- GoodQuantity shall be zero or greater.
- GoodQuantity shall not exceed ProducedQuantity.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Yield loss (%) |
| No production loss | 0.0 |
| All products rejected | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production quality monitoring
- Manufacturing KPI dashboards
- Batch performance analysis
- OEE reporting
- Continuous improvement
- Waste analysis

---

# Used By

- FB_QualityManager
- FB_ProductionManager
- FB_ReportManager
- FB_SystemManager

---

# Test Cases

| Produced | Good | Expected |
|---------:|-----:|---------:|
| 100 | 100 | 0% |
| 100 | 98 | 2% |
| 100 | 90 | 10% |
| 100 | 0 | 100% |
| 0 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the production yield loss percentage.

It does not:

- Identify reject causes
- Calculate OEE
- Record production history
- Generate quality reports
- Control production equipment
- Perform statistical analysis

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateQuality.md
- FN_CalculateRejectRate.md
- FN_CalculateWastePercentage.md
- FN_CalculateFirstPassYield.md
- FB_QualityManager.md
- TEST_Functions.md

---

# Revision

Version 1.0