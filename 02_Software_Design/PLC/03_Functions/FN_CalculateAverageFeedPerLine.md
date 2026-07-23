# Function

FN_CalculateAverageFeedPerLine

---

# Purpose

Calculates the average amount of feed delivered per feeding line.

This function is used for statistical evaluation of feeding performance between independent lines.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalFeedAmount | REAL | Total delivered feed amount (kg) |
| ActiveLineCount | INT | Number of lines that completed feeding |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average feed amount per line (kg) |

---

# Formula

```text
AverageFeedPerLine =
TotalFeedAmount /
ActiveLineCount
```

---

# Logic

```text
IF TotalFeedAmount < 0.0 THEN

    Return := 0.0;

ELSIF ActiveLineCount <= 0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalFeedAmount /
        REAL(ActiveLineCount);

END_IF;
```

---

# Rules

- TotalFeedAmount shall be zero or greater.
- ActiveLineCount shall be greater than zero.
- Division by zero shall be prevented.
- The function shall only calculate the average value.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average feed amount per line (kg) |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Line performance statistics
- Feeding analysis
- Production reports
- HMI statistics display

---

# Used By

- FB_StatisticsManager
- FB_ReportManager

---

# Test Cases

| Total Feed | Active Lines | Expected |
|-----------:|-------------:|---------:|
| 600 kg | 6 | 100 kg |
| 250 kg | 5 | 50 kg |
| 100 kg | 0 | 0 kg |
| -10 kg | 2 | 0 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average feed amount per active line.

It does not:

- Measure feed quantity
- Count active lines
- Store statistics
- Generate reports
- Control feeding equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateTotalFeedAmount.md
- FN_CalculateAverageFeedAmount.md
- FB_StatisticsManager.md

---

# Revision

Version 1.0