# Function

FN_IncrementOperationCounter

---

# Function

FN_IncrementOperationCounter

---

# Purpose

Calculates the counter increment value when an operation completion event occurs.

This function is used to track completed operations such as feeding cycles or equipment tasks.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationCompleted | BOOL | Operation completion event |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | DINT | Counter increment value |

---

# Logic

```text
IF OperationCompleted = TRUE THEN

    Return := 1;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Counter increment shall occur only after operation completion.
- The function shall only calculate increment value.
- The function shall not store the counter value.
- The function shall not reset counters.
- The function shall not manage operation sequence.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Operation completed | 1 |
| Operation not completed | 0 |

---

# Typical Usage

- Feeding cycle counting
- Production statistics
- Operation history
- Performance monitoring

---

# Used By

- FB_DataLogger
- FB_StatisticsManager
- FB_ReportManager

---

# Test Cases

| Operation Completed | Expected |
|--------------------|----------|
| FALSE | 0 |
| TRUE | 1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the counter increment.

It does not:

- Store total counters
- Save historical records
- Create reports
- Communicate with external systems

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CreateOperationRecordID.md
- FN_CheckLogTrigger.md
- FB_DataLogger.md

---

# Revision

Version 1.0