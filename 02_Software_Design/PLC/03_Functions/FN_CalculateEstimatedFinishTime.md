# Function

FN_CalculateEstimatedFinishTime

---

# Function

FN_CalculateEstimatedFinishTime

---

# Purpose

Calculates the estimated completion timestamp of the current production job using the current PLC time and the calculated remaining production time.

This function is intended for HMI displays, production scheduling, operator information, and production reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentTime | DATE_AND_TIME | Current PLC date and time |
| RemainingTime | TIME | Estimated remaining production time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | DATE_AND_TIME | Estimated completion date and time |

---

# Formula

```text
EstimatedFinishTime =
CurrentTime +
RemainingTime
```

---

# Logic

```text
IF RemainingTime <= T#0S THEN

    Return := CurrentTime;

ELSE

    Return :=
        CurrentTime + RemainingTime;

END_IF;
```

---

# Rules

- CurrentTime shall be a valid PLC date and time.
- RemainingTime shall be zero or greater.
- Negative time values shall not be accepted.
- If RemainingTime equals zero, the current time shall be returned.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| RemainingTime > 0 | Estimated completion timestamp |
| RemainingTime = 0 | CurrentTime |

---

# Typical Usage

- HMI estimated finish display
- Production planning
- Job scheduling
- Batch completion estimation
- Operator information
- Production reports

---

# Used By

- FB_JobManager
- FB_BatchManager
- FB_HMIManager
- FB_ReportManager
- FB_ProductionManager

---

# Test Cases

| Current Time | Remaining Time | Expected |
|-------------|----------------|----------|
| 08:00:00 | T#30M | 08:30:00 |
| 14:15:00 | T#45M | 15:00:00 |
| 23:50:00 | T#20M | 00:10:00 (next day) |
| 10:00:00 | T#0S | 10:00:00 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function estimates only the expected completion timestamp.

It does not:

- Predict production interruptions
- Detect equipment failures
- Modify production schedules
- Calculate remaining production time
- Store historical production data
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRemainingTime.md
- FN_CalculateBatchRemainingTime.md
- FN_TimeToSeconds.md
- FB_JobManager.md
- FB_BatchManager.md
- TEST_Functions.md

---

# Revision

Version 1.0