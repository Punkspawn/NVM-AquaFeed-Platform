# Function

FN_CalculateAlarmFrequency

---

# Function

FN_CalculateAlarmFrequency

---

# Purpose

Calculates the average alarm frequency for a specified operating period.

The function determines how often alarms occur per hour, providing a standardized KPI for reliability analysis, preventive maintenance, and system performance monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmCount | UINT | Total number of alarms |
| OperatingTime | TIME | Total operating time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Alarm frequency (alarms/hour) |

---

# Formula

```text
AlarmFrequency =
AlarmCount
/
(TIME_TO_DINT(OperatingTime) / 3600000.0)
```

---

# Logic

```text
IF OperatingTime <= T#0S THEN
    Return := 0.0;

ELSIF AlarmCount = 0 THEN
    Return := 0.0;

ELSE
    Return :=
        UINT_TO_REAL(AlarmCount) /
        (TIME_TO_DINT(OperatingTime) / 3600000.0);

END_IF;
```

---

# Rules

- OperatingTime shall be greater than zero.
- AlarmCount shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be expressed as alarms per hour.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Alarm frequency (alarms/hour) |
| OperatingTime ≤ 0 | 0.0 |
| AlarmCount = 0 | 0.0 |

---

# Typical Usage

- Alarm KPI calculations
- Reliability monitoring
- Maintenance planning
- Equipment health analysis
- Historical reporting
- HMI statistics

---

# Used By

- FB_AlarmManager
- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager

---

# Test Cases

| Alarm Count | Operating Time | Expected |
|------------:|---------------:|---------:|
| 10 | T#5H | 2 alarms/h |
| 24 | T#12H | 2 alarms/h |
| 5 | T#30M | 10 alarms/h |
| 0 | T#8H | 0 alarms/h |
| 5 | T#0S | 0 alarms/h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average alarm frequency.

It does not:

- Classify alarm severity
- Detect alarm flooding
- Filter duplicate alarms
- Store alarm history
- Reset alarm counters
- Generate maintenance notifications

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_GetAlarmPriority.md
- FN_CalculateFailureRate.md
- FB_AlarmManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0