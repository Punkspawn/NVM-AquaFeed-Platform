# Function

FN_CalculateMaintenanceCostVariance

---

# Function

FN_CalculateMaintenanceCostVariance

---

# Purpose

Calculates the maintenance cost variance by comparing the actual maintenance cost with the planned maintenance budget.

This KPI is used to monitor maintenance cost control and evaluate budget performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualCost | REAL | Actual maintenance cost |
| PlannedCost | REAL | Planned maintenance budget |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Maintenance cost variance (%) |

---

# Formula

```text
MaintenanceCostVariance =
((ActualCost - PlannedCost) /
PlannedCost)
× 100
```

---

# Logic

```text
IF PlannedCost <= 0.0 THEN

    Return := 0.0;

ELSIF ActualCost < 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        ((ActualCost - PlannedCost) * 100.0)
        /
        PlannedCost;

END_IF;
```

---

# Rules

- PlannedCost shall be greater than zero.
- ActualCost shall be zero or greater.
- Division by zero shall be prevented.
- A positive value indicates the maintenance budget was exceeded.
- A negative value indicates the maintenance cost was below budget.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Actual equals planned | 0.0 |
| Actual greater than planned | Positive percentage |
| Actual less than planned | Negative percentage |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance cost monitoring
- Budget variance reporting
- Asset management dashboards
- Maintenance KPI reporting
- Cost optimization analysis
- Financial performance evaluation

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_SystemManager
- FB_CostManager

---

# Test Cases

| Actual Cost | Planned Cost | Expected |
|------------:|-------------:|---------:|
| 1000 | 1000 | 0% |
| 1100 | 1000 | +10% |
| 900 | 1000 | -10% |
| 1500 | 1000 | +50% |
| 100 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the maintenance cost variance.

It does not:

- Calculate maintenance costs
- Approve maintenance budgets
- Generate financial reports
- Store historical cost data
- Predict future maintenance costs
- Control maintenance activities

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceEfficiency.md
- FN_CalculateMaintenanceCompliance.md
- FB_MaintenanceManager.md
- FB_CostManager.md
- TEST_Functions.md

---

# Revision

Version 1.0