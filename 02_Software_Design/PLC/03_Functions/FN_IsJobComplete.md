# Function

FN_IsJobComplete

---

# Purpose

Determines whether a feeding job has been successfully completed based on the planned target quantity and the actual delivered quantity.

This function provides a standardized completion check for feeding operations, enabling consistent behavior across the Job Manager, Recipe Manager, reporting modules, and HMI.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetQuantity | REAL | Planned feed quantity (kg) |
| DeliveredQuantity | REAL | Actual delivered feed quantity (kg) |
| Tolerance | REAL | Allowed deviation (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the job is considered complete |

---

# Logic

```text
IF TargetQuantity <= 0 THEN
    Return := FALSE;

ELSIF DeliveredQuantity >= (TargetQuantity - Tolerance) THEN
    Return := TRUE;

ELSE
    Return := FALSE;

END_IF;
```

---

# Rules

- Target quantity shall be greater than zero.
- Completion is reached when the delivered quantity is equal to or greater than the target minus the allowed tolerance.
- Negative tolerance values are invalid and shall be prevented by the calling Function Block.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Target reached within tolerance | TRUE |
| Target not reached | FALSE |
| Invalid target quantity | FALSE |

---

# Typical Usage

- Feeding job completion
- Recipe execution
- Automatic batch sequencing
- Production reporting
- HMI status display
- Job scheduler validation

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_RecipeManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Target | Delivered | Tolerance | Expected |
|--------:|----------:|----------:|----------|
| 100 | 100 | 0 | TRUE |
| 100 | 99 | 1 | TRUE |
| 100 | 98 | 1 | FALSE |
| 50 | 60 | 0 | TRUE |
| 0 | 0 | 0 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates whether a feeding job has reached its completion criterion.

It does not:

- Stop dosing equipment
- Stop the blower
- Close the job record
- Generate completion events
- Save production statistics
- Advance to the next job

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProgress.md
- FN_CalculateRemaining.md
- FN_IsWithinTolerance.md
- FB_JobManager.md
- FB_FeedingControlManager.md
- TEST_Functions.md

---

# Revision

Version 1.0