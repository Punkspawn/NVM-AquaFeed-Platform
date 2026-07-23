# Function

FN_CalculateMaintenanceBacklog

---

# Function

FN_CalculateMaintenanceBacklog

---

# Purpose

Calculates the percentage of maintenance work orders that remain open compared to the total maintenance work orders.

This KPI is used to monitor maintenance backlog and evaluate the maintenance department's ability to keep up with incoming work.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OpenWorkOrders | DINT | Number of open maintenance work orders |
| TotalWorkOrders | DINT | Total maintenance work orders |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance backlog (%) |

---

# Formula

```text
MaintenanceBacklog =
(OpenWorkOrders /
TotalWorkOrders)
× 100
```

---

# Logic

```text
IF TotalWorkOrders <= 0 THEN

    Return := 0.0;

ELSIF OpenWorkOrders < 0 THEN

    Return := 0.0;

ELSIF OpenWorkOrders >= TotalWorkOrders THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(OpenWorkOrders) * 100.0)
        /
        REAL(TotalWorkOrders);

END_IF;
```

---

# Rules

- TotalWorkOrders shall be greater than zero.
- OpenWorkOrders shall be zero or greater.
- OpenWorkOrders shall not exceed TotalWorkOrders.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance backlog (%) |
| No backlog | 0.0 |
| All work orders open | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance backlog monitoring
- CMMS KPI dashboards
- Maintenance workload analysis
- Asset management reporting
- Reliability engineering
- Continuous improvement reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Open Work Orders | Total Work Orders | Expected |
|-----------------:|------------------:|---------:|
| 0 | 100 | 0% |
| 10 | 100 | 10% |
| 35 | 100 | 35% |
| 100 | 100 | 100% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the maintenance backlog percentage.

It does not:

- Create maintenance work orders
- Prioritize maintenance activities
- Schedule maintenance jobs
- Store maintenance history
- Generate maintenance reports
- Execute maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompletionRate.md
- FN_CalculateMaintenanceOverdueRate.md
- FN_CalculateMaintenanceCompliance.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0