# Function

FN_CheckOperationIDValidity

---

# Purpose

Checks whether an operation identifier is valid before it is used by the DataLogger.

This function prevents invalid operation identifiers from being processed.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Operation identifier |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the identifier is valid |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- OperationID shall be greater than zero.
- Zero shall be considered invalid.
- Negative values shall be considered invalid.
- The function shall only validate the identifier.
- The function shall not generate new identifiers.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid identifier | TRUE |
| Invalid identifier | FALSE |

---

# Typical Usage

- FB_DataLogger
- FB_OperationManager

---

# Used By

- FB_DataLogger

---

# Test Cases

| OperationID | Expected |
|------------:|---------|
| 1 | TRUE |
| 100 | TRUE |
| 0 | FALSE |
| -1 | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function validates only the operation identifier.

It does not:

- Create identifiers
- Store records
- Manage operation counters
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CreateOperationRecordID.md
- FN_ValidateOperationRecord.md
- FB_DataLogger.md

---

# Revision

Version 1.0