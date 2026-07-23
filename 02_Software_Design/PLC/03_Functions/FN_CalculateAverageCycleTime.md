# Function

FN_CalculateAverageCycleTime

---

# Function

FN_CalculateAverageCycleTime

---

# Purpose

Calculates the average cycle time from multiple completed production or feeding cycles.

The function provides a standardized KPI used for performance monitoring, production optimization, and historical reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalCycleTime | TIME | Sum of all completed cycle times |
| CycleCount | UINT | Number of completed cycles |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Average cycle time |

---

# Formula

```text
AverageCycleTime =
TotalCycleTime
/
CycleCount
```

---

# Logic

```text
IF CycleCount = 0 THEN
    Return := T#0S;

ELSIF TotalCycleTime <= T#0S THEN
    Return := T#0S;

ELSE
    Return :=
        DINT_TO_TIME(
            TIME_TO_DINT(TotalCycleTime) /
            UINT_TO_DINT(CycleCount)
        );

END_IF;
```

---

# Rules

- CycleCount shall be greater than zero.
- TotalCycleTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall represent the arithmetic mean cycle time.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average cycle time |
| CycleCount = 0 | T#0S |
| Invalid inputs | T#0S |

---

# Typical Usage

- Production performance analysis
- Feeding cycle optimization
- Historical KPI calculations
- Daily production reports
- HMI statistics
- Maintenance trend analysis

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Total Cycle Time | Cycle Count | Expected |
|-----------------|------------:|----------|
| T#100M | 10 | T#10M |
| T#45M | 9 | T#5M |
| T#0S | 5 | T#0S |
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

This function calculates only the arithmetic average cycle time.

It does not:

- Record cycle history
- Ignore abnormal cycle durations
- Detect production delays
- Predict future cycle times
- Generate reports
- Store statistical data

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCycleTime.md
- FN_CalculateJobDuration.md
- FB_ReportManager.md
- FB_HistoryManager.md
- TEST_Functions.md

---

# Revision

Version 1.0