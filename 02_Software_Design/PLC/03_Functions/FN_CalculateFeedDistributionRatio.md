# Function

FN_CalculateFeedDistributionRatio

---

# Purpose

Calculates the percentage of the total delivered feed that belongs to a single feeding line.

This function is used for statistical evaluation of feed distribution between independent feeding lines.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| LineFeedAmount | REAL | Feed delivered by the current line (kg) |
| TotalFeedAmount | REAL | Total feed delivered by all lines (kg) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Feed distribution ratio (%) |

---

# Formula

```text
FeedDistributionRatio =
(LineFeedAmount /
TotalFeedAmount)
× 100
```

---

# Logic

```text
IF LineFeedAmount < 0.0 THEN

    Return := 0.0;

ELSIF TotalFeedAmount <= 0.0 THEN

    Return := 0.0;

ELSIF LineFeedAmount >= TotalFeedAmount THEN

    Return := 100.0;

ELSE

    Return :=
        (LineFeedAmount * 100.0)
        /
        TotalFeedAmount;

END_IF;
```

---

# Rules

- LineFeedAmount shall be zero or greater.
- TotalFeedAmount shall be greater than zero.
- Division by zero shall be prevented.
- Returned value shall be limited between 0–100%.
- The function shall only calculate the distribution ratio.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Distribution ratio (%) |
| Line equals total | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Feed distribution statistics
- Line performance comparison
- Production reports
- Statistical calculations

---

# Used By

- FB_StatisticsManager
- FB_ReportManager

---

# Test Cases

| Line Feed | Total Feed | Expected |
|----------:|-----------:|---------:|
| 100 kg | 600 kg | 16.67% |
| 300 kg | 600 kg | 50.00% |
| 600 kg | 600 kg | 100.00% |
| 0 kg | 600 kg | 0.00% |
| 100 kg | 0 kg | 0.00% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the feed distribution ratio.

It does not:

- Measure feed quantity
- Store statistical values
- Generate reports
- Control feeding equipment
- Compare line performance automatically

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateTotalFeedAmount.md
- FN_CalculateAverageFeedAmount.md
- FB_StatisticsManager.md

---

# Revision

Version 1.0