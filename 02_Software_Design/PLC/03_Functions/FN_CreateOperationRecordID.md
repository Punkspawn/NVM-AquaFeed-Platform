# Function

FN_CreateOperationRecordID

---

# Function

FN_CreateOperationRecordID

---

# Purpose

Creates a unique identifier for an operation record.

This function provides a simple identification value for logged operations such as feeding cycles, equipment events, and system records.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| LineID | INT | Feeding line identifier |
| OperationNumber | DINT | Operation sequence number |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | DINT | Generated record identifier |

---

# Formula

```text
RecordID =
(LineID × 100000)
+
OperationNumber
```

---

# Logic

```text
IF LineID < 0 THEN

    Return := 0;

ELSIF OperationNumber < 0 THEN

    Return := 0;

ELSE

    Return :=
        (LineID * 100000)
        +
        OperationNumber;

END_IF;
```

---

# Rules

- LineID shall represent the current line identifier.
- OperationNumber shall represent the operation sequence.
- Generated identifiers shall be unique within the defined range.
- The function shall only generate an identifier.
- The function shall not store records.
- The function shall not access memory storage.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Generated record ID |
| Invalid inputs | 0 |

---

# Typical Usage

- Feeding operation logging
- Event records
- Production history
- System reports

---

# Used By

- FB_DataLogger
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Line ID | Operation Number | Expected |
|--------:|-----------------:|---------:|
| 1 | 1 | 100001 |
| 2 | 15 | 200015 |
| 6 | 100 | 600100 |
| -1 | 10 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only creates a record identifier.

It does not:

- Save data
- Write files
- Transfer data
- Manage database operations
- Store historical records

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRuntimeHours.md
- FN_CalculateFeedAmount.md
- FB_DataLogger.md

---

# Revision

Version 1.0