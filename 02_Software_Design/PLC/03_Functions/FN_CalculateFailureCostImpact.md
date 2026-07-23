# Function

FN_CalculateFailureCostImpact

---

# Function

FN_CalculateFailureCostImpact

---

# Purpose

Calculates the percentage impact of equipment failures on total operational cost.

This KPI is used to evaluate the financial impact of failures and support maintenance improvement decisions.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FailureCost | REAL | Total cost caused by failures |
| TotalOperationalCost | REAL | Total operational cost |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Failure cost impact (%) |

---

# Formula

```text
FailureCostImpact =
(FailureCost /
TotalOperationalCost)
× 100
```

---

# Logic

```text
IF FailureCost < 0.0 THEN

    Return := 0.0;

ELSIF TotalOperationalCost <= 0.0 THEN

    Return := 0.0;

ELSIF FailureCost >= TotalOperationalCost THEN

    Return := 100.0;

ELSE

    Return :=
        (FailureCost * 100.0)
        /
        TotalOperationalCost;

END_IF;
```

---

# Rules

- TotalOperationalCost shall be greater than zero.
- FailureCost shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Failure cost impact (%) |
| No failure cost | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Maintenance cost analysis
- Reliability engineering
- Asset performance monitoring
- Failure impact reporting
- Maintenance optimization
- Management KPI dashboards

---

# Used By

- FB_DiagnosticsManager
- FB_MaintenanceManager
- FB_CostManager
- FB_ReportManager

---

# Test Cases

| Failure Cost | Total Cost | Expected |
|-------------:|-----------:|---------:|
| 0 | 10000 | 0% |
| 500 | 10000 | 5% |
| 2500 | 10000 | 25% |
| 10000 | 10000 | 100% |
| 500 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only failure cost impact.

It does not:

- Calculate actual failure costs
- Determine failure causes
- Generate maintenance actions
- Store financial history
- Create cost reports
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFailureSeverityIndex.md
- FN_CalculateMaintenanceCostVariance.md
- FN_CalculateMaintenanceCostPerWorkOrder.md
- FB_CostManager.md
- TEST_Functions.md

---

# Revision

Version 1.0