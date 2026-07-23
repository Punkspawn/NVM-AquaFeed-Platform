# Function

FN_CalculateMaintenanceScheduleAdherence

---

# Function

FN_CalculateMaintenanceScheduleAdherence

---

# Purpose

Calculates the percentage of maintenance activities completed on or before their scheduled due date.

This KPI is used to evaluate maintenance planning effectiveness and adherence to the preventive maintenance schedule.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OnTimeMaintenance | DINT | Number of maintenance activities completed on schedule |
| ScheduledMaintenance | DINT | Total number of scheduled maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance schedule adherence (%) |

---

# Formula

```text
MaintenanceScheduleAdherence =
(OnTimeMaintenance /
ScheduledMaintenance)
× 100
```

---

# Logic

```text
IF ScheduledMaintenance <= 0 THEN

    Return := 0.0;

ELSIF OnTimeMaintenance < 0 THEN

    Return := 0.0;

ELSIF OnTimeMaintenance >= ScheduledMaintenance THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(OnTimeMaintenance) * 100.0)
        /
        REAL(ScheduledMaintenance);

END_IF;
```

---

# Rules

- ScheduledMaintenance shall be greater than zero.
- OnTimeMaintenance shall be zero or greater.
- OnTimeMaintenance shall not exceed ScheduledMaintenance.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance schedule adherence (%) |
| All maintenance completed on time | 100.0 |
| No maintenance completed on time | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Preventive maintenance KPI dashboards
- Maintenance planning analysis
- CMMS performance reporting
- Asset management systems
- Reliability engineering
- Maintenance performance monitoring

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| On Time | Scheduled | Expected |
|---------:|----------:|---------:|
| 20 | 20 | 100% |
| 18 | 20 | 90% |
| 15 | 20 | 75% |
| 0 | 20 | 0% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only maintenance schedule adherence.

It does not:

- Schedule maintenance activities
- Generate work orders
- Predict equipment failures
- Store maintenance history
- Analyze maintenance costs
- Execute maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompliance.md
- FN_CalculateMaintenanceEfficiency.md
- FN_CalculateMaintenanceOverdueRate.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0