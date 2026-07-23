# Function

FN_CalculateFailureRate

---

# Function

FN_CalculateFailureRate

---

# Purpose

Calculates the percentage of failed jobs relative to the total number of executed jobs.

A failed job is any job that terminates due to a fault, emergency stop, communication loss, timeout, or operator cancellation before successful completion.

This KPI is used to evaluate production reliability and identify recurring operational issues.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailedJobs | UINT | Number of failed jobs |
| TotalJobs | UINT | Total number of executed jobs |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure rate (%) |

---

# Formula

```text
FailureRate =
(FailedJobs /
TotalJobs)
× 100
```

---

# Logic

```text
IF TotalJobs = 0 THEN
    Return := 0.0;

ELSIF FailedJobs >= TotalJobs THEN
    Return := 100.0;

ELSE
    Return :=
        (UINT_TO_REAL(FailedJobs) * 100.0) /
        UINT_TO_REAL(TotalJobs);

END_IF;
```

---

# Rules

- TotalJobs shall be greater than zero.
- FailedJobs shall not exceed TotalJobs.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure rate (%) |
| TotalJobs = 0 | 0.0 |
| FailedJobs ≥ TotalJobs | 100.0 |

---

# Typical Usage

- Reliability analysis
- Maintenance KPI calculations
- Production quality reports
- Historical statistics
- HMI dashboards
- Continuous improvement metrics

---

# Used By

- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Failed Jobs | Total Jobs | Expected |
|------------:|-----------:|---------:|
| 5 | 100 | 5% |
| 25 | 100 | 25% |
| 0 | 100 | 0% |
| 100 | 100 | 100% |
| 5 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the failure percentage.

It does not:

- Identify failure causes
- Classify alarm types
- Predict future failures
- Generate maintenance requests
- Store historical KPI values
- Reset fault counters

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateSuccessRate.md
- FN_GetAlarmPriority.md
- FB_ReportManager.md
- FB_HistoryManager.md
- TEST_Functions.md

---

# Revision

Version 1.0