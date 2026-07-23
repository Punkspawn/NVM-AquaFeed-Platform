# Function

FN_CalculateOEE

---

# Function

FN_CalculateOEE

---

# Purpose

Calculates the **Overall Equipment Effectiveness (OEE)** percentage.

OEE is a standard manufacturing KPI that combines Availability, Performance, and Quality into a single metric representing the overall effectiveness of equipment or a production line.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Availability | REAL | Availability (%) |
| Performance | REAL | Performance (%) |
| Quality | REAL | Quality (%) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Overall Equipment Effectiveness (%) |

---

# Formula

```text
OEE =
(Availability × Performance × Quality)
/
10000
```

Since each input is already expressed as a percentage (0–100), the product is divided by 100 × 100.

---

# Logic

```text
IF Availability < 0.0 OR Availability > 100.0 THEN
    Return := 0.0;

ELSIF Performance < 0.0 OR Performance > 100.0 THEN
    Return := 0.0;

ELSIF Quality < 0.0 OR Quality > 100.0 THEN
    Return := 0.0;

ELSE
    Return :=
        (Availability *
         Performance *
         Quality) / 10000.0;

END_IF;
```

---

# Rules

- Availability shall be between 0 and 100%.
- Performance shall be between 0 and 100%.
- Quality shall be between 0 and 100%.
- Invalid input values shall return 0.0.
- The calculated OEE shall always be between 0 and 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | OEE (%) |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Overall Equipment Effectiveness reporting
- Production KPI dashboard
- Shift performance analysis
- Historical production reports
- Maintenance performance evaluation
- Production benchmarking

---

# Used By

- FB_ReportManager
- FB_StatisticsManager
- FB_RuntimeManager
- FB_MaintenanceManager
- FB_SystemManager

---

# Test Cases

| Availability | Performance | Quality | Expected |
|--------------|------------:|---------:|---------:|
| 90% | 95% | 98% | 83.79% |
| 100% | 100% | 100% | 100% |
| 80% | 75% | 90% | 54% |
| 0% | 90% | 95% | 0% |
| 110% | 90% | 95% | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the Overall Equipment Effectiveness (OEE).

It does not:

- Calculate Availability
- Calculate Performance
- Calculate Quality
- Record production statistics
- Generate KPI reports
- Trigger maintenance actions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAvailability.md
- FN_CalculateEfficiency.md
- FN_CalculateUtilization.md
- FB_ReportManager.md
- FB_StatisticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0