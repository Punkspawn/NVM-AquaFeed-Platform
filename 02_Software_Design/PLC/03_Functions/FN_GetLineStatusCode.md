# Function

FN_GetLineStatusCode

---

# Function

FN_GetLineStatusCode

---

# Purpose

Returns the standardized status code of an individual feeding line.

This function converts line operating conditions into a common status code used by HMI and system monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FaultActive | BOOL | Line fault status |
| Running | BOOL | Line running status |
| Ready | BOOL | Line ready status |
| ManualMode | BOOL | Manual operation mode status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Line status code |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | STOP |
| 1 | READY |
| 2 | RUNNING |
| 3 | MANUAL |
| 4 | FAULT |

---

# Logic

```text
IF FaultActive = TRUE THEN

    Return := 4;

ELSIF ManualMode = TRUE THEN

    Return := 3;

ELSIF Running = TRUE THEN

    Return := 2;

ELSIF Ready = TRUE THEN

    Return := 1;

ELSE

    Return := 0;

END_IF;
```

---

# Rules

- Fault condition has the highest priority.
- Manual mode shall be reported separately.
- Running state requires active operation.
- Ready state requires line preparation completed.
- The function shall only evaluate status.
- The function shall not control equipment.
- Other line statuses shall not affect the result.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Fault active | 4 |
| Manual operation | 3 |
| Line running | 2 |
| Line ready | 1 |
| Line stopped | 0 |

---

# Typical Usage

- HMI line status display
- Data logging
- Operator monitoring
- System diagnostics

---

# Used By

- FB_LineManager
- FB_HMIManager
- FB_DataLogger
- FB_ReportManager

---

# Test Cases

| Fault | Running | Ready | Manual | Expected |
|------|---------|-------|--------|----------|
| FALSE | FALSE | FALSE | FALSE | 0 |
| FALSE | FALSE | TRUE | FALSE | 1 |
| FALSE | TRUE | TRUE | FALSE | 2 |
| FALSE | FALSE | TRUE | TRUE | 3 |
| TRUE | TRUE | TRUE | FALSE | 4 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function evaluates only the status of one line.

It does not:

- Start or stop the line
- Control selector
- Control blower
- Control dosing
- Manage other lines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_UpdateLineState.md
- FN_CheckLineReady.md
- FN_CheckLineStartPermission.md
- FB_LineManager.md

---

# Revision

Version 1.0