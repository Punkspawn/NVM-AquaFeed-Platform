# Function

FN_IsValidTransition

---

# Purpose

Determines whether a requested state transition is permitted according to the defined state machine rules.

This function provides a centralized validation mechanism for state changes, ensuring that equipment and process modules only transition between valid operating states.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CurrentState | UINT | Current operating state |
| RequestedState | UINT | Requested next state |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the transition is allowed |

---

# Logic

```text
CASE CurrentState OF

STATE_IDLE:
    Return :=
        (RequestedState = STATE_STARTING);

STATE_STARTING:
    Return :=
        (RequestedState = STATE_RUNNING)
        OR
        (RequestedState = STATE_FAULT);

STATE_RUNNING:
    Return :=
        (RequestedState = STATE_STOPPING)
        OR
        (RequestedState = STATE_FAULT);

STATE_STOPPING:
    Return :=
        (RequestedState = STATE_IDLE);

STATE_FAULT:
    Return :=
        (RequestedState = STATE_RESET);

ELSE
    Return := FALSE;

END_CASE;
```

---

# Rules

- Only predefined transitions shall be accepted.
- Undefined states shall return `FALSE`.
- The function shall not modify state variables.
- The function shall execute within a single PLC scan.
- No persistent variables shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid transition | TRUE |
| Invalid transition | FALSE |

---

# Typical Usage

- Equipment state machines
- Feeding sequence control
- Blower control
- Dosing control
- System startup logic
- Fault recovery validation

---

# Used By

- FB_SystemManager
- FB_LineManager
- FB_Blower
- FB_Dosing
- FB_Selector
- FB_JobManager

---

# Test Cases

| Current State | Requested State | Expected |
|---------------|-----------------|----------|
| IDLE | STARTING | TRUE |
| IDLE | RUNNING | FALSE |
| RUNNING | STOPPING | TRUE |
| RUNNING | IDLE | FALSE |
| FAULT | RESET | TRUE |
| FAULT | RUNNING | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only validates whether a state transition is permitted.

It does not:

- Perform the transition
- Change equipment states
- Execute startup or shutdown logic
- Generate alarms
- Log state changes

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_SystemManager.md
- FB_LineManager.md
- SYSTEM_ARCHITECTURE.md
- TEST_Functions.md

---

# Revision

Version 1.0