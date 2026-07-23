# Function

FN_CalculateMaintenanceCostPerHour

---

# Function

FN_CalculateMaintenanceCostPerHour

---

# Purpose

Calculates the average maintenance cost per maintenance hour.

This KPI is used to evaluate maintenance cost efficiency, labor productivity, and maintenance budgeting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalMaintenanceCost | REAL | Total maintenance cost |
| MaintenanceHours | REAL | Total maintenance hours |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average maintenance cost per hour |

---

# Formula

```text
MaintenanceCostPerHour =
TotalMaintenanceCost
/
MaintenanceHours
```

---

# Logic

```text
IF TotalMaintenanceCost < 0.0 THEN

    Return := 0.0;

ELSIF MaintenanceHours <= 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalMaintenanceCost
        /
        MaintenanceHours;

END_IF;
```

---

# Rules

- TotalMaintenanceCost shall be zero or greater.
- MaintenanceHours shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents the average maintenance cost for one maintenance hour.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average maintenance cost per hour |
| Zero maintenance hours | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance cost analysis
- Labor cost monitoring
- Asset management dashboards
- Maintenance KPI reporting
- Budget planning
- Cost optimization analysis

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_CostManager
- FB_SystemManager

---

# Test Cases

| Total Cost | Maintenance Hours | Expected |
|-----------:|------------------:|---------:|
| 1000 | 10 | 100 |
| 2400 | 24 | 100 |
| 1500 | 12 | 125 |
| 500 | 2 | 250 |
| 100 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average maintenance cost per maintenance hour.

It does not:

- Calculate labor costs
- Calculate spare part costs
- Approve maintenance budgets
- Store maintenance history
- Generate financial reports
- Manage maintenance operations

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCostPerWorkOrder.md
- FN_CalculateMaintenanceCostVariance.md
- FB_MaintenanceManager.md
- FB_CostManager.md
- TEST_Functions.md

---

# Revision

Version 1.0