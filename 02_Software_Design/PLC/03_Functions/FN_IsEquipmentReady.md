# Function

FN_IsEquipmentReady

---

# Purpose

Determines whether a piece of equipment is ready to start operation.

The function evaluates the minimum operating conditions required before an equipment Function Block is allowed to transition into the STARTING or RUNNING state.

It provides a common readiness check for all equipment used within the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enabled | BOOL | Equipment is enabled |
| CommunicationOK | BOOL | Communication with the device is healthy |
| FaultActive | BOOL | Equipment has an active fault |
| EmergencyStop | BOOL | Emergency Stop is active |
| ReadySignal | BOOL | Equipment reports a ready status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if equipment is ready for operation |

---

# Logic

```text
IF NOT Enabled THEN
    Return := FALSE;

ELSIF EmergencyStop THEN
    Return := FALSE;

ELSIF FaultActive THEN
    Return := FALSE;

ELSIF NOT CommunicationOK THEN
    Return := FALSE;

ELSIF NOT ReadySignal THEN
    Return := FALSE;

ELSE
    Return := TRUE;

END_IF;
```

---

# Rules

- Disabled equipment shall never be considered ready.
- Emergency Stop has the highest priority.
- Equipment with active faults shall not be started.
- Communication must be healthy before operation.
- Equipment shall report a ready signal before startup.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All readiness conditions satisfied | TRUE |
| One or more conditions not satisfied | FALSE |

---

# Typical Usage

- Blower startup validation
- Dosing unit startup
- Selector positioning
- Conveyor enable logic
- System startup sequence
- Automatic job execution

---

# Used By

- FB_Blower
- FB_Dosing
- FB_Selector
- FB_LineManager
- FB_SystemManager
- FB_JobManager

---

# Test Cases

| Enabled | Comm | Fault | E-Stop | Ready | Expected |
|----------|------|-------|--------|-------|----------|
| TRUE | TRUE | FALSE | FALSE | TRUE | TRUE |
| FALSE | TRUE | FALSE | FALSE | TRUE | FALSE |
| TRUE | FALSE | FALSE | FALSE | TRUE | FALSE |
| TRUE | TRUE | TRUE | FALSE | TRUE | FALSE |
| TRUE | TRUE | FALSE | TRUE | TRUE | FALSE |
| TRUE | TRUE | FALSE | FALSE | FALSE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates equipment readiness.

It does not:

- Start equipment
- Reset faults
- Enable outputs
- Send communication commands
- Execute startup sequences
- Change equipment states

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_Blower.md
- FB_Dosing.md
- FB_Selector.md
- FB_SystemManager.md
- FN_IsCommunicationHealthy.md
- TEST_Functions.md

---

# Revision

Version 1.0