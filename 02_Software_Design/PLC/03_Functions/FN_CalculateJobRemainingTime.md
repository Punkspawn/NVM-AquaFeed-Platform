# Function

FN_CalculateJobRemainingTime

---

# Function

FN_CalculateJobRemainingTime

---

# Purpose

Calculates the estimated remaining time required to complete the active production job based on the remaining quantity and the current production rate.

This function provides a standardized estimate for production monitoring, HMI visualization, job scheduling, and production reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RemainingQuantity | REAL | Remaining quantity to produce (kg) |
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
| Valid inputs | Remaining time (minutes) |
| RemainingQuantity = 0 | 0.0 |
| ProductionRate ≤ 0 | 0.0 |

---

# Typical Usage

- Job progress monitoring
- HMI remaining time display
- Production scheduling
- Operator information
- Production KPI calculations
- Production reporting

---

# Used By

- FB_JobManager
- FB_ProductionManager
- FB_HMIManager
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Remaining Qty | Production Rate | Expected |
|--------------:|----------------:|---------:|
| 1000 kg | 100 kg/min | 10 min |
| 500 kg | 50 kg/min | 10 min |
| 250 kg | 25 kg/min | 10 min |
| 0 kg | 25 kg/min | 0 min |
| 250 kg | 0 kg/min | 0 min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function estimates only the remaining production time for the current job.

It does not:

- Predict future production rate changes
- Calculate remaining quantity
- Detect production interruptions
- Control production equipment
- Store historical production data
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateJobRemainingQuantity.md
- FN_CalculateRemainingTime.md
- FN_CalculateBatchRemainingTime.md
- FB_JobManager.md
- FB_ProductionManager.md
- TEST_Functions.md

---

# Revision

Version 1.0