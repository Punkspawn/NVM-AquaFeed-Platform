# Function

FN_CalculateEquipmentDowntime

---

# Function

FN_CalculateEquipmentDowntime

---

# Purpose

Calculates the downtime percentage of an equipment by comparing the accumulated downtime with the total scheduled operating time.

This KPI is used to evaluate equipment reliability and maintenance effectiveness for feeders, blowers, dosing units, conveyors, and other production equipment.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Downtime | REAL | Total equipment downtime (seconds) |
| ScheduledTime | REAL | Total scheduled operating time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Equipment downtime (%) |

---

# Formula

```text
EquipmentDowntime =
(Downtime /
ScheduledTime)
× 100
```

---

# Logic

```text
IF Downtime < 0.0 THEN

    Return := 0.0;

ELSIF ScheduledTime <= 0.0 THEN

    Return := 0.0;

ELSIF Downtime >= ScheduledTime THEN

    Return := 100.0;

ELSE

    Return :=
        (Downtime * 100.0)
        /
        ScheduledTime;

END_IF;
```

---

# Rules

- ScheduledTime shall be greater than zero.
- Downtime shall be zero or greater.
- Downtime shall not exceed ScheduledTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Equipment downtime (%) |
| No downtime | 0.0 |
| Equipment unavailable for entire schedule | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment reliability monitoring
- Preventive maintenance KPIs
- Production reporting
- Asset performance analysis
- OEE support calculations
- Maintenance dashboards

---

# Used By

- FB_MaintenanceManager
- FB_LineManager
- FB_ProductionManager
- FB_ReportManager
- FB_SystemManager

---

# Test Cases

| Downtime | Scheduled Time | Expected |
|---------:|---------------:|---------:|
| 0 s | 3600 s | 0% |
| 180 s | 3600 s | 5% |
| 900 s | 3600 s | 25% |
| 3600 s | 3600 s | 100% |
| 60 s | 0 s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the equipment downtime percentage.

It does not:

- Detect equipment failures
- Determine downtime causes
- Schedule maintenance
- Store historical maintenance data
- Generate maintenance reports
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateEquipmentAvailability.md
- FN_CalculateDowntime.md
- FN_CalculateAvailability.md
- FB_MaintenanceManager.md
- FB_LineManager.md
- TEST_Functions.md

---

# Revision

Version 1.0