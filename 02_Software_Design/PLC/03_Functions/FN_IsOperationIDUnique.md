# Function

FN_IsOperationIDUnique

---

# Purpose

Checks whether an operation identifier is unique within the available operation records.

This function prevents duplicate operation records from being stored.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Operation identifier to be checked |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the identifier is unique |

---

# Logic

```text
IF OperationID <= 0 THEN

    Return := FALSE;

ELSE

    Search existing operation records.

    IF OperationID already exists THEN

        Return := FALSE;

    ELSE

        Return := TRUE;

    END_IF;

END_IF;
```

---

# Rules

- OperationID shall be greater than zero.
- Duplicate identifiers shall not be accepted.
- The function shall only perform uniqueness verification.
- The function shall not create new identifiers.
- The function shall not modify existing records.
- Record searching method is implementation dependent.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Unique identifier | TRUE |
| Duplicate identifier | FALSE |
| Invalid identifier | FALSE |

---

# Typical Usage

- FB_DataLogger

---

# Used By

- FB_DataLogger

---

# Test Cases

| Existing IDs | Checked ID | Expected |
|-------------|-----------:|---------|
| 1,2,3 | 4 | TRUE |
| 1,2,3 | 2 | FALSE |
| Empty | 1 | TRUE |
| Any | 0 | FALSE |

---

# Complexity

Time Complexity

Implementation dependent

Memory Usage

Implementation dependent

---

# Notes

This function only verifies identifier uniqueness.

It does not:

- Generate identifiers
- Store records
- Delete records
- Modify records

These responsibilities belong to FB_DataLogger.

---

# Related Documents

- FN_CreateOperationRecordID.md
- FN_CheckOperationIDValidity.md
- FB_DataLogger.md

---

# Revision

Version 1.0