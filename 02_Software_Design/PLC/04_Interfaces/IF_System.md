# IF_System

---

# Purpose

Defines the standard software interface for the overall machine status.

This interface provides a common system status that is shared by all PLC modules, the HMI and AquaFeed Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the system. |
| Start | BOOL | Starts automatic operation. |
| Stop | BOOL | Stops automatic operation. |
| Pause | BOOL | Pauses the current operation. |
| Reset | BOOL | Resets system faults and returns to Ready state. |
| EmergencyStop | BOOL | Emergency stop input. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | System is ready for operation. |
| Running | BOOL | Automatic operation is active. |
| Paused | BOOL | Operation is paused. |
| Stopped | BOOL | System is stopped. |
| Fault | BOOL | System fault detected. |
| Emergency | BOOL | Emergency stop is active. |
| AlarmCode | UINT | Active system alarm code. |

---

# State Flow

```text
Power On
    │
Enable
    │
Ready
    │
Start
    │
Running
```

Pause sequence

```text
Running
    │
Pause
    │
Paused
    │
Start
    │
Running
```

Stop sequence

```text
Running
    │
Stop
    │
Stopped
    │
Ready
```

Emergency sequence

```text
Any State
    │
Emergency Stop
    │
Emergency
    │
Reset
    │
Ready
```

Fault sequence

```text
Any State
    │
Fault
    │
Reset
    │
Ready
```

---

# Rules

- `EmergencyStop` shall have the highest priority.
- Automatic operation shall only start when `Ready = TRUE`.
- `Reset` shall only clear faults after the fault condition has been removed.
- Only one primary operating state (`Ready`, `Running`, `Paused`, `Stopped`, `Fault`, `Emergency`) shall be active at a time.
- `AlarmCode` shall be zero when no system alarm is active.

---

# Used By

- FB_SystemManager
- FB_FeedingControlManager
- FB_LineManager
- FB_RuntimeManager
- FB_AlarmManager
- HMI
- AquaFeed Manager