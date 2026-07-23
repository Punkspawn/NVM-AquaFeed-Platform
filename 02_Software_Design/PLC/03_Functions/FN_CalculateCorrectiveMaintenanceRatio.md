# Function

FN_CalculateCorrectiveMaintenanceRatio

---

# Function

FN_CalculateCorrectiveMaintenanceRatio

---

# Purpose

Calculates the percentage of corrective maintenance activities relative to the total completed maintenance activities.

This KPI is used to evaluate maintenance strategy effectiveness and identify excessive reactive maintenance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CorrectiveMaintenance | DINT | Number of completed corrective maintenance activities |
| TotalMaintenance | DINT | Total completed maintenance activities |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Corrective maintenance ratio (%) |

---

# Formula

```text
CorrectiveMaintenanceRatio =
(CorrectiveMaintenance /
TotalMaintenance)
× 100
```

---

# Logic

```text
IF TotalMaintenance <= 0 THEN

    Return := 0.0;

ELSIF CorrectiveMaintenance < 0 THEN

    Return := 0.0;

ELSIF CorrectiveMaintenance >= TotalMaintenance THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(CorrectiveMaintenance) * 100.0)
        /
        REAL(TotalMaintenance);

END_IF;
```

---

# Rules

- TotalMaintenance shall be greater than zero.
- CorrectiveMaintenance shall be zero or greater.
- CorrectiveMaintenance shall not exceed TotalMaintenance.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Corrective maintenance ratio (%) |
| All maintenance corrective | 100.0 |
| No corrective maintenance | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- Reliability engineering analysis
- Maintenance strategy evaluation
- Asset management reporting
- Maintenance performance monitoring
- Continuous improvement reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_DiagnosticsManager

---

# Test Cases

| Corrective | Total | Expected |
|-----------:|------:|---------:|
| 10 | 50 | 20% |
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

This function calculates only the corrective maintenance ratio.

It does not:

- Classify maintenance records
- Schedule maintenance work
- Predict equipment failures
- Store maintenance history
- Generate maintenance reports
- Control maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculatePreventiveMaintenanceRatio.md
- FN_CalculateMaintenanceCompliance.md
- FN_CalculateEquipmentAvailability.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0