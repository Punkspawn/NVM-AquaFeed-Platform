# Function

FN_CalculateRejectRate

---

# Function

FN_CalculateRejectRate

---

# Purpose

Calculates the reject (scrap) rate of the production process.

Reject Rate represents the percentage of produced material that does not meet quality requirements. It is a useful KPI for quality improvement, process optimization, and production reporting.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RejectedQuantity | REAL | Quantity rejected as scrap (kg) |
| TotalQuantity | REAL | Total produced quantity (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Reject rate (%) |

---

# Formula

```text
RejectRate =
(RejectedQuantity /
TotalQuantity)
× 100
```

---

# Logic

```text
IF TotalQuantity <= 0.0 THEN
    Return := 0.0;

ELSIF RejectedQuantity < 0.0 THEN
    Return := 0.0;

ELSIF RejectedQuantity >= TotalQuantity THEN
    Return := 100.0;

ELSE
    Return :=
        (RejectedQuantity * 100.0) /
        TotalQuantity;

END_IF;
```

---

# Rules

- TotalQuantity shall be greater than zero.
- RejectedQuantity shall be zero or greater.
- RejectedQuantity shall not exceed TotalQuantity.
- Division by zero shall be prevented.
- Reject Rate shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Reject Rate (%) |
| RejectedQuantity ≥ TotalQuantity | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Production quality analysis
- OEE Quality calculations
- Scrap reporting
- Daily production statistics
- Historical quality trends
- Management KPI dashboards

---

# Used By

- FB_ReportManager
- FB_StatisticsManager
- FB_HistoryManager
- FB_SystemManager
- FN_CalculateQuality

---

# Test Cases

| Rejected Quantity | Total Quantity | Expected |
|------------------:|---------------:|---------:|
| 20 kg | 1000 kg | 2% |
| 100 kg | 1000 kg | 10% |
| 0 kg | 1000 kg | 0% |
| 1000 kg | 1000 kg | 100% |
| 50 kg | 0 kg | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the reject percentage.

It does not:

- Identify reject causes
- Inspect product quality
- Classify defect types
- Calculate OEE
- Store quality statistics
- Generate production reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateQuality.md
- FN_CalculateOEE.md
- FB_ReportManager.md
- FB_StatisticsManager.md
- TEST_Functions.md

---

# Revision

Version 1.0