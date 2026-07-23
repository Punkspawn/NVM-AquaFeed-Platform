# Function

FN_ValidateOperationRecord

---

# Purpose

Validates an operation record before it is stored by the DataLogger.

This function ensures that the operation data is internally consistent before logging.

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
| Return | BOOL | TRUE if the operation record is valid |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSIF LineNumber <= 0 THEN

    Return := FALSE;

ELSIF FeedAmount < 0.0 THEN

    Return := FALSE;

ELSIF OperationDuration < T#0s THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- OperationID shall be greater than zero.
- LineNumber shall be greater than zero.
- FeedAmount shall be zero or greater.
- OperationDuration shall not be negative.
- The function shall only validate data.
- The function shall not store records.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid record | TRUE |
| Invalid record | FALSE |

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
| 1 | 1 | 150 | T#120s | TRUE |
| 0 | 1 | 150 | T#120s | FALSE |
| 5 | 0 | 150 | T#120s | FALSE |
| 5 | 1 | -10 | T#120s | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function validates an operation record before logging.

It does not:

- Save records
- Generate reports
- Export data
- Count operations

These responsibilities belong to FB_DataLogger.

---

# Related Documents

- FB_DataLogger.md
- FN_CreateOperationRecordID.md

---

# Revision

Version 1.0