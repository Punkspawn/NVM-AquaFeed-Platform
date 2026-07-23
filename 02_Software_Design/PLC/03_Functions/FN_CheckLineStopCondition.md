# Function

FN_CheckLineStopCondition

---

# Function

FN_CheckLineStopCondition

---

# Purpose

Checks whether an individual feeding line should stop operation.

This function evaluates stop conditions for a single feeding line during automatic operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| StopCommand | BOOL | Operator stop command |
| FaultActive | BOOL | Active line fault status |
| FeedCompleted | BOOL | Feeding operation completed status |
| EmergencyActive | BOOL | Emergency stop status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Stop request status |

---

# Logic

```text
IF EmergencyActive = TRUE THEN

    Return := TRUE;

ELSIF FaultActive = TRUE THEN

    Return := TRUE;

ELSIF StopCommand = TRUE THEN

    Return := TRUE;

ELSIF FeedCompleted = TRUE THEN

    Return := TRUE;

ELSE

    Return := FALSE;

END_IF;
```

---

# Rules

- Emergency condition has the highest priority.
- Fault condition shall stop the current line.
- Operator stop command shall stop the current line.
- Completed feeding operation shall request stop.
- The function shall only evaluate stop conditions.
- The function shall not stop equipment outputs directly.
- Other line states shall not affect the result.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Emergency active | TRUE |
| Fault active | TRUE |
| Stop command active | TRUE |
| Feed completed | TRUE |
| Normal operation | FALSE |

---

# Typical Usage

- Automatic feeding sequence
- Line shutdown control
- Sequence management
- Alarm response

---

# Used By

- FB_LineManager
- FB_FeedProgramManager
- FB_SequenceManager
- FB_AlarmManager

---

# Test Cases

| Stop | Fault | Complete | Emergency | Expected |
|------|-------|----------|-----------|----------|
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

This function evaluates only line stop conditions.

It does not:

- Stop motors directly
- Control blower
- Control dosing
- Move selector
- Manage other lines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckLineReady.md
- FN_CheckLineStartPermission.md
- FN_UpdateLineState.md
- FB_LineManager.md

---

# Revision

Version 1.0