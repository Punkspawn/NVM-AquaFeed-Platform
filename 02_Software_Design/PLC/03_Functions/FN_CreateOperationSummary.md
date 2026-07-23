# Function

FN_CreateOperationSummary

---

# Purpose

Creates a summary of a completed feeding operation using the available operation data.

This function prepares the information required by report generation and user interfaces.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Completed operation identifier |
| FeedAmount | REAL | Total delivered feed (kg) |
| OperationDuration | TIME | Total operation duration |
| LineNumber | INT | Feeding line number |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the summary was successfully created |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSIF FeedAmount < 0.0 THEN

    Return := FALSE;

ELSIF LineNumber <= 0 THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- OperationID shall be valid.
- FeedAmount shall be zero or greater.
- LineNumber shall be greater than zero.
- The function shall only validate the data required for a summary.
- The function shall not save report data.
- The function shall not write files.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid data | TRUE |
| Invalid data | FALSE |

---

# Typical Usage

- FB_ReportManager
- HMI operation summary
- Data export preparation

---

# Used By

- FB_ReportManager

---

# Test Cases

| OperationID | Feed | Line | Expected |
|------------:|-----:|-----:|---------|
| 1 | 120 | 2 | TRUE |
| 0 | 120 | 2 | FALSE |
| 5 | -5 | 2 | FALSE |
| 5 | 120 | 0 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only validates the information required to create an operation summary.

It does not:

- Save reports
- Export files
- Format report text
- Print reports

These responsibilities belong to FB_ReportManager.

---

# Related Documents

- FB_ReportManager.md
- FN_CalculateTotalFeedAmount.md
- FN_CalculateAverageOperationTime.md

---

# Revision

Version 1.0