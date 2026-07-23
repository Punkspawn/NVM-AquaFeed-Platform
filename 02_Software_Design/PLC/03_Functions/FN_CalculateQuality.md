# Function

FN_CalculateQuality

---

# Function

FN_CalculateQuality

---

# Purpose

Calculates the **Quality** percentage of the production process.

Quality represents the ratio of accepted production to total production. It is one of the three primary components of Overall Equipment Effectiveness (OEE).

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| GoodQuantity | REAL | Quantity accepted as good product (kg) |
| TotalQuantity | REAL | Total produced quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Quality (%) |

---

# Formula

```text
Quality =
(GoodQuantity /
TotalQuantity)
× 100
```

---

# Logic

```text
IF TotalQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF GoodQuantity < 0.0 THEN
    Return := 0.0;

ELSIF GoodQuantity >= TotalQuantity THEN
    Return := 100.0;

ELSE
    Return :=
        (GoodQuantity * 100.0) /
        TotalQuantity;

END_IF;
```

---

# Rules

- TotalQuantity shall be greater than zero.
- GoodQuantity shall be zero or greater.
- GoodQuantity shall not exceed TotalQuantity.
- Division by zero shall be prevented.
- Quality shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Quality (%) |
| GoodQuantity ≥ TotalQuantity | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- OEE calculations
- Production quality monitoring
- Batch quality analysis
- Daily production reports
- KPI dashboards
- Historical trend analysis

---

# Used By

- FB_ReportManager
- FB_StatisticsManager
- FB_RuntimeManager
- FB_SystemManager
- FN_CalculateOEE

---

# Test Cases

| Good Quantity | Total Quantity | Expected |
|--------------:|---------------:|---------:|
| 980 kg | 1000 kg | 98% |
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

This function calculates only the Quality component of OEE.

It does not:

- Inspect product quality
- Detect defective feed
- Calculate production efficiency
- Calculate Availability
- Calculate Performance
- Store production statistics
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateOEE.md
- FN_CalculatePerformance.md
- FN_CalculateAvailability.md
- FB_ReportManager.md
- FB_StatisticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0