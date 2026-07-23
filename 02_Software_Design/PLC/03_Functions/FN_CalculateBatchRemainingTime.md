# Function

FN_CalculateBatchRemainingTime

---

# Function

FN_CalculateBatchRemainingTime

---

# Purpose

Calculates the estimated remaining time required to complete the current production batch based on the remaining quantity and the current production rate.

This function provides an estimation for HMI displays, production planning, and operator information.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RemainingQuantity | REAL | Remaining quantity to be produced (kg) |
| ProductionRate | REAL | Current production rate (kg/min) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Estimated remaining time (minutes) |

---

# Formula

```text
RemainingTime =
RemainingQuantity /
ProductionRate
```

---

# Logic

```text
IF RemainingQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ProductionRate <= 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        RemainingQuantity /
        ProductionRate;

END_IF;
```

---

# Rules

- RemainingQuantity shall be zero or greater.
- ProductionRate shall be greater than zero.
- Division by zero shall be prevented.
- Remaining time shall never be negative.
- If no production is occurring, the function shall return zero.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Estimated remaining time (minutes) |
| RemainingQuantity = 0 | 0.0 |
| ProductionRate ≤ 0 | 0.0 |

---

# Typical Usage

- Remaining production time display
- Batch progress monitoring
- Production scheduling
- HMI dashboards
- Operator guidance
- Production reporting

---

# Used By

- FB_BatchManager
- FB_ProductionManager
- FB_HMIManager
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Remaining Qty | Production Rate | Expected |
|--------------:|----------------:|---------:|
| 500 kg | 50 kg/min | 10 min |
| 250 kg | 25 kg/min | 10 min |
| 100 kg | 20 kg/min | 5 min |
| 0 kg | 20 kg/min | 0 min |
| 100 kg | 0 kg/min | 0 min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function estimates only the remaining production time.

It does not:

- Predict future production rate changes
- Control production equipment
- Detect production interruptions
- Validate production capacity
- Store historical production data
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRemainingTime.md
- FN_CalculateBatchCompletion.md
- FN_CalculateBatchRemainingQuantity.md
- FB_BatchManager.md
- FB_ProductionManager.md
- TEST_Functions.md

---

# Revision

Version 1.0