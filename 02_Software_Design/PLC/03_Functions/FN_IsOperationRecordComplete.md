# Function

FN_IsOperationRecordComplete

---

# Purpose

Checks whether all mandatory information required for an operation record is available.

This function is used before an operation record is accepted by the DataLogger.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Operation identifier |
| LineNumber | INT | Feeding line number |
| FeedAmount | REAL | Delivered feed amount (kg) |
| OperationDuration | TIME | Operation duration |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if all mandatory information is available |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSIF LineNumber <= 0 THEN

    Return := FALSE;

ELSIF FeedAmount < 0.0 THEN

    Return := FALSE;

ELSIF OperationDuration <= T#0s THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- OperationID shall be valid.
- LineNumber shall be greater than zero.
- FeedAmount shall not be negative.
- OperationDuration shall be greater than zero.
- The function shall only verify record completeness.
- The function shall not modify data.
- The function shall execute within one PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Complete record | TRUE |
| Missing or invalid data | FALSE |

---

# Typical Usage

- FB_DataLogger

---

# Used By

- FB_DataLogger

---

# Test Cases

| OperationID | Line | Feed | Duration | Expected |
|------------:|-----:|-----:|---------:|---------|
| 25 | 3 | 180 | T#95s | TRUE |
| 0 | 3 | 180 | T#95s | FALSE |
| 25 | 0 | 180 | T#95s | FALSE |
| 25 | 3 | 180 | T#0s | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only checks whether an operation record is complete.

It does not:

- Store records
- Generate reports
- Export data
- Calculate statistics

These responsibilities belong to FB_DataLogger.

---

# Related Documents

- FN_ValidateOperationRecord.md
- FB_DataLogger.md

---

# Revision

Version 1.0