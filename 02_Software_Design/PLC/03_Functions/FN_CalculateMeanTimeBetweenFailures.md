# Function

FN_CalculateMeanTimeBetweenFailures

---

# Function

FN_CalculateMeanTimeBetweenFailures

---

# Purpose

Calculates the **Mean Time Between Failures (MTBF)** for equipment or the overall feeding system.

MTBF is a reliability KPI that represents the average operating time between consecutive failures. It is used to evaluate equipment reliability, maintenance effectiveness, and long-term system performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | TIME | Total operating time |
| FailureCount | UINT | Number of recorded failures |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Mean Time Between Failures (MTBF) |

---

# Formula

```text
MTBF =
OperatingTime
/
FailureCount
```

---

# Logic

```text
IF FailureCount = 0 THEN
    Return := OperatingTime;

ELSIF OperatingTime <= T#0S THEN
    Return := T#0S;

ELSE
    Return :=
        DINT_TO_TIME(
            TIME_TO_DINT(OperatingTime) /
            UINT_TO_DINT(FailureCount)
        );

END_IF;
```

---

# Rules

- OperatingTime shall be zero or greater.
- FailureCount shall be zero or greater.
- Division by zero shall be prevented.
- If no failures have occurred, MTBF equals the total operating time.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | MTBF |
| FailureCount = 0 | OperatingTime |
| OperatingTime ≤ T#0S | T#0S |

---

# Typical Usage

- Reliability KPI calculations
- Preventive maintenance analysis
- Equipment comparison
- Historical reporting
- Maintenance dashboards
- System performance evaluation

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager

---

# Test Cases

| Operating Time | Failure Count | Expected |
|---------------|--------------:|----------|
| T#100H | 5 | T#20H |
| T#48H | 2 | T#24H |
| T#72H | 0 | T#72H |
| T#0S | 3 | T#0S |
| T#12H | 1 | T#12H |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Mean Time Between Failures (MTBF).

It does not:

- Record failure events
- Determine failure causes
- Schedule maintenance
- Predict future failures
- Store maintenance history
- Generate maintenance work orders

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureRate.md
- FN_CalculateAlarmFrequency.md
- FB_MaintenanceManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0