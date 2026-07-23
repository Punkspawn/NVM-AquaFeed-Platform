# Function

FN_CalculateAlarmDensity

---

# Function

FN_CalculateAlarmDensity

---

# Purpose

Calculates the alarm density by comparing the number of alarms with the produced material quantity.

Alarm density is a useful KPI for evaluating equipment stability independently of production time. It is commonly expressed as alarms per ton of production.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AlarmCount | DINT | Total number of alarms |
| ProducedQuantity | REAL | Total produced quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Alarm density (alarms/ton) |

---

# Formula

```text
AlarmDensity =
AlarmCount /
(ProducedQuantity / 1000)
```

---

# Logic

```text
VAR
    ProducedTon : REAL;
END_VAR

ProducedTon :=
    ProducedQuantity / 1000.0;

IF AlarmCount < 0 THEN

    Return := 0.0;

ELSIF ProducedTon <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        REAL(AlarmCount) /
        ProducedTon;

END_IF;
```

---

# Rules

- AlarmCount shall be zero or greater.
- ProducedQuantity shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents alarms per ton of production.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Alarm density (alarms/ton) |
| AlarmCount = 0 | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production KPI calculations
- Equipment reliability analysis
- Maintenance planning
- Shift comparison
- Historical production analysis
- Management reporting

---

# Used By

- FB_AlarmManager
- FB_StatisticsManager
- FB_ReportManager
- FB_MaintenanceManager
- FB_HistoryManager

---

# Test Cases

| Alarm Count | Produced Quantity | Expected |
|-------------:|-----------------:|---------:|
| 5 | 1000 kg | 5.0 |
| 8 | 2000 kg | 4.0 |
| 20 | 5000 kg | 4.0 |
| 0 | 1000 kg | 0.0 |
| 5 | 0 kg | 0.0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the alarm density based on production output.

It does not:

- Determine alarm priorities
- Classify alarm types
- Detect alarm flooding
- Store alarm history
- Generate maintenance actions
- Produce statistical reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAlarmRate.md
- FN_CalculateAlarmFrequency.md
- FN_GetAlarmPriority.md
- FB_AlarmManager.md
- FB_StatisticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0