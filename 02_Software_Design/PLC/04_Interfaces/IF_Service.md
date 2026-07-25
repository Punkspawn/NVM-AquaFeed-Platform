# IF_Service

---

# Purpose

Defines the standard software interface for Service Mode.

Service Mode allows maintenance personnel to safely operate and test individual machine components without executing the automatic feeding sequence.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables Service Mode. |
| LoginGranted | BOOL | Service authorization confirmed. |
| ManualControl | BOOL | Enables manual component control. |
| Reset | BOOL | Clears service faults. |
| Exit | BOOL | Exits Service Mode. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Active | BOOL | Service Mode is active. |
| Authorized | BOOL | User has service privileges. |
| ManualEnabled | BOOL | Manual controls are enabled. |
| AutomaticLocked | BOOL | Automatic operation is locked. |
| Fault | BOOL | Service Mode fault detected. |
| AlarmCode | UINT | Active service alarm code. |

---

# Available Manual Operations

- Selector Jog Left
- Selector Jog Right
- Selector Home
- Blower Start / Stop
- Blower Speed Control
- Dosing Start / Stop
- Dosing Speed Control
- Digital Output Test
- Analog Output Test

---

# State Flow

```text
Normal Operation
        │
Service Login
        │
Service Mode
        │
Manual Control
        │
Exit
        │
Normal Operation
```

Fault sequence

```text
Service Mode
      │
Fault
      │
Reset
      │
Service Mode
```

---

# Rules

- Service Mode shall only be accessible to authorized users.
- Automatic production shall be disabled while Service Mode is active.
- Manual commands shall affect only the selected component.
- All safety circuits shall remain active during Service Mode.
- Exiting Service Mode shall stop all manually controlled outputs.
- `AlarmCode` shall be zero when no service alarm is active.

---

# Used By

- FB_ServiceManager
- FB_SystemManager
- FB_IOManager
- FB_Selector
- FB_Blower
- FB_Dosing
- HMI
- AquaFeed Manager
- Service Software