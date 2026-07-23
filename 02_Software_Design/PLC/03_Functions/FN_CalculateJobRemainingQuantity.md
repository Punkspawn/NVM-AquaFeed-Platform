# Function

FN_CalculateJobRemainingQuantity

---

# Function

FN_CalculateJobRemainingQuantity

---

# Purpose

Calculates the remaining quantity required to complete the active production job.

This function provides a standardized calculation for production progress monitoring, HMI visualization, job scheduling, and reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| JobTargetQuantity | REAL | Target quantity for the production job (kg) |
| ProducedQuantity | REAL | Quantity already produced (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Remaining quantity to complete the job (kg) |

---

# Formula

```text
RemainingQuantity =
JobTargetQuantity -
ProducedQuantity
```

---

# Logic

```text
IF JobTargetQuantity <= 0.0 THEN

    Return := 0.0;

ELSIF ProducedQuantity < 0.0 THEN

    Return := 0.0;

ELSIF ProducedQuantity >= JobTargetQuantity THEN

    Return := 0.0;

ELSE

    Return :=
        JobTargetQuantity -
        ProducedQuantity;

END_IF;
```

---

# Rules

- JobTargetQuantity shall be greater than zero.
- ProducedQuantity shall be zero or greater.
- Remaining quantity shall never be negative.
- If the produced quantity equals or exceeds the target quantity, the function shall return zero.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Job in progress | Remaining quantity (kg) |
| Job completed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Job progress monitoring
- HMI remaining quantity display
- Production scheduling
- Automatic job sequencing
- Production KPI calculations
- Historical reporting

---

# Used By

- FB_JobManager
- FB_ProductionManager
- FB_HMIManager
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Target | Produced | Expected |
|-------:|---------:|---------:|
| 1000 kg | 250 kg | 750 kg |
| 1000 kg | 1000 kg | 0 kg |
| 1000 kg | 1200 kg | 0 kg |
| 500 kg | 0 kg | 500 kg |
| 0 kg | 100 kg | 0 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the remaining quantity for the current production job.

It does not:

- Calculate remaining production time
- Predict completion time
- Validate recipe parameters
- Control production equipment
- Store production history
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRemaining.md
- FN_CalculateJobDuration.md
- FN_CalculateBatchRemainingQuantity.md
- FB_JobManager.md
- FB_ProductionManager.md
- TEST_Functions.md

---

# Revision

Version 1.0