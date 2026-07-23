# Function

FN_CalculatePreventiveMaintenanceRatio

---

# Function

FN_CalculatePreventiveMaintenanceRatio

---

# Purpose

Calculates the percentage of preventive maintenance activities relative to the total completed maintenance activities.

This KPI is used to evaluate whether maintenance efforts are focused on preventive actions rather than corrective repairs.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PreventiveMaintenance | DINT | Number of completed preventive maintenance activities |
| TotalMaintenance | DINT | Total completed maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Preventive maintenance ratio (%) |

---

# Formula

```text
PreventiveMaintenanceRatio =
(PreventiveMaintenance /
TotalMaintenance)
× 100
```

---

# Logic

```text
IF TotalMaintenance <= 0 THEN

    Return := 0.0;

ELSIF PreventiveMaintenance < 0 THEN

    Return := 0.0;

ELSIF PreventiveMaintenance >= TotalMaintenance THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(PreventiveMaintenance) * 100.0)
        /
        REAL(TotalMaintenance);

END_IF;
```

---

# Rules

- TotalMaintenance shall be greater than zero.
- PreventiveMaintenance shall be zero or greater.
- PreventiveMaintenance shall not exceed TotalMaintenance.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Preventive maintenance ratio (%) |
| All maintenance preventive | 100.0 |
| No preventive maintenance | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- Preventive maintenance reporting
- Reliability engineering analysis
- Asset management reporting
- Maintenance strategy evaluation
- Continuous improvement metrics

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Preventive | Total | Expected |
|------------:|------:|---------:|
| 40 | 50 | 80% |
| 25 | 50 | 50% |
| 50 | 50 | 100% |
| 0 | 50 | 0% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the preventive maintenance ratio.

It does not:

- Schedule maintenance work
- Classify maintenance records
- Predict equipment failures
- Store maintenance history
- Generate maintenance reports
- Control maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompliance.md
- FN_CalculateMaintenanceOverdueRate.md
- FN_CalculateEquipmentAvailability.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0