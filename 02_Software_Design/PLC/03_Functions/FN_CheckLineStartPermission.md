# Function

FN_CheckLineStartPermission

---

# Function

FN_CheckLineStartPermission

---

# Purpose

Checks whether an individual feeding line is allowed to start operation.

This function evaluates the start conditions of a single line before beginning an automatic feeding sequence.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| StartCommand | BOOL | Operator or system start command |
| AutoModeActive | BOOL | Automatic operation mode status |
| LineReady | BOOL | Line ready status |
| FaultActive | BOOL | Active fault status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Start permission status |

---

# Logic

```text
IF StartCommand = FALSE THEN

    Return := FALSE;

ELSIF AutoModeActive = FALSE THEN

    Return := FALSE;

ELSIF LineReady = FALSE THEN

    Return := FALSE;

ELSIF FaultActive = TRUE THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- Start permission shall only be evaluated for the current line.
- Other line states shall not affect this result.
- Automatic mode shall be active for automatic start.
- The line shall be ready before starting operation.
- Fault condition shall prevent start permission.
- The function shall only evaluate permission.
- The function shall not start equipment outputs.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All start conditions satisfied | TRUE |
| Missing start command | FALSE |
| Manual mode | FALSE |
| Line not ready | FALSE |
| Fault active | FALSE |

---

# Typical Usage

- Automatic feeding start sequence
- Line control logic
- Operator start validation
- Sequence management

---

# Used By

- FB_LineManager
- FB_FeedProgramManager
- FB_SequenceManager

---

# Test Cases

| Start | Auto | Ready | Fault | Expected |
|------|------|-------|-------|----------|
| FALSE | TRUE | TRUE | FALSE | FALSE |
| TRUE | FALSE | TRUE | FALSE | FALSE |
| TRUE | TRUE | FALSE | FALSE | FALSE |
| TRUE | TRUE | TRUE | TRUE | FALSE |
| TRUE | TRUE | TRUE | FALSE | TRUE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only line start permission.

It does not:

- Start blower
- Start dosing
- Move selector
- Manage other lines
- Execute feeding sequence

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckLineReady.md
- FN_GetLineStatus.md
- FN_IsLineAvailable.md
- FB_LineManager.md

---

# Revision

Version 1.0