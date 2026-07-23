# Function

FN_CalculateAlarmDuration

---

# Function

FN_CalculateAlarmDuration

---

# Purpose

Calculates the average duration of an alarm event based on the accumulated alarm time and the total number of alarm occurrences.

This function is intended for maintenance analysis, equipment reliability evaluation, and production KPI reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalAlarmTime | TIME | Total accumulated alarm duration |
| AlarmCount | DINT | Total number of alarm events |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Average duration of one alarm event |

---

# Formula

```text
AverageAlarmDuration =
TotalAlarmTime /
AlarmCount
```

---

# Logic

```text
VAR
    AverageMilliseconds : DINT;
END_VAR

IF AlarmCount <= 0 THEN

    Return := T#0S;

ELSE

    AverageMilliseconds :=
        TIME_TO_DINT(TotalAlarmTime) /
        AlarmCount;

    Return :=
        DINT_TO_TIME(AverageMilliseconds);

END_IF;
```

---

# Rules

- AlarmCount shall be greater than zero.
- TotalAlarmTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall never be negative.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average alarm duration |
| AlarmCount = 0 | T#0S |
| Invalid inputs | T#0S |

---

# Typical Usage

- Maintenance KPI calculations
- Alarm analysis
- Equipment reliability monitoring
- Mean alarm duration reporting
- Historical statistics
- Preventive maintenance planning

---

# Used By

- FB_AlarmManager
- FB_ReportManager
- FB_StatisticsManager
- FB_MaintenanceManager
- FB_HistoryManager

---

# Test Cases

| Total Alarm Time | Alarm Count | Expected |
|-----------------|------------:|---------:|
| T#10M | 5 | T#2M |
| T#30M | 10 | T#3M |
| T#5M | 1 | T#5M |
| T#0S | 5 | T#0S |
| T#10M | 0 | T#0S |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average duration of alarm events.

It does not:

- Detect alarm causes
- Classify alarm priorities
- Measure response time
- Store alarm history
- Generate maintenance work orders
- Produce alarm reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAlarmRate.md
- FN_CalculateAlarmFrequency.md
- FN_CalculateMeanTimeToRepair.md
- FB_AlarmManager.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0