# Function

FN_CalculateWastePercentage

---

# Function

FN_CalculateWastePercentage

---

# Purpose

Calculates the percentage of wasted material during production or feeding operations.

Waste Percentage indicates how much of the total processed material was lost due to spillage, equipment malfunction, operator error, or other non-recoverable causes. This KPI is used to improve production efficiency and reduce material loss.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| WasteQuantity | REAL | Total wasted material (kg) |
| ProcessedQuantity | REAL | Total processed material (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Waste percentage (%) |

---

# Formula

```text
WastePercentage =
(WasteQuantity /
ProcessedQuantity)
× 100
```

---

# Logic

```text
IF ProcessedQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF WasteQuantity < 0.0 THEN
    Return := 0.0;

ELSIF WasteQuantity >= ProcessedQuantity THEN
    Return := 100.0;

ELSE
    Return :=
        (WasteQuantity * 100.0) /
        ProcessedQuantity;

END_IF;
```

---

# Rules

- ProcessedQuantity shall be greater than zero.
- WasteQuantity shall be zero or greater.
- WasteQuantity shall not exceed ProcessedQuantity.
- Division by zero shall be prevented.
- Waste Percentage shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Waste Percentage (%) |
| WasteQuantity ≥ ProcessedQuantity | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production loss analysis
- Material efficiency calculations
- Daily production reports
- Quality KPI dashboards
- Cost analysis
- Historical trend evaluation

---

# Used By

- FB_ReportManager
- FB_StatisticsManager
- FB_HistoryManager
- FB_SystemManager
- FB_ProductionManager

---

# Test Cases

| Waste Quantity | Processed Quantity | Expected |
|---------------:|-------------------:|---------:|
| 5 kg | 1000 kg | 0.5% |
| 50 kg | 1000 kg | 5% |
| 0 kg | 1000 kg | 0% |
| 1000 kg | 1000 kg | 100% |
| 25 kg | 0 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the waste percentage.

It does not:

- Identify waste sources
- Classify waste types
- Detect equipment failures
- Calculate production costs
- Store historical production data
- Generate management reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRejectRate.md
- FN_CalculateQuality.md
- FN_CalculateEfficiency.md
- FB_ReportManager.md
- FB_ProductionManager.md
- TEST_Functions.md

---

# Revision

Version 1.0