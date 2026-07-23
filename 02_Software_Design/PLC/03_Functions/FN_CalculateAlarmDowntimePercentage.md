# Function

FN_CalculateAlarmDowntimePercentage

---

# Function

FN_CalculateAlarmDowntimePercentage

---

# Purpose

Calculates the percentage of production time lost due to alarm conditions by comparing the accumulated alarm downtime with the total available production time.

This KPI is useful for evaluating equipment reliability, maintenance effectiveness, and production losses.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmDowntime | TIME | Total alarm downtime |
| AvailableProductionTime | TIME | Total available production time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Alarm downtime percentage (%) |

---

# Formula

```text
AlarmDowntimePercentage =
(AlarmDowntime /
AvailableProductionTime)
× 100
```

---

# Logic

```text
VAR
    DowntimeSeconds : REAL;
    AvailableSeconds : REAL;
END_VAR

DowntimeSeconds :=
    TIME_TO_REAL(AlarmDowntime) /
    1000.0;

AvailableSeconds :=
    TIME_TO_REAL(AvailableProductionTime) /
    1000.0;

IF AvailableSeconds <= 0.0 THEN

    Return := 0.0;

ELSIF DowntimeSeconds < 0.0 THEN

    Return := 0.0;

ELSIF DowntimeSeconds >= AvailableSeconds THEN

    Return := 100.0;

ELSE

    Return :=
        (DowntimeSeconds * 100.0) /
        AvailableSeconds;

END_IF;
```

---

# Rules

- AvailableProductionTime shall be greater than zero.
- AlarmDowntime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- Downtime greater than available production time shall return 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Alarm downtime (%) |
| AlarmDowntime ≥ AvailableProductionTime | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- OEE calculations
- Maintenance KPI dashboards
- Production loss analysis
- Reliability reporting
- Shift performance comparison
- Historical statistics

---

# Used By

- FB_AlarmManager
- FB_OEEManager
- FB_ReportManager
- FB_StatisticsManager
- FB_MaintenanceManager

---

# Test Cases

| Alarm Downtime | Available Time | Expected |
|---------------|----------------|---------:|
| T#30M | T#10H | 5% |
| T#1H | T#8H | 12.5% |
| T#8H | T#8H | 100% |
| T#0S | T#8H | 0% |
| T#30M | T#0S | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the percentage of production time lost due to alarm conditions.

It does not:

- Calculate MTBF or MTTR
- Detect alarm causes
- Classify alarm priorities
- Control production equipment
- Store historical alarm data
- Generate maintenance reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateDowntime.md
- FN_CalculateAvailability.md
- FN_CalculateOEE.md
- FN_CalculateAlarmDuration.md
- FB_AlarmManager.md
- TEST_Functions.md

---

# Revision

Version 1.0