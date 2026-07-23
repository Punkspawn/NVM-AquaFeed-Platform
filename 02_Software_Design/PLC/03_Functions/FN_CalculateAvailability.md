# Function

FN_CalculateAvailability

---

# Function

FN_CalculateAvailability

---

# Purpose

Calculates the operational availability of equipment or the overall feeding system.

Availability represents the percentage of time that the equipment is capable of performing its intended function during the scheduled operating period. It is one of the primary KPIs used for maintenance analysis and Overall Equipment Effectiveness (OEE).

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | TIME | Total operating time |
| Downtime | TIME | Total downtime |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Availability (%) |

---

# Formula

```text
Availability =
OperatingTime
/
(OperatingTime + Downtime)
× 100
```

---

# Logic

```text
VAR
    TotalTime : TIME;
END_VAR

TotalTime := OperatingTime + Downtime;

IF TotalTime <= T#0S THEN
    Return := 0.0;

ELSIF OperatingTime <= T#0S THEN
    Return := 0.0;

ELSE
    Return :=
        (TIME_TO_REAL(OperatingTime) * 100.0) /
        TIME_TO_REAL(TotalTime);

END_IF;
```

---

# Rules

- OperatingTime shall be zero or greater.
- Downtime shall be zero or greater.
- Division by zero shall be prevented.
- Returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Availability (%) |
| TotalTime = 0 | 0.0 |
| OperatingTime = 0 | 0.0 |

---

# Typical Usage

- OEE calculations
- Maintenance KPI reporting
- Equipment reliability analysis
- Historical production reports
- HMI KPI dashboard
- Performance benchmarking

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_StatisticsManager

---

# Test Cases

| Operating Time | Downtime | Expected |
|---------------|----------|----------|
| T#8H | T#2H | 80% |
| T#10H | T#0H | 100% |
| T#0H | T#5H | 0% |
| T#6H | T#6H | 50% |
| T#0H | T#0H | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only equipment availability.

It does not:

- Calculate Overall Equipment Effectiveness (OEE)
- Determine downtime causes
- Predict equipment failures
- Schedule maintenance
- Store historical KPI values
- Generate maintenance reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDowntime.md
- FN_CalculateUtilization.md
- FN_CalculateMeanTimeBetweenFailures.md
- FB_MaintenanceManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0