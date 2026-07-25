# Legacy Global System Status Interface

> **Status:** Legacy / Superseded  
> **Former path:** `02_Software_Design/PLC/04_Interfaces/IF_SystemStatus.md`  
> **Reason archived:** Its status outputs and lifecycle rules overlapped with `IF_System.md`.  
> **Replacement:** `02_Software_Design/PLC/04_Interfaces/IF_System.md`

---

# IF_SystemStatus

---

# Purpose

Defines the standard interface for the global system status.

This interface provides a single source of truth for the current operating state of the machine. Every PLC module, HMI screen and AquaFeed Manager component shall reference this interface instead of maintaining independent status variables.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables status monitoring. |
| SystemStatus | ST_SystemStatus | Current global system status structure. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | System is ready to start. |
| Running | BOOL | Automatic production is active. |
| Manual | BOOL | Manual mode is active. |
| Automatic | BOOL | Automatic mode is active. |
| Paused | BOOL | Production is paused. |
| Stopped | BOOL | System is stopped. |
| Fault | BOOL | One or more faults are active. |
| Emergency | BOOL | Emergency stop is active. |
| ServiceMode | BOOL | Service mode is enabled. |
| AlarmActive | BOOL | At least one alarm is active. |

---

# State Flow

```text
Power On
    │
Initialization
    │
Ready
    │
Start
    │
Running
```

Mode selection

```text
Ready
  │
Manual / Automatic
  │
Selected Mode
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

---

# Rules

- Only one operating mode shall be active at a time.
- Emergency state has the highest priority.
- Fault state overrides Ready and Running states.
- Service Mode shall prevent automatic production.
- Global status shall be updated once every PLC scan.

---

# Used By

- FB_SystemManager
- FB_FeedingControlManager
- FB_LineManager
- FB_RuntimeManager
- FB_AlarmManager
- FB_MaintenanceManager
- HMI
- AquaFeed Manager
- Reporting System