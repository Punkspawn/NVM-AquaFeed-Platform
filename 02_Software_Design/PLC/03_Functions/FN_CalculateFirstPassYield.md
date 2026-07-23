# Function

FN_CalculateFirstPassYield

---

# Function

FN_CalculateFirstPassYield

---

# Purpose

Calculates the First Pass Yield (FPY), representing the percentage of products that pass inspection without requiring rework.

FPY is an important production quality KPI used to evaluate process effectiveness.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AcceptedQuantity | DINT | Quantity accepted on the first inspection |
| ProducedQuantity | DINT | Total produced quantity |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | First Pass Yield (%) |

---

# Formula

```text
FPY =
(AcceptedQuantity /
ProducedQuantity)
× 100
```

---

# Logic

```text
IF AcceptedQuantity < 0 THEN

    Return := 0.0;

ELSIF ProducedQuantity <= 0 THEN

    Return := 0.0;

ELSIF AcceptedQuantity >= ProducedQuantity THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(AcceptedQuantity) * 100.0) /
        REAL(ProducedQuantity);

END_IF;
```

---

# Rules

- ProducedQuantity shall be greater than zero.
- AcceptedQuantity shall be zero or greater.
- AcceptedQuantity shall not exceed ProducedQuantity.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | FPY (%) |
| All products accepted | 100.0 |
| No products accepted | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production quality monitoring
- Manufacturing KPI dashboards
- Batch quality analysis
- Process improvement
- Performance reporting
- OEE calculations

---

# Used By

- FB_ProductionManager
- FB_ReportManager
- FB_SystemManager
- FB_BatchManager
- FB_QualityManager

---

# Test Cases

| Accepted | Produced | Expected |
|---------:|---------:|---------:|
| 100 | 100 | 100% |
| 98 | 100 | 98% |
| 95 | 100 | 95% |
| 0 | 100 | 0% |
| 50 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the First Pass Yield KPI.

It does not:

- Perform quality inspection
- Determine reject causes
- Manage rework operations
- Store production history
- Generate reports
- Control production equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateQuality.md
- FN_CalculateRejectRate.md
- FN_CalculateOEE.md
- FB_QualityManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0