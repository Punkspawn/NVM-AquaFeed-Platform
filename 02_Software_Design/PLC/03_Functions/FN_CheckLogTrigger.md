# Function

FN_CheckLogTrigger

---

# Function

FN_CheckLogTrigger

---

# Purpose

Determines whether a logging event should be created according to system events.

This function provides a standard trigger evaluation for data logging operations.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationStarted | BOOL | Operation start event |
| OperationCompleted | BOOL | Operation completion event |
| AlarmActive | BOOL | Active alarm event |
| StateChanged | BOOL | Equipment state change event |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Log trigger status |

---

# Logic

```text
IF OperationStarted = TRUE THEN

    Return := TRUE;

ELSIF OperationCompleted = TRUE THEN

    Return := TRUE;

ELSIF AlarmActive = TRUE THEN

    Return := TRUE;

ELSIF StateChanged = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Any defined logging event shall create a trigger condition.
- The function shall only evaluate event occurrence.
- The function shall not store log data.
- The function shall not write files.
- The function shall not communicate with external systems.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Logging event exists | TRUE |
| No logging event | FALSE |

---

# Typical Usage

- Operation history logging
- Alarm event logging
- Equipment state tracking
- Production record preparation

---

# Used By

- FB_DataLogger
- FB_ReportManager
- FB_StatisticsManager

---

# Test Cases

| Start | Complete | Alarm | State Change | Expected |
|------|----------|-------|--------------|----------|
| FALSE | FALSE | FALSE | FALSE | FALSE |
| TRUE | FALSE | FALSE | FALSE | TRUE |
| FALSE | TRUE | FALSE | FALSE | TRUE |
| FALSE | FALSE | TRUE | FALSE | TRUE |
| FALSE | FALSE | FALSE | TRUE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only creates a logging trigger.

It does not:

- Store records
- Create files
- Manage databases
- Generate timestamps
- Transfer data

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CreateOperationRecordID.md
- FN_GetLineStatusCode.md
- FB_DataLogger.md

---

# Revision

Version 1.0