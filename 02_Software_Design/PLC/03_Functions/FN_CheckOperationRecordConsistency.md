# Function

FN_CheckOperationRecordConsistency

---

# Purpose

Checks the internal consistency of an operation record before it is accepted by the DataLogger.

This function verifies that the values contained in the record do not contradict each other.

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
| Return | BOOL | TRUE if the operation record is internally consistent |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSIF LineNumber <= 0 THEN

    Return := FALSE;

ELSIF FeedAmount < 0.0 THEN

    Return := FALSE;

ELSIF OperationDuration <= T#0s AND FeedAmount > 0.0 THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- OperationID shall be valid.
- LineNumber shall be valid.
- FeedAmount shall not be negative.
- A positive feed amount shall not exist with zero operation duration.
- The function shall only perform consistency checks.
- The function shall not modify the operation record.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Consistent record | TRUE |
| Inconsistent record | FALSE |

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
| 10 | 2 | 120 | T#90s | TRUE |
| 10 | 2 | 120 | T#0s | FALSE |
| 10 | 0 | 120 | T#90s | FALSE |
| 0 | 2 | 120 | T#90s | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only verifies the consistency of an operation record.

It does not:

- Store records
- Generate reports
- Calculate statistics
- Control feeding operations

These responsibilities belong to FB_DataLogger.

---

# Related Documents

- FN_ValidateOperationRecord.md
- FN_IsOperationRecordComplete.md
- FB_DataLogger.md

---

# Revision

Version 1.0