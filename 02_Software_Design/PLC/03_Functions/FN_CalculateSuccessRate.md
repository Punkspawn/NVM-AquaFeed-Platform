# Function

FN_CalculateSuccessRate

---

# Function

FN_CalculateSuccessRate

---

# Purpose

Calculates the success rate of completed jobs as a percentage.

A successful job is defined as a job that reaches the **Completed** state without being aborted, cancelled, or terminated by a fault. This KPI is used to evaluate system reliability and operational performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SuccessfulJobs | UINT | Number of successfully completed jobs |
| TotalJobs | UINT | Total number of executed jobs |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Success rate (%) |

---

# Formula

```text
SuccessRate =
(SuccessfulJobs /
TotalJobs)
× 100
```

---

# Logic

```text
IF TotalJobs = 0 THEN
    Return := 0.0;

ELSIF SuccessfulJobs >= TotalJobs THEN
    Return := 100.0;

ELSE
    Return :=
        (UINT_TO_REAL(SuccessfulJobs) * 100.0) /
        UINT_TO_REAL(TotalJobs);

END_IF;
```

---

# Rules

- TotalJobs shall be greater than zero.
- SuccessfulJobs shall not exceed TotalJobs.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Success rate (%) |
| TotalJobs = 0 | 0.0 |
| SuccessfulJobs ≥ TotalJobs | 100.0 |

---

# Typical Usage

- Production KPI calculations
- System reliability reporting
- Daily production summaries
- Historical statistics
- HMI dashboard
- Performance analysis

---

# Used By

- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Successful Jobs | Total Jobs | Expected |
|----------------:|-----------:|---------:|
| 95 | 100 | 95% |
| 50 | 100 | 50% |
| 0 | 100 | 0% |
| 100 | 100 | 100% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the job success percentage.

It does not:

- Determine why a job failed
- Analyze equipment faults
- Calculate production efficiency
- Generate reports
- Store historical KPI values
- Trigger maintenance actions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCompletionPercentage.md
- FN_CalculateEfficiency.md
- FB_ReportManager.md
- FB_HistoryManager.md
- TEST_Functions.md

---

# Revision

Version 1.0