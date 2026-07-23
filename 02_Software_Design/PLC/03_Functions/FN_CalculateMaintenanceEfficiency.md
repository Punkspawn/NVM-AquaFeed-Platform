# Function

FN_CalculateMaintenanceEfficiency

---

# Function

FN_CalculateMaintenanceEfficiency

---

# Purpose

Calculates maintenance efficiency by comparing the planned maintenance duration with the actual maintenance duration.

This KPI is used to evaluate how efficiently maintenance activities are executed and to identify opportunities for process improvement.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PlannedMaintenanceTime | REAL | Planned maintenance duration (seconds) |
| ActualMaintenanceTime | REAL | Actual maintenance duration (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance efficiency (%) |

---

# Formula

```text
MaintenanceEfficiency =
(PlannedMaintenanceTime /
ActualMaintenanceTime)
× 100
```

---

# Logic

```text
IF PlannedMaintenanceTime < 0.0 THEN

    Return := 0.0;

ELSIF ActualMaintenanceTime <= 0.0 THEN

    Return := 0.0;

ELSIF PlannedMaintenanceTime >= ActualMaintenanceTime THEN

    Return := 100.0;

ELSE

    Return :=
        (PlannedMaintenanceTime * 100.0)
        /
        ActualMaintenanceTime;

END_IF;
```

---

# Rules

- PlannedMaintenanceTime shall be zero or greater.
- ActualMaintenanceTime shall be greater than zero.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- A value of 100% indicates the maintenance was completed within or faster than the planned duration.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance efficiency (%) |
| Completed within planned time | 100.0 |
| Slower than planned | Calculated percentage |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- Maintenance performance analysis
- CMMS reporting
- Reliability engineering
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

| Planned | Actual | Expected |
|---------:|-------:|---------:|
| 60 min | 60 min | 100% |
| 60 min | 75 min | 80% |
| 60 min | 90 min | 66.7% |
| 60 min | 45 min | 100% |
| 60 min | 0 min | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only maintenance efficiency.

It does not:

- Schedule maintenance
- Predict equipment failures
- Record maintenance history
- Generate work orders
- Analyze failure causes
- Control maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCompliance.md
- FN_CalculatePreventiveMaintenanceRatio.md
- FN_CalculateCorrectiveMaintenanceRatio.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0