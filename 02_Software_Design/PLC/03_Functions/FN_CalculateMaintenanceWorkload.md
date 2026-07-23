# Function

FN_CalculateMaintenanceWorkload

---

# Function

FN_CalculateMaintenanceWorkload

---

# Purpose

Calculates the maintenance workload percentage by comparing active maintenance work orders with the maximum maintenance capacity.

This KPI is used to monitor maintenance department utilization and resource planning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActiveWorkOrders | DINT | Number of active maintenance work orders |
| MaximumCapacity | DINT | Maximum manageable maintenance work orders |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance workload (%) |

---

# Formula

```text
MaintenanceWorkload =
(ActiveWorkOrders /
MaximumCapacity)
× 100
```

---

# Logic

```text
IF MaximumCapacity <= 0 THEN

    Return := 0.0;

ELSIF ActiveWorkOrders < 0 THEN

    Return := 0.0;

ELSIF ActiveWorkOrders >= MaximumCapacity THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(ActiveWorkOrders) * 100.0)
        /
        REAL(MaximumCapacity);

END_IF;
```

---

# Rules

- MaximumCapacity shall be greater than zero.
- ActiveWorkOrders shall be zero or greater.
- ActiveWorkOrders shall not exceed MaximumCapacity.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance workload (%) |
| No active work | 0.0 |
| Maximum workload reached | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance workload monitoring
- Resource capacity planning
- Maintenance KPI dashboards
- Technician workload analysis
- Asset management reporting
- Continuous improvement initiatives

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Active Work Orders | Capacity | Expected |
|-------------------:|---------:|---------:|
| 0 | 50 | 0% |
| 15 | 50 | 30% |
| 40 | 50 | 80% |
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

This function calculates only the maintenance workload percentage.

It does not:

- Assign technicians
- Prioritize maintenance tasks
- Schedule maintenance activities
- Store maintenance history
- Generate maintenance reports
- Execute maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceBacklog.md
- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMaintenanceEfficiency.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0