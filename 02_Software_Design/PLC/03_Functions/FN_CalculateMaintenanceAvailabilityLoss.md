# Function

FN_CalculateMaintenanceAvailabilityLoss

---

# Function

FN_CalculateMaintenanceAvailabilityLoss

---

# Purpose

Calculates the percentage loss of maintenance availability by comparing unavailable maintenance resource time with the total planned maintenance period.

This KPI is used to analyze resource availability losses affecting maintenance response capability and operational support.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| UnavailableTime | REAL | Total unavailable maintenance resource time (hours) |
| PlannedTime | REAL | Total planned maintenance period (hours) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance availability loss (%) |

---

# Formula

```text
MaintenanceAvailabilityLoss =
(UnavailableTime /
PlannedTime)
× 100
```

---

# Logic

```text
IF UnavailableTime < 0.0 THEN

    Return := 0.0;

ELSIF PlannedTime <= 0.0 THEN

    Return := 0.0;

ELSIF UnavailableTime >= PlannedTime THEN

    Return := 100.0;

ELSE

    Return :=
        (UnavailableTime * 100.0)
        /
        PlannedTime;

END_IF;
```

---

# Rules

- PlannedTime shall be greater than zero.
- UnavailableTime shall be zero or greater.
- UnavailableTime shall not exceed PlannedTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Availability loss (%) |
| No availability loss | 0.0 |
| Full loss of availability | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance KPI dashboards
- Resource availability analysis
- Reliability reporting
- Maintenance planning
- Asset management systems
- Operational support analysis

---

# Used By

- FB_MaintenanceManager
- FB_SystemManager
- FB_ReportManager
- FB_DiagnosticsManager

---

# Test Cases

| Unavailable Time | Planned Time | Expected |
|----------------:|-------------:|---------:|
| 0 h | 8 h | 0% |
| 1 h | 8 h | 12.5% |
| 4 h | 8 h | 50% |
| 8 h | 8 h | 100% |
| 2 h | 0 h | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only maintenance availability loss.

It does not:

- Detect causes of resource unavailability
- Schedule maintenance activities
- Assign maintenance personnel
- Store availability history
- Generate reports
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceAvailability.md
- FN_CalculateEquipmentAvailability.md
- FN_CalculateMaintenanceDowntime.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0