# Function

FN_CalculateAverageFeedRate

---

# Function

FN_CalculateAverageFeedRate

---

# Purpose

Calculates the average feed rate from multiple completed feeding jobs.

The function is intended for long-term production analysis, KPI calculations, historical reporting, and trend evaluation across one or more feeding lines.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalFeedAmount | REAL | Total delivered feed (kg) |
| TotalFeedingTime | TIME | Total feeding duration |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average feed rate (kg/min) |

---

# Formula

```text
AverageFeedRate =
TotalFeedAmount
/
(TIME_TO_DINT(TotalFeedingTime) / 60000.0)
```

---

# Logic

```text
IF TotalFeedingTime <= T#0S THEN
    Return := 0.0;

ELSIF TotalFeedAmount < 0.0 THEN
    Return := 0.0;

ELSE
    Return :=
        TotalFeedAmount /
        (TIME_TO_DINT(TotalFeedingTime) / 60000.0);

END_IF;
```

---

# Rules

- TotalFeedingTime shall be greater than zero.
- TotalFeedAmount shall not be negative.
- Division by zero shall be prevented.
- The returned value shall be expressed in kilograms per minute (kg/min).
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average feed rate |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Daily production summaries
- Shift performance reports
- Historical KPI calculations
- Feeding efficiency analysis
- HMI statistics
- Management reports

---

# Used By

- FB_ReportManager
- FB_HistoryManager
- FB_RuntimeManager
- FB_StatisticsManager
- FB_SystemManager

---

# Test Cases

| Total Feed | Total Feeding Time | Expected |
|------------:|-------------------:|---------:|
| 600 kg | T#30M | 20 kg/min |
| 450 kg | T#15M | 30 kg/min |
| 0 kg | T#10M | 0 kg/min |
| 100 kg | T#0S | 0 kg/min |
| -50 kg | T#20M | 0 kg/min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average feed rate over the supplied period.

It does not:

- Calculate instantaneous feed rate
- Detect feeding interruptions
- Validate production recipes
- Control dosing equipment
- Store historical production data
- Generate statistical reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_CalculateProductionRate.md
- FN_CalculateAverageCycleTime.md
- FB_ReportManager.md
- FB_HistoryManager.md
- TEST_Functions.md

---

# Revision

Version 1.0