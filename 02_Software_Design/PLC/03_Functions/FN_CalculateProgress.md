# Function

FN_CalculateProgress

---

# Purpose

Calculates the completion progress of an operation as a percentage based on the current progress and the target value.

This function is intended for displaying job completion, feeding progress, recipe execution status, and production progress throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentValue | REAL | Current completed amount |
| TargetValue | REAL | Target amount |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Progress percentage (%) |

---

# Formula

```text
Progress = (CurrentValue / TargetValue) × 100
```

---

# Logic

```text
IF TargetValue <= 0 THEN
    Return := 0.0;
ELSE
    Return := (CurrentValue / TargetValue) * 100.0;
END_IF;
```

---

# Rules

- TargetValue shall be greater than zero.
- Division by zero shall be prevented.
- Progress values greater than 100% are permitted if the target has been exceeded.
- The function shall not modify input values.
- No persistent memory shall be used.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| TargetValue > 0 | Calculated progress (%) |
| TargetValue ≤ 0 | 0.0 |

---

# Typical Usage

- Feeding progress display
- Recipe execution progress
- Batch completion monitoring
- Production progress tracking
- Job execution monitoring
- HMI progress indicators

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_RecipeManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Current | Target | Expected |
|---------:|-------:|---------:|
| 0 | 100 | 0 |
| 25 | 100 | 25 |
| 50 | 100 | 50 |
| 100 | 100 | 100 |
| 120 | 100 | 120 |
| 50 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only the mathematical progress calculation.

It does not:

- Limit the result to 100%
- Determine whether a job is complete
- Stop equipment
- Generate completion events
- Update historical records

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePercentage.md
- FN_CalculateRemaining.md
- FB_JobManager.md
- FB_FeedingControlManager.md
- TEST_Functions.md

---

# Revision

Version 1.0