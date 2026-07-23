# Function

FN_CalculateMaintenanceAvailability

---

# Function

FN_CalculateMaintenanceAvailability

---

# Purpose

Calculates the availability percentage of maintenance resources by comparing the time that maintenance resources were available with the total planned maintenance period.

This KPI is used to evaluate maintenance resource readiness and operational support capability.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| AvailableMaintenanceTime | REAL | Time maintenance resources were available (hours) |
| PlannedMaintenanceTime | REAL | Total planned maintenance period (hours) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance availability (%) |

---

# Formula

```text
MaintenanceAvailability =
(AvailableMaintenanceTime /
PlannedMaintenanceTime)
× 100
```

---

# Logic

```text
IF AvailableMaintenanceTime < 0.0 THEN

    Return := 0.0;

ELSIF PlannedMaintenanceTime <= 0.0 THEN

    Return := 0.0;

ELSIF AvailableMaintenanceTime >= PlannedMaintenanceTime THEN

    Return := 100.0;

ELSE

    Return :=
        (AvailableMaintenanceTime * 100.0)
        /
        PlannedMaintenanceTime;

END_IF;
```

---

# Rules

- PlannedMaintenanceTime shall be greater than zero.
- AvailableMaintenanceTime shall be zero or greater.
- AvailableMaintenanceTime shall not exceed PlannedMaintenanceTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance availability (%) |
| No resource availability | 0.0 |
| Fully available resources | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance resource monitoring
- Asset management dashboards
- Maintenance KPI calculations
- Reliability reporting
- Production support analysis
- Resource planning

---

# Used By

- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager
- FB_DiagnosticsManager

---

# Test Cases

| Available Time | Planned Time | Expected |
|---------------:|-------------:|---------:|
| 8 h | 8 h | 100% |
| 7 h | 8 h | 87.5% |
| 4 h | 8 h | 50% |
| 0 h | 8 h | 0% |
| 2 h | 0 h | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only maintenance resource availability.

It does not:

- Detect equipment failures
- Schedule maintenance tasks
- Assign technicians
- Record maintenance history
- Generate maintenance reports
- Control production equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateEquipmentAvailability.md
- FN_CalculateMaintenanceLaborUtilization.md
- FN_CalculateResourceUtilization.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0