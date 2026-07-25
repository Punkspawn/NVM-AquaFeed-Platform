# ST_SystemStatus

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Primary writer | `FB_SystemManager` |
| Version | 2.0 |

## Purpose

Publishes one bounded, realtime snapshot of the AquaFeed machine state.

It is read by PLC modules, HMI, Desktop, diagnostics, and Modbus publication. It is not a historical record and contains no user, report, database, or business-domain state.

## Structure

```iecst
TYPE ST_SystemStatus :
STRUCT
    SystemState             : E_SystemState;

    SystemReady             : BOOL;
    SystemRunning           : BOOL;
    SystemPaused            : BOOL;
    SystemStopped           : BOOL;

    AutoMode                : BOOL;
    ManualMode              : BOOL;
    ServiceMode             : BOOL;
    SimulationMode          : BOOL;
    ModeConflict            : BOOL;

    SafetyOK                : BOOL;
    EmergencyStop           : BOOL;
    BlockingFault           : BOOL;
    AlarmActive             : BOOL;

    DesktopCommunicationOK  : BOOL;
    AllRequiredLinesReady   : BOOL;
    AnyLineRunning          : BOOL;

    FeedingActive           : BOOL;
    CurrentLine             : USINT;
    ActiveRecipeId          : UINT;
    CurrentJobId            : UDINT;
END_STRUCT
END_TYPE
```

## Ownership

### Written by FB_SystemManager

- lifecycle state and derived state flags
- operating-mode flags and conflict state
- safety, emergency, blocking-fault, and global alarm summaries
- Desktop communication status
- aggregated line readiness and running status
- bounded current execution references copied from Line Manager snapshots

### Read by

- `FB_LineManager`
- `FB_AlarmManager`
- `FB_CommunicationManager`
- HMI
- AquaFeed Manager
- Diagnostics and Modbus publication

## Invariants

```text
Exactly one SystemState
NOT (AutoMode AND ManualMode)
ModeConflict -> NOT SystemReady
EmergencyStop -> SystemState = SYSTEM_EMERGENCY
BlockingFault -> NOT SystemReady
SystemRunning -> AutoMode
ServiceMode -> NOT SystemRunning
SimulationMode -> physical outputs disabled by approved IO boundary
```

## Removed Legacy Fields

- `CurrentUser`: Desktop-owned identity and session data.
- `SelectorBusy`, `BlowerRunning`, `DosingRunning`: equipment/line detail, not global lifecycle state.
- `CommunicationOK`: replaced by explicit `DesktopCommunicationOK`.
- `ActiveRecipe` and `CurrentJob`: renamed as numeric references `ActiveRecipeId` and `CurrentJobId`.

## Related Documents

- [E_SystemState](E_SystemState.md)
- [FB_SystemManager](../01_Function_Blocks/FB_SystemManager.md)
- [IF_System](../04_Interfaces/IF_System.md)

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | Legacy | Initial mixed platform status. |
| 2.0 | 2026-07-25 | Normalized bounded PLC realtime system snapshot. |
