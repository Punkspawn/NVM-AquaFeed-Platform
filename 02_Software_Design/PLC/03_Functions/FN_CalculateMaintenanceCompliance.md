# Function

FN_CalculateMaintenanceCompliance

---

# Function

FN_CalculateMaintenanceCompliance

---

# Purpose

Calculates the maintenance compliance percentage by comparing the number of completed scheduled maintenance activities with the total number of planned maintenance activities.

This KPI is used to evaluate preventive maintenance performance and maintenance planning effectiveness.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CompletedMaintenance | DINT | Number of completed scheduled maintenance activities |
| PlannedMaintenance | DINT | Total number of planned maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance compliance (%) |

---

# Formula

```text
MaintenanceCompliance =
(CompletedMaintenance /
PlannedMaintenance)
× 100
```

---

# Logic

```text
IF PlannedMaintenance <= 0 THEN

    Return := 0.0;

ELSIF CompletedMaintenance < 0 THEN

    Return := 0.0;

ELSIF CompletedMaintenance >= PlannedMaintenance THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(CompletedMaintenance) * 100.0)
        /
        REAL(PlannedMaintenance);

END_IF;
```

---

# Rules

- PlannedMaintenance shall be greater than zero.
- CompletedMaintenance shall be zero or greater.
- CompletedMaintenance shall not exceed PlannedMaintenance.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance compliance (%) |
| All maintenance completed | 100.0 |
| No maintenance completed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Preventive maintenance KPI reporting
- Maintenance planning evaluation
- Asset management dashboards
- Reliability reporting
- Maintenance performance analysis
- CMMS reporting support

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Completed | Planned | Expected |
|----------:|--------:|---------:|
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

This function calculates only the maintenance compliance percentage.

It does not:

- Schedule maintenance
- Execute maintenance tasks
- Generate work orders
- Record maintenance history
- Predict equipment failures
- Control maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateEquipmentAvailability.md
- FN_CalculateEquipmentDowntime.md
- FN_CalculateAvailability.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0