# Function

FN_CalculateJobThroughput

---

# Function

FN_CalculateJobThroughput

---

# Purpose

Calculates the throughput of a completed feeding job.

Throughput represents the average amount of feed processed per hour during the entire job execution and is used as a key production performance indicator.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProcessedQuantity | REAL | Total processed feed (kg) |
| JobDuration | TIME | Total job duration |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Throughput (kg/h) |

---

# Formula

```text
Throughput =
ProcessedQuantity
/
(TIME_TO_DINT(JobDuration) / 3600000.0)
```

---

# Logic

```text
IF JobDuration <= T#0S THEN
    Return := 0.0;

ELSIF ProcessedQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        ProcessedQuantity /
        (TIME_TO_DINT(JobDuration) / 3600000.0);

END_IF;
```

---

# Rules

- JobDuration shall be greater than zero.
- ProcessedQuantity shall not be negative.
- Division by zero shall be prevented.
- Returned value shall be expressed in kg/h.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent variables shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Calculated throughput |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production KPI calculations
- Shift performance reporting
- Job performance analysis
- Historical statistics
- Capacity comparison
- HMI dashboards

---

# Used By

- FB_JobManager
- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager

---

# Test Cases

| Processed Quantity | Job Duration | Expected |
|-------------------:|-------------:|---------:|
| 1200 kg | T#6H | 200 kg/h |
| 900 kg | T#3H | 300 kg/h |
| 0 kg | T#2H | 0 kg/h |
| 500 kg | T#0S | 0 kg/h |
| -50 kg | T#1H | 0 kg/h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average throughput of a completed job.

It does not:

- Measure instantaneous throughput
- Predict future production rate
- Detect production interruptions
- Calculate equipment efficiency
- Store historical KPI values
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateProductionRate.md
- FN_CalculateFeedRate.md
- FN_CalculateJobDuration.md
- FB_JobManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0