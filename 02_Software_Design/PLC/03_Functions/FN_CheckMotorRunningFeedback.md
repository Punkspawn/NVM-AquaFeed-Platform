# Function

FN_CheckMotorRunningFeedback

---

# Function

FN_CheckMotorRunningFeedback

---

# Purpose

Checks whether the motor running feedback signal matches the requested motor command state.

This function is used to detect missing feedback conditions, contactor problems, drive communication failures, and motor operation faults.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RunCommand | BOOL | Motor run command from PLC |
| RunningFeedback | BOOL | Motor running feedback signal |
| TimeoutActive | BOOL | Feedback timeout condition |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | INT | Motor feedback status |

---

# Status Codes

| Value | Description |
|------:|-------------|
| 0 | Normal operation |
| 1 | Motor should be running but feedback is missing |
| 2 | Motor stopped correctly |
| 3 | Unexpected feedback while motor is stopped |

---

# Logic

```text
IF TimeoutActive THEN

    Return := 1;

ELSIF RunCommand = TRUE THEN

    IF RunningFeedback = TRUE THEN

        Return := 0;

    ELSE

        Return := 1;

    END_IF;

ELSE

    IF RunningFeedback = TRUE THEN

        Return := 3;

    ELSE

        Return := 2;

    END_IF;

END_IF;
```

---

# Rules

- RunCommand represents the requested motor state.
- RunningFeedback represents the actual motor state.
- Timeout condition has priority over normal feedback evaluation.
- Unexpected feedback shall be reported.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Command ON + Feedback ON | 0 |
| Command ON + Feedback OFF | 1 |
| Command OFF + Feedback OFF | 2 |
| Command OFF + Feedback ON | 3 |
| Timeout | 1 |

---

# Typical Usage

- Blower motor monitoring
- Pump motor monitoring
- Drive feedback verification
- Contactor diagnostics
- Equipment health monitoring

---

# Used By

- FB_Blower
- FB_LineManager
- FB_DiagnosticsManager
- FB_AlarmManager

---

# Test Cases

| Command | Feedback | Timeout | Expected |
|---------|----------|---------|----------|
| FALSE | FALSE | FALSE | 2 |
| TRUE | TRUE | FALSE | 0 |
| TRUE | FALSE | FALSE | 1 |
| FALSE | TRUE | FALSE | 3 |
| TRUE | FALSE | TRUE | 1 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only motor command and feedback consistency.

It does not:

- Start the motor
- Stop the motor
- Control the inverter
- Reset drive faults
- Measure motor current
- Perform safety functions

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsEquipmentReady.md
- FN_IsTimeout.md
- FN_IsCommunicationHealthy.md
- FB_Blower.md
- FB_DiagnosticsManager.md

---

# Revision

Version 1.0