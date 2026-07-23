# Function

FN_CalculateMaintenanceCompletionRate

---

# Function

FN_CalculateMaintenanceCompletionRate

---

# Purpose

Calculates the percentage of maintenance work orders completed during a reporting period.

This KPI is used to evaluate maintenance execution performance and work order completion effectiveness.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CompletedWorkOrders | DINT | Number of completed maintenance work orders |
| TotalWorkOrders | DINT | Total maintenance work orders |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance completion rate (%) |

---

# Formula

```text
MaintenanceCompletionRate =
(CompletedWorkOrders /
TotalWorkOrders)
× 100
```

---

# Logic

```text
IF TotalWorkOrders <= 0 THEN

    Return := 0.0;

ELSIF CompletedWorkOrders < 0 THEN

    Return := 0.0;

ELSIF CompletedWorkOrders >= TotalWorkOrders THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(CompletedWorkOrders) * 100.0)
        /
        REAL(TotalWorkOrders);

END_IF;
```

---

# Rules

- TotalWorkOrders shall be greater than zero.
- CompletedWorkOrders shall be zero or greater.
- CompletedWorkOrders shall not exceed TotalWorkOrders.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance completion rate (%) |
| All work orders completed | 100.0 |
| No work orders completed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- CMMS reporting
- Maintenance performance monitoring
- Asset management reporting
- Reliability analysis
- Continuous improvement metrics

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Completed | Total | Expected |
|----------:|------:|---------:|
| 100 | 100 | 100% |
| 90 | 100 | 90% |
| 75 | 100 | 75% |
| 0 | 100 | 0% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the maintenance completion rate.

It does not:

- Create maintenance work orders
- Schedule maintenance tasks
- Assign technicians
- Record maintenance history
- Generate maintenance reports
- Execute maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompliance.md
- FN_CalculateMaintenanceScheduleAdherence.md
- FN_CalculateMaintenanceEfficiency.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0