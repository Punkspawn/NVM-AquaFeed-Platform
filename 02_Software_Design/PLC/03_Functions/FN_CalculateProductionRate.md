# Function

FN_CalculateProductionRate

---

# Function

FN_CalculateProductionRate

---

# Purpose

Calculates the average production rate based on the produced quantity and the elapsed production time.

This function provides a standardized production KPI for reporting, performance monitoring, production planning, and historical analysis throughout the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ProducedQuantity | REAL | Total produced quantity (kg) |
| ProductionTime | TIME | Total production time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average production rate (kg/h) |

---

# Formula

```text
ProductionRate =
ProducedQuantity
/
(TIME_TO_DINT(ProductionTime) / 3600000.0)
```

---

# Logic

```text
IF ProductionTime <= T#0S THEN
    Return := 0.0;

ELSIF ProducedQuantity < 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        ProducedQuantity /
        (TIME_TO_DINT(ProductionTime) / 3600000.0);

END_IF;
```

---

# Rules

- ProductionTime shall be greater than zero.
- ProducedQuantity shall not be negative.
- Division by zero shall be prevented.
- The returned value shall be expressed in kilograms per hour (kg/h).
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average production rate |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production KPI calculations
- Shift performance analysis
- Daily production reports
- Historical statistics
- Capacity planning
- HMI production dashboard

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_HistoryManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Produced Quantity | Production Time | Expected |
|------------------:|----------------:|---------:|
| 1200 kg | T#6H | 200 kg/h |
| 500 kg | T#2H | 250 kg/h |
| 0 kg | T#4H | 0 kg/h |
| 100 kg | T#0S | 0 kg/h |
| -50 kg | T#1H | 0 kg/h |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average production rate.

It does not:

- Measure instantaneous production speed
- Predict production completion time
- Control equipment output
- Store production statistics
- Generate reports
- Trigger production alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_CalculateEfficiency.md
- FN_CalculateUtilization.md
- FB_ReportManager.md
- FB_RuntimeManager.md
- TEST_Functions.md

---

# Revision

Version 1.0