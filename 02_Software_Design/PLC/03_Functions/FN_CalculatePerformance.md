# Function

FN_CalculatePerformance

---

# Function

FN_CalculatePerformance

---

# Purpose

Calculates the **Performance** percentage of a production line.

Performance compares the theoretical production output with the actual production output during the operating period. It is one of the three primary components of Overall Equipment Effectiveness (OEE).

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| ActualProduction | REAL | Actual produced quantity (kg) |
| TheoreticalProduction | REAL | Maximum theoretical production (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Performance (%) |

---

# Formula

```text
Performance =
(ActualProduction /
TheoreticalProduction)
× 100
```

---

# Logic

```text
IF TheoreticalProduction <= 0.0 THEN
    Return := 0.0;

ELSIF ActualProduction < 0.0 THEN
    Return := 0.0;

ELSIF ActualProduction >= TheoreticalProduction THEN
    Return := 100.0;

ELSE
    Return :=
        (ActualProduction * 100.0) /
        TheoreticalProduction;

END_IF;
```

---

# Rules

- TheoreticalProduction shall be greater than zero.
- ActualProduction shall be zero or greater.
- Division by zero shall be prevented.
- Performance shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Performance (%) |
| ActualProduction ≥ TheoreticalProduction | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- OEE calculations
- Production KPI dashboard
- Shift performance analysis
- Equipment benchmarking
- Historical reporting
- Capacity evaluation

---

# Used By

- FB_ReportManager
- FB_StatisticsManager
- FB_RuntimeManager
- FB_SystemManager
- FN_CalculateOEE

---

# Test Cases

| Actual Production | Theoretical Production | Expected |
|------------------:|-----------------------:|---------:|
| 900 kg | 1000 kg | 90% |
| 1000 kg | 1000 kg | 100% |
| 1200 kg | 1000 kg | 100% |
| 0 kg | 1000 kg | 0% |
| 500 kg | 0 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Performance component of OEE.

It does not:

- Calculate Availability
- Calculate Quality
- Calculate OEE
- Validate production plans
- Store KPI history
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateOEE.md
- FN_CalculateAvailability.md
- FN_CalculateProductionRate.md
- FN_CalculateLineCapacity.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0