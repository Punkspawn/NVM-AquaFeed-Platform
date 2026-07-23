# Function

FN_CalculateBatchCompletion

---

# Function

FN_CalculateBatchCompletion

---

# Purpose

Calculates the completion percentage of a production batch based on the processed quantity and the target batch quantity.

This function provides a standardized progress indicator for batch production, HMI visualization, production reporting, and automatic batch management.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| BatchTargetQuantity | REAL | Target batch quantity (kg) |
| ProcessedQuantity | REAL | Quantity processed so far (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Batch completion (%) |

---

# Formula

```text
BatchCompletion =
(ProcessedQuantity /
BatchTargetQuantity)
× 100
```

---

# Logic

```text
IF BatchTargetQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity < 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity >= BatchTargetQuantity THEN
    Return := 100.0;

ELSE
    Return :=
        (ProcessedQuantity * 100.0) /
        BatchTargetQuantity;

END_IF;
```

---

# Rules

- BatchTargetQuantity shall be greater than zero.
- ProcessedQuantity shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Completion percentage |
| ProcessedQuantity ≥ BatchTargetQuantity | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Batch progress display
- HMI progress bar
- Production monitoring
- Automatic batch control
- Historical production reporting
- KPI dashboard

---

# Used By

- FB_BatchManager
- FB_JobManager
- FB_ReportManager
- FB_HistoryManager
- FB_HMIManager

---

# Test Cases

| Batch Target | Processed | Expected |
|-------------:|----------:|---------:|
| 1000 kg | 500 kg | 50% |
| 1000 kg | 1000 kg | 100% |
| 1000 kg | 1100 kg | 100% |
| 1000 kg | 0 kg | 0% |
| 0 kg | 100 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the batch completion percentage.

It does not:

- Start or stop a batch
- Validate recipe parameters
- Control production equipment
- Predict completion time
- Store historical batch data
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCompletionPercentage.md
- FN_CalculateRemainingTime.md
- FB_BatchManager.md
- FB_JobManager.md
- TEST_Functions.md

---

# Revision

Version 1.0