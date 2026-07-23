# Function

FN_CalculateAverageJobDuration

---

# Function

FN_CalculateAverageJobDuration

---

# Purpose

Calculates the average duration of completed jobs.

This function provides a standardized KPI for evaluating production performance, estimating future execution times, and generating historical reports.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalJobDuration | TIME | Sum of all completed job durations |
| JobCount | UINT | Number of completed jobs |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Average job duration |

---

# Formula

```text
AverageJobDuration =
TotalJobDuration
/
JobCount
```

---

# Logic

```text
IF JobCount = 0 THEN
    Return := T#0S;

ELSIF TotalJobDuration <= T#0S THEN
    Return := T#0S;

ELSE
    Return :=
        DINT_TO_TIME(
            TIME_TO_DINT(TotalJobDuration) /
            UINT_TO_DINT(JobCount)
        );

END_IF;
```

---

# Rules

- JobCount shall be greater than zero.
- TotalJobDuration shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall represent the arithmetic mean job duration.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average job duration |
| JobCount = 0 | T#0S |
| Invalid inputs | T#0S |

---

# Typical Usage

- Historical performance analysis
- Production planning
- Shift statistics
- HMI KPI display
- Job scheduling
- Performance reporting

---

# Used By

- FB_JobManager
- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager

---

# Test Cases

| Total Job Duration | Job Count | Expected |
|-------------------|----------:|----------|
| T#20H | 10 | T#2H |
| T#75M | 5 | T#15M |
| T#0S | 8 | T#0S |
| T#30M | 0 | T#0S |
| T#12H | 24 | T#30M |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average duration of completed jobs.

It does not:

- Measure active runtime
- Predict future job durations
- Detect abnormal execution times
- Store historical values
- Generate production reports
- Control job execution

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateJobDuration.md
- FN_CalculateAverageCycleTime.md
- FN_CalculateRemainingTime.md
- FB_JobManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0