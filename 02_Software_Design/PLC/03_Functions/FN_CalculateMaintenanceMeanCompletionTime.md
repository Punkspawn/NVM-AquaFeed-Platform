# Function

FN_CalculateMaintenanceMeanCompletionTime

---

# Function

FN_CalculateMaintenanceMeanCompletionTime

---

# Purpose

Calculates the average time required to complete maintenance activities by dividing the total maintenance completion duration by the number of completed maintenance activities.

This KPI is used to evaluate maintenance execution speed and support maintenance resource planning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalCompletionTime | REAL | Total maintenance completion time (hours) |
| CompletedActivities | DINT | Number of completed maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Mean maintenance completion time (hours) |

---

# Formula

```text
MeanCompletionTime =
TotalCompletionTime /
CompletedActivities
```

---

# Logic

```text
IF TotalCompletionTime < 0.0 THEN

    Return := 0.0;

ELSIF CompletedActivities <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalCompletionTime /
        REAL(CompletedActivities);

END_IF;
```

---

# Rules

- CompletedActivities shall be greater than zero.
- TotalCompletionTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall always be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average completion time |
| No completed activities | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance performance analysis
- Maintenance KPI dashboards
- Work order execution monitoring
- Resource planning
- Reliability reporting
- CMMS analytics

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Total Completion Time | Activities | Expected |
|----------------------:|-----------:|---------:|
| 100 h | 10 | 10 h |
| 50 h | 5 | 10 h |
| 24 h | 8 | 3 h |
| 0 h | 10 | 0 h |
| 10 h | 0 | 0 h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only average maintenance completion time.

It does not:

- Create maintenance activities
- Measure work execution time
- Assign maintenance personnel
- Store maintenance records
- Generate reports
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceMeanResponseTime.md
- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMeanTimeToRepair.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0