# Function

FN_CalculateScheduleCompliance

---

# Function

FN_CalculateScheduleCompliance

---

# Purpose

Calculates the schedule compliance percentage by comparing completed production within the planned schedule against the total planned production.

This KPI is used to evaluate how well production follows the planned schedule and supports production performance reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CompletedScheduledQuantity | DINT | Quantity completed within the scheduled time |
| PlannedQuantity | DINT | Total planned production quantity |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Schedule compliance (%) |

---

# Formula

```text
ScheduleCompliance =
(CompletedScheduledQuantity /
PlannedQuantity)
× 100
```

---

# Logic

```text
IF PlannedQuantity <= 0 THEN

    Return := 0.0;

ELSIF CompletedScheduledQuantity < 0 THEN

    Return := 0.0;

ELSIF CompletedScheduledQuantity >= PlannedQuantity THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(CompletedScheduledQuantity) * 100.0)
        /
        REAL(PlannedQuantity);

END_IF;
```

---

# Rules

- PlannedQuantity shall be greater than zero.
- CompletedScheduledQuantity shall be zero or greater.
- CompletedScheduledQuantity shall not exceed PlannedQuantity.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Schedule compliance (%) |
| Fully on schedule | 100.0 |
| No scheduled production completed | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production schedule monitoring
- Manufacturing KPI dashboards
- Batch production reporting
- Production planning analysis
- Performance monitoring
- Management reporting

---

# Used By

- FB_ProductionManager
- FB_BatchManager
- FB_ReportManager
- FB_SystemManager

---

# Test Cases

| Completed | Planned | Expected |
|----------:|--------:|---------:|
| 100 | 100 | 100% |
| 96 | 100 | 96% |
| 80 | 100 | 80% |
| 0 | 100 | 0% |
| 50 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the schedule compliance percentage.

It does not:

- Schedule production jobs
- Optimize production planning
- Calculate production efficiency
- Store production history
- Generate management reports
- Control production equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCompletionPercentage.md
- FN_CalculateProductionRate.md
- FN_CalculateProgress.md
- FB_ProductionManager.md
- FB_BatchManager.md
- TEST_Functions.md

---

# Revision

Version 1.0