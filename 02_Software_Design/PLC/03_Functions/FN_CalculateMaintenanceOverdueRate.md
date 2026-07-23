# Function

FN_CalculateMaintenanceOverdueRate

---

# Function

FN_CalculateMaintenanceOverdueRate

---

# Purpose

Calculates the percentage of maintenance activities that are overdue compared to the total number of scheduled maintenance activities.

This KPI is used to monitor maintenance backlog and evaluate preventive maintenance discipline.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OverdueMaintenance | DINT | Number of overdue maintenance activities |
| ScheduledMaintenance | DINT | Total number of scheduled maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Overdue maintenance rate (%) |

---

# Formula

```text
MaintenanceOverdueRate =
(OverdueMaintenance /
ScheduledMaintenance)
× 100
```

---

# Logic

```text
IF ScheduledMaintenance <= 0 THEN

    Return := 0.0;

ELSIF OverdueMaintenance < 0 THEN

    Return := 0.0;

ELSIF OverdueMaintenance >= ScheduledMaintenance THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(OverdueMaintenance) * 100.0)
        /
        REAL(ScheduledMaintenance);

END_IF;
```

---

# Rules

- ScheduledMaintenance shall be greater than zero.
- OverdueMaintenance shall be zero or greater.
- OverdueMaintenance shall not exceed ScheduledMaintenance.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Overdue maintenance rate (%) |
| No overdue maintenance | 0.0 |
| All maintenance overdue | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Preventive maintenance KPI dashboards
- Maintenance backlog monitoring
- Asset management reporting
- Reliability analysis
- Maintenance planning evaluation
- Maintenance performance tracking

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Overdue | Scheduled | Expected |
|---------:|----------:|---------:|
| 0 | 50 | 0% |
| 5 | 50 | 10% |
| 15 | 50 | 30% |
| 50 | 50 | 100% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the overdue maintenance rate.

It does not:

- Schedule maintenance work
- Generate work orders
- Predict equipment failures
- Record maintenance history
- Prioritize maintenance tasks
- Control maintenance execution

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompliance.md
- FN_CalculateEquipmentAvailability.md
- FB_MaintenanceManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0