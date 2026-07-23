# Function

FN_CalculateMaintenanceMeanRepairTime

---

# Function

FN_CalculateMaintenanceMeanRepairTime

---

# Purpose

Calculates the average repair duration by dividing the total repair time by the number of completed repair operations.

This KPI is used to evaluate repair efficiency, maintenance performance, and equipment maintainability.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalRepairTime | REAL | Total accumulated repair time (hours) |
| RepairCount | DINT | Number of completed repair operations |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Mean repair time (hours) |

---

# Formula

```text
MeanRepairTime =
TotalRepairTime /
RepairCount
```

---

# Logic

```text
IF TotalRepairTime < 0.0 THEN

    Return := 0.0;

ELSIF RepairCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalRepairTime /
        REAL(RepairCount);

END_IF;
```

---

# Rules

- RepairCount shall be greater than zero.
- TotalRepairTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall always be zero or greater.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Mean repair time |
| No repair operations | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance performance monitoring
- Equipment reliability analysis
- Repair process evaluation
- Preventive maintenance studies
- Reliability KPI dashboards
- Asset management reporting

---

# Used By

- FB_MaintenanceManager
- FB_DiagnosticsManager
- FB_ReportManager
- FB_SystemManager

---

# Test Cases

| Total Repair Time | Repair Count | Expected |
|------------------:|-------------:|---------:|
| 100 h | 10 | 10 h |
| 50 h | 5 | 10 h |
| 24 h | 8 | 3 h |
| 0 h | 10 | 0 h |
| 10 h | 0 | 0 h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only average repair duration.

It does not:

- Detect equipment failures
- Start repair procedures
- Assign technicians
- Store repair history
- Generate maintenance reports
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMeanTimeToRepair.md
- FN_CalculateMeanRecoveryTime.md
- FN_CalculateMaintenanceMeanCompletionTime.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0