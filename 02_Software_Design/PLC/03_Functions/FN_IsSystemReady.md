# Function

FN_IsSystemReady

---

# Purpose

Determines whether the AquaFeed system is ready to begin automatic operation.

The function evaluates the global operating conditions required before any feeding line is allowed to execute a job.

It provides a single readiness decision for the System Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| PLCInRun | BOOL | PLC is operating in RUN mode |
| EmergencyStop | BOOL | Emergency Stop is active |
| CommunicationHealthy | BOOL | All required communications are healthy |
| AlarmActive | BOOL | Critical system alarm is active |
| PowerAvailable | BOOL | Required power sources are available |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if the system is ready |

---

# Logic

```text
IF NOT PLCInRun THEN
    Return := FALSE;

ELSIF EmergencyStop THEN
    Return := FALSE;

ELSIF NOT PowerAvailable THEN
    Return := FALSE;

ELSIF NOT CommunicationHealthy THEN
    Return := FALSE;

ELSIF AlarmActive THEN
    Return := FALSE;

ELSE
    Return := TRUE;

END_IF;
```

---

# Rules

- PLC shall be operating in RUN mode.
- Emergency Stop prevents system startup.
- Required communication channels shall be healthy.
- Required power shall be available.
- Active critical alarms prevent automatic operation.
- The function shall execute within a single PLC scan.
- No persistent variables shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All conditions satisfied | TRUE |
| Any required condition missing | FALSE |

---

# Typical Usage

- Automatic startup sequence
- System Manager validation
- HMI status indication
- Startup interlocks
- Job scheduler enable logic
- Safety verification

---

# Used By

- FB_SystemManager
- FB_JobManager
- FB_LineManager
- FB_HMIManager
- FB_ReportManager

---

# Test Cases

| PLC RUN | Power | Comm | Alarm | E-Stop | Expected |
|---------|-------|------|-------|--------|----------|
| TRUE | TRUE | TRUE | FALSE | FALSE | TRUE |
| FALSE | TRUE | TRUE | FALSE | FALSE | FALSE |
| TRUE | FALSE | TRUE | FALSE | FALSE | FALSE |
| TRUE | TRUE | FALSE | FALSE | FALSE | FALSE |
| TRUE | TRUE | TRUE | TRUE | FALSE | FALSE |
| TRUE | TRUE | TRUE | FALSE | TRUE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates the overall readiness of the system.

It does not:

- Start feeding jobs
- Enable equipment
- Reset alarms
- Restore communication
- Change operating modes
- Execute initialization procedures

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FB_SystemManager.md
- FN_IsEquipmentReady.md
- FN_IsCommunicationHealthy.md
- FN_GetSystemMode.md
- TEST_Functions.md

---

# Revision

Version 1.0