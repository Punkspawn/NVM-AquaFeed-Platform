# Function

FN_CalculateCompletionPercentage

---

# Function

FN_CalculateCompletionPercentage

---

# Purpose

Calculates the completion percentage of a feeding or production job based on the processed quantity and the target quantity.

This function provides a standardized progress indicator for HMI displays, production reporting, and job monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProcessedQuantity | REAL | Quantity already processed (kg) |
| TargetQuantity | REAL | Total target quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Completion percentage (%) |

---

# Formula

```text
CompletionPercentage =
(ProcessedQuantity /
TargetQuantity)
× 100
```

---

# Logic

```text
IF TargetQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF ProcessedQuantity >= TargetQuantity THEN
    Return := 100.0;

ELSE
    Return :=
        (ProcessedQuantity * 100.0) /
        TargetQuantity;

END_IF;
```

---

# Rules

- TargetQuantity shall be greater than zero.
- ProcessedQuantity shall not be negative.
- The returned value shall be limited to a maximum of 100%.
- Division by zero shall be prevented.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Completion percentage |
| ProcessedQuantity ≥ TargetQuantity | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Job progress display
- HMI progress bar
- Batch monitoring
- Production reporting
- Historical statistics
- Operator information

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_ReportManager
- FB_HMIManager
- FB_RuntimeManager

---

# Test Cases

| Processed Quantity | Target Quantity | Expected |
|-------------------:|----------------:|---------:|
| 50 kg | 100 kg | 50% |
| 100 kg | 100 kg | 100% |
| 120 kg | 100 kg | 100% |
| 0 kg | 100 kg | 0% |
| 50 kg | 0 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only calculates completion percentage.

It does not:

- Predict completion time
- Calculate production efficiency
- Validate recipe values
- Control feeding equipment
- Store production history
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProgress.md
- FN_CalculateRemaining.md
- FN_CalculateRemainingTime.md
- FB_JobManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0