# E_SystemState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 1.0 |

## Purpose

Defines the single primary lifecycle state published by `FB_SystemManager`.

## Definition

```iecst
TYPE E_SystemState :
(
    SYSTEM_OFF,
    SYSTEM_INITIALIZING,
    SYSTEM_READY,
    SYSTEM_RUNNING,
    SYSTEM_PAUSED,
    SYSTEM_STOPPING,
    SYSTEM_FAULT,
    SYSTEM_EMERGENCY
);
END_TYPE
```

## Rules

- Exactly one state is active.
- Emergency has the highest priority.
- Fault has priority over production states.
- Equipment and line states do not modify this enumeration directly.
- Only `FB_SystemManager` transitions the global state.

## Related Documents

- [FB_SystemManager](../01_Function_Blocks/FB_SystemManager.md)
- [ST_SystemStatus](ST_SystemStatus.md)
- [IF_System](../04_Interfaces/IF_System.md)
