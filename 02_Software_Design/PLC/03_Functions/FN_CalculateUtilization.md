# Function

FN_CalculateUtilization

---

# Purpose

Calculates the utilization percentage of equipment or a production line based on its operating time and the total available time.

This function provides a standardized KPI used for production analysis, maintenance planning, and overall equipment performance monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | TIME | Total time the equipment was operating |
| AvailableTime | TIME | Total available production time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Utilization (%) |

---

# Formula

```text
Utilization =
(TIME_TO_DINT(OperatingTime) /
TIME_TO_DINT(AvailableTime))
× 100
```

---

# Logic

```text
IF AvailableTime <= T#0S THEN
    Return := 0.0;

ELSIF OperatingTime < T#0S THEN
    Return := 0.0;

ELSE
    Return :=
        (TIME_TO_DINT(OperatingTime) * 100.0) /
        TIME_TO_DINT(AvailableTime);

END_IF;
```

---

# Rules

- AvailableTime shall be greater than zero.
- OperatingTime shall not be negative.
- Division by zero shall be prevented.
- Utilization may exceed 100% if the recorded operating time exceeds the available time.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Utilization (%) |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment utilization reporting
- Line efficiency analysis
- Daily production statistics
- Maintenance planning
- HMI KPI dashboard
- Historical performance reports

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Operating Time | Available Time | Expected |
|---------------|----------------|----------|
| T#8H | T#10H | 80% |
| T#10H | T#10H | 100% |
| T#11H | T#10H | 110% |
| T#0H | T#10H | 0% |
| T#5H | T#0H | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the utilization percentage.

It does not:

- Measure equipment runtime
- Detect downtime causes
- Calculate OEE
- Generate maintenance schedules
- Store historical KPI values
- Produce reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateEfficiency.md
- FN_CalculateJobDuration.md
- FB_RuntimeManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0