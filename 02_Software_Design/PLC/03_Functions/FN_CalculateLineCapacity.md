# Function

FN_CalculateLineCapacity

---

# Function

FN_CalculateLineCapacity

---

# Purpose

Calculates the theoretical production capacity of a feeding line based on its operating rate and the available operating time.

This function provides a standardized capacity calculation for production planning, scheduling, and performance analysis.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FeedRate | REAL | Feeding rate (kg/min) |
| AvailableTime | TIME | Available operating time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Theoretical production capacity (kg) |

---

# Formula

```text
Capacity =
FeedRate
×
(TIME_TO_DINT(AvailableTime) / 60000.0)
```

---

# Logic

```text
IF FeedRate <= 0.0 THEN
    Return := 0.0;

ELSIF AvailableTime <= T#0S THEN
    Return := 0.0;

ELSE
    Return :=
        FeedRate *
        (TIME_TO_DINT(AvailableTime) / 60000.0);

END_IF;
```

---

# Rules

- FeedRate shall be greater than zero.
- AvailableTime shall be greater than zero.
- Capacity shall be expressed in kilograms (kg).
- Invalid input values shall return 0.0.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Calculated capacity (kg) |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production planning
- Feeding line capacity estimation
- Shift scheduling
- Recipe feasibility analysis
- HMI production statistics
- Performance reporting

---

# Used By

- FB_LineManager
- FB_JobManager
- FB_ReportManager
- FB_RuntimeManager
- FB_SystemManager

---

# Test Cases

| Feed Rate | Available Time | Expected |
|-----------|----------------|----------|
| 20 kg/min | T#60M | 1200 kg |
| 15 kg/min | T#30M | 450 kg |
| 0 kg/min | T#60M | 0 kg |
| 25 kg/min | T#0S | 0 kg |
| -5 kg/min | T#20M | 0 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the theoretical production capacity.

It does not:

- Measure actual production
- Account for equipment downtime
- Consider operator delays
- Calculate production efficiency
- Store production statistics
- Generate production schedules

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_CalculateProductionRate.md
- FN_CalculateUtilization.md
- FB_LineManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0