# Function

FN_CalculateRemaining

---

# Purpose

Calculates the remaining amount by subtracting the completed quantity from the target quantity.

This function provides a standardized method for determining the remaining feed, production, or processing amount throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetValue | REAL | Planned or target quantity |
| CurrentValue | REAL | Completed or measured quantity |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Remaining quantity |

---

# Formula

```text
Remaining = TargetValue - CurrentValue
```

---

# Logic

```text
Return := TargetValue - CurrentValue;
```

---

# Rules

- The returned value may be positive, zero, or negative.
- A negative value indicates the target has been exceeded.
- The function shall not modify input values.
- No internal memory shall be used.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| CurrentValue < TargetValue | Positive value |
| CurrentValue = TargetValue | 0 |
| CurrentValue > TargetValue | Negative value |

---

# Typical Usage

- Remaining feed calculation
- Remaining recipe quantity
- Job completion tracking
- Batch processing
- Production monitoring
- HMI progress display

---

# Used By

- FB_JobManager
- FB_RecipeManager
- FB_FeedingControlManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Target | Current | Expected |
|--------:|--------:|---------:|
| 100 | 25 | 75 |
| 100 | 100 | 0 |
| 100 | 120 | -20 |
| 50 | 0 | 50 |
| 0 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only a subtraction between the target and current values.

It does not:

- Limit the result to zero
- Calculate completion percentage
- Validate process limits
- Generate completion events
- Stop running jobs

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePercentage.md
- FN_CalculateRatio.md
- FB_JobManager.md
- FB_FeedingControlManager.md
- TEST_Functions.md

---

# Revision

Version 1.0