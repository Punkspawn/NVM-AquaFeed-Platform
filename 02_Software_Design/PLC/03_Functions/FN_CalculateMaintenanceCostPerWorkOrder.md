# Function

FN_CalculateMaintenanceCostPerWorkOrder

---

# Function

FN_CalculateMaintenanceCostPerWorkOrder

---

# Purpose

Calculates the average maintenance cost per completed work order.

This KPI is used to evaluate maintenance efficiency, cost effectiveness, and budgeting performance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalMaintenanceCost | REAL | Total maintenance cost |
| CompletedWorkOrders | DINT | Number of completed maintenance work orders |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average maintenance cost per work order |

---

# Formula

```text
MaintenanceCostPerWorkOrder =
TotalMaintenanceCost
/
CompletedWorkOrders
```

---

# Logic

```text
IF TotalMaintenanceCost < 0.0 THEN

    Return := 0.0;

ELSIF CompletedWorkOrders <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalMaintenanceCost
        /
        REAL(CompletedWorkOrders);

END_IF;
```

---

# Rules

- TotalMaintenanceCost shall be zero or greater.
- CompletedWorkOrders shall be greater than zero.
- Division by zero shall be prevented.
- The returned value represents the average cost for a single completed work order.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average maintenance cost per work order |
| Zero completed work orders | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance cost analysis
- Asset management dashboards
- CMMS reporting
- Budget planning
- Maintenance KPI monitoring
- Cost optimization analysis

---

# Used By

- FB_MaintenanceManager
- FB_ReportManager
- FB_CostManager
- FB_SystemManager

---

# Test Cases

| Total Cost | Completed Work Orders | Expected |
|-----------:|----------------------:|---------:|
| 1000 | 10 | 100 |
| 2500 | 25 | 100 |
| 900 | 6 | 150 |
| 500 | 1 | 500 |
| 100 | 0 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average maintenance cost per work order.

It does not:

- Calculate individual maintenance costs
- Approve maintenance budgets
- Generate financial reports
- Store historical maintenance costs
- Predict future maintenance expenses
- Manage maintenance work orders

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateMaintenanceCostVariance.md
- FN_CalculateMaintenanceCompletionRate.md
- FB_MaintenanceManager.md
- FB_CostManager.md
- TEST_Functions.md

---

# Revision

Version 1.0