# Function

FN_CalculateMaintenanceIdleTime

---

# Function

FN_CalculateMaintenanceIdleTime

---

# Purpose

Calculates the percentage of maintenance idle time by comparing the unused available maintenance time with the total available maintenance time.

This KPI is used to evaluate unused maintenance capacity and identify opportunities for improved resource planning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| IdleTime | REAL | Total idle maintenance time (hours) |
| AvailableTime | REAL | Total available maintenance time (hours) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance idle time (%) |

---

# Formula

```text
MaintenanceIdleTime =
(IdleTime /
AvailableTime)
× 100
```

---

# Logic

```text
IF IdleTime < 0.0 THEN

    Return := 0.0;

ELSIF AvailableTime <= 0.0 THEN

    Return := 0.0;

ELSIF IdleTime >= AvailableTime THEN

    Return := 100.0;

ELSE

    Return :=
        (IdleTime * 100.0)
        /
        AvailableTime;

END_IF;
```

---

# Rules

- AvailableTime shall be greater than zero.
- IdleTime shall be zero or greater.
- IdleTime shall not exceed AvailableTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Maintenance idle time (%) |
| No idle time | 0.0 |
| Entire period idle | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance capacity analysis
- Workforce utilization studies
- Maintenance KPI dashboards
- Resource optimization
- Planning improvement activities
- Asset management reporting

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_CostManager

---

# Test Cases

| Idle Time | Available Time | Expected |
|----------:|---------------:|---------:|
| 0 h | 8 h | 0% |
| 2 h | 8 h | 25% |
| 4 h | 8 h | 50% |
| 8 h | 8 h | 100% |
| 1 h | 0 h | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only maintenance idle time percentage.

It does not:

- Schedule maintenance work
- Assign technicians
- Optimize resources
- Store maintenance history
- Generate reports
- Control maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceLaborUtilization.md
- FN_CalculateMaintenanceWorkload.md
- FN_CalculateResourceUtilization.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0