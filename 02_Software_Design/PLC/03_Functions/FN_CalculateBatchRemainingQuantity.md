# Function

FN_CalculateBatchRemainingQuantity

---

# Function

FN_CalculateBatchRemainingQuantity

---

# Purpose

Calculates the remaining quantity required to complete the current production batch.

This function provides a standardized method for determining the remaining material required before a batch reaches completion. It is used for HMI displays, production scheduling, and automatic batch management.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| BatchTargetQuantity | REAL | Target batch quantity (kg) |
| ProcessedQuantity | REAL | Quantity already processed (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Remaining batch quantity (kg) |

---

# Formula

```text
RemainingQuantity =
BatchTargetQuantity -
ProcessedQuantity
```

---

# Logic

```text
IF BatchTargetQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity < 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity >= BatchTargetQuantity THEN
    Return := 0.0;

ELSE
    Return :=
        BatchTargetQuantity -
        ProcessedQuantity;

END_IF;
```

---

# Rules

- BatchTargetQuantity shall be greater than zero.
- ProcessedQuantity shall be zero or greater.
- Remaining quantity shall never be negative.
- If the processed quantity exceeds the target, the function shall return zero.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Batch in progress | Remaining quantity (kg) |
| Batch completed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Remaining batch display
- Production scheduling
- Automatic batch sequencing
- HMI information panels
- Production KPI calculations
- Operator guidance

---

# Used By

- FB_BatchManager
- FB_JobManager
- FB_HMIManager
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Batch Target | Processed | Expected |
|-------------:|----------:|---------:|
| 1000 kg | 250 kg | 750 kg |
| 1000 kg | 1000 kg | 0 kg |
| 1000 kg | 1100 kg | 0 kg |
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

This function calculates only the remaining batch quantity.

It does not:

- Predict completion time
- Validate recipe values
- Start or stop production
- Control equipment
- Store historical batch data
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateBatchCompletion.md
- FN_CalculateRemaining.md
- FN_CalculateRemainingTime.md
- FB_BatchManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0