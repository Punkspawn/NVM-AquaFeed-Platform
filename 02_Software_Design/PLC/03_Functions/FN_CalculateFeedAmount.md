# Function

FN_CalculateFeedAmount

---

# Purpose

Calculates the total feed quantity to be dispensed during a feeding operation based on the dosing rate and feeding duration.

This function provides a standardized calculation method for all feeding lines and ensures consistent feed quantity reporting throughout the system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FeedRate | REAL | Feed delivery rate (kg/min) |
| Duration | REAL | Feeding duration (minutes) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Total calculated feed amount (kg) |

---

# Formula

```text
FeedAmount = FeedRate × Duration
```

---

# Logic

```text
IF FeedRate < 0 THEN
    Return := 0;

ELSIF Duration < 0 THEN
    Return := 0;

ELSE
    Return := FeedRate * Duration;
END_IF;
```

---

# Rules

- FeedRate shall not be negative.
- Duration shall not be negative.
- Invalid inputs shall produce a return value of zero.
- The function shall not modify input parameters.
- Calculation shall be completed within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | FeedRate × Duration |
| Invalid FeedRate | 0 |
| Invalid Duration | 0 |

---

# Typical Usage

- Recipe calculations
- Feeding job estimation
- Runtime statistics
- Feed consumption reporting
- Production reports
- HMI feed quantity display

---

# Used By

- FB_FeedingControlManager
- FB_RecipeManager
- FB_ReportManager
- FB_RuntimeManager
- FB_JobManager

---

# Test Cases

| FeedRate | Duration | Expected |
|----------:|---------:|---------:|
| 20 | 5 | 100 |
| 15.5 | 2 | 31 |
| 0 | 10 | 0 |
| -5 | 10 | 0 |
| 20 | -2 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function performs only the mathematical calculation.

It does not verify:

- Recipe validity
- Equipment availability
- Dosing accuracy
- Feed stock level

These checks shall be performed by the calling Function Block.

---

# Related Documents

- FN_CheckRange.md
- FN_LimitValue.md
- FB_FeedingControlManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0