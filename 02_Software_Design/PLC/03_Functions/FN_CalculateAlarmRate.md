# Function

FN_CalculateAlarmRate

---

# Function

FN_CalculateAlarmRate

---

# Purpose

Calculates the alarm occurrence rate by comparing the total number of alarms with the total operating time.

This function is used for maintenance analysis, equipment reliability evaluation, and production KPI reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmCount | DINT | Total number of alarms |
| OperatingTime | TIME | Total operating time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Alarm rate (alarms/hour) |

---

# Formula

```text
AlarmRate =
AlarmCount /
OperatingHours
```

---

# Logic

```text
VAR
    OperatingHours : REAL;
END_VAR

OperatingHours :=
    TIME_TO_REAL(OperatingTime) /
    3600000.0;

IF AlarmCount < 0 THEN

    Return := 0.0;

ELSIF OperatingHours <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        REAL(AlarmCount) /
        OperatingHours;

END_IF;
```

---

# Rules

- AlarmCount shall be zero or greater.
- OperatingTime shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents alarms per operating hour.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Alarm rate (alarms/hour) |
| AlarmCount = 0 | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI calculations
- Alarm statistics
- Equipment reliability analysis
- Preventive maintenance planning
- HMI dashboards
- Historical reporting

---

# Used By

- FB_AlarmManager
- FB_ReportManager
- FB_StatisticsManager
- FB_HMIManager
- FB_MaintenanceManager

---

# Test Cases

| Alarm Count | Operating Time | Expected |
|-------------:|---------------|---------:|
| 10 | 10 h | 1.0 |
| 25 | 5 h | 5.0 |
| 0 | 8 h | 0.0 |
| 12 | 0 h | 0.0 |
| -1 | 8 h | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average alarm occurrence rate.

It does not:

- Classify alarm priorities
- Detect alarm flooding
- Reset alarm counters
- Store alarm history
- Generate maintenance work orders
- Produce alarm reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAlarmFrequency.md
- FN_GetAlarmPriority.md
- FN_CalculateMeanTimeBetweenFailures.md
- FB_AlarmManager.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0