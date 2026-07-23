# Function

FN_CalculateTotalFeedAmount

---

# Function

FN_CalculateTotalFeedAmount

---

# Purpose

Calculates the total delivered feed amount by accumulating completed feed quantities.

This function is used for production statistics and feeding performance monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentTotal | REAL | Current accumulated feed amount (kg) |
| FeedAmount | REAL | Completed feeding amount to add (kg) |
| OperationCompleted | BOOL | Feeding operation completion status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Updated total feed amount (kg) |

---

# Formula

```text
TotalFeedAmount =
CurrentTotal +
FeedAmount
```

when:

```text
OperationCompleted = TRUE
```

---

# Logic

```text
IF OperationCompleted = TRUE THEN

    Return :=
        CurrentTotal +
        FeedAmount;

ELSE

    Return :=
        CurrentTotal;

END_IF;
```

---

# Rules

- Feed amount shall only be added after completed operation.
- FeedAmount shall represent a completed feeding quantity.
- The function shall only calculate the new total value.
- The function shall not store accumulated values.
- The function shall not manage production records.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Operation completed | Updated total amount |
| Operation not completed | Previous total amount |

---

# Typical Usage

- Total daily feed calculation
- Production statistics
- Feeding reports
- Performance monitoring

---

# Used By

- FB_StatisticsManager
- FB_DataLogger
- FB_ReportManager

---

# Test Cases

| Current Total | Feed Amount | Completed | Expected |
|--------------:|------------:|-----------|---------:|
| 1000 kg | 100 kg | TRUE | 1100 kg |
| 1000 kg | 100 kg | FALSE | 1000 kg |
| 0 kg | 50 kg | TRUE | 50 kg |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the updated total value.

It does not:

- Store total permanently
- Create reports
- Manage historical data
- Read sensors
- Control feeding equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedAmount.md
- FN_IncrementOperationCounter.md
- FB_StatisticsManager.md

---

# Revision

Version 1.0