# Function

FN_UpdateLineState

---

# Function

FN_UpdateLineState

---

# Purpose

Updates the current operating state of an individual feeding line according to its operating conditions.

This function provides a standard state evaluation method for line control and HMI status display.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentState | INT | Current line state |
| StartCommand | BOOL | Line start command |
| StopCommand | BOOL | Line stop command |
| LineReady | BOOL | Line ready status |
| RunningFeedback | BOOL | Line running feedback |
| FaultActive | BOOL | Active fault status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | New line state |

---

# State Codes

| Value | Description |
|------:|-------------|
| 0 | STOP |
| 1 | READY |
| 2 | STARTING |
| 3 | RUNNING |
| 4 | STOPPING |
| 5 | FAULT |

---

# Logic

```text
IF FaultActive = TRUE THEN

    Return := 5;

ELSIF StopCommand = TRUE THEN

    Return := 4;

ELSIF RunningFeedback = TRUE THEN

    Return := 3;

ELSIF StartCommand = TRUE
AND LineReady = TRUE THEN

    Return := 2;

ELSIF LineReady = TRUE THEN

    Return := 1;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Each line shall maintain its own state.
- Other line states shall not affect the result.
- Fault state has the highest priority.
- Running state requires running feedback.
- Ready state requires equipment readiness.
- The function shall only evaluate state.
- The function shall not control equipment outputs.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Fault active | 5 |
| Stopping command active | 4 |
| Equipment running | 3 |
| Start sequence active | 2 |
| Ready for operation | 1 |
| Idle state | 0 |

---

# Typical Usage

- Line status management
- HMI status display
- Sequence control
- Alarm and diagnostic systems

---

# Used By

- FB_LineManager
- FB_HMIManager
- FB_ReportManager

---

# Test Cases

| Start | Stop | Ready | Running | Fault | Expected |
|------|------|-------|---------|-------|----------|
| FALSE | FALSE | FALSE | FALSE | FALSE | 0 |
| FALSE | FALSE | TRUE | FALSE | FALSE | 1 |
| TRUE | FALSE | TRUE | FALSE | FALSE | 2 |
| TRUE | FALSE | TRUE | TRUE | FALSE | 3 |
| FALSE | TRUE | TRUE | TRUE | FALSE | 4 |
| TRUE | FALSE | TRUE | TRUE | TRUE | 5 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only the operating state of one line.

It does not:

- Start or stop equipment
- Control blower
- Control dosing
- Move selector
- Manage other lines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckLineReady.md
- FN_CheckLineStartPermission.md
- FN_GetLineStatus.md
- FB_LineManager.md

---

# Revision

Version 1.0