# E_LineState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 1.0 |

## Purpose

Defines the single primary realtime state of one `FB_LineManager` instance.

## Definition

```iecst
TYPE E_LineState :
(
    LINE_OFF,
    LINE_INITIALIZING,
    LINE_READY,
    LINE_LOAD_JOB,
    LINE_VALIDATE,
    LINE_MOVE_SELECTOR,
    LINE_WAIT_SELECTOR,
    LINE_START_BLOWER,
    LINE_WAIT_BLOWER,
    LINE_PRE_RUN,
    LINE_START_DOSING,
    LINE_FEEDING,
    LINE_STOP_DOSING,
    LINE_POST_RUN,
    LINE_COMPLETE,
    LINE_PAUSED,
    LINE_STOPPING,
    LINE_RECOVERY,
    LINE_FAULT,
    LINE_EMERGENCY,
    LINE_SERVICE
);
END_TYPE
```

## Transition Rules

- Exactly one line state is active per instance.
- Emergency has highest priority.
- Fault and safety conditions override forward production transitions.
- Dosing states are reachable only after Selector and Blower verification.
- Resume and Recovery re-enter through Selector and Blower verification.
- Complete is followed by Ready after the completion handshake is published.
- Undefined transitions are rejected.

## Related Documents

- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [ST_Line](ST_Line.md)
- [IF_Line](../04_Interfaces/IF_Line.md)
