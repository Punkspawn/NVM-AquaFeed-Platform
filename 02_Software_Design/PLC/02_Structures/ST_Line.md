# ST_Line

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Primary writer | `FB_LineManager` |
| Instance rule | One instance per physical feeding line |
| Version | 2.1 |

## Purpose

Publishes one bounded realtime snapshot of a feeding line. Quantities use integer engineering units matching the equipment contracts.

## Structure

```iecst
TYPE ST_Line :
STRUCT
    usiLineId                 : USINT;
    eLineState                : E_LineState;

    xEnabled                  : BOOL;
    xReady                    : BOOL;
    xBusy                     : BOOL;
    xRunning                  : BOOL;
    xPaused                   : BOOL;
    xCompleted                : BOOL;
    xFault                    : BOOL;
    xEmergency                : BOOL;

    xAutoMode                 : BOOL;
    xManualMode               : BOOL;
    xServiceMode              : BOOL;
    xSimulationMode           : BOOL;

    xActiveJobValid           : BOOL;
    udiActiveJobId            : UDINT;
    uiActiveRecipeId          : UINT;

    uiTargetSelectorOutlet    : UINT;
    uiCurrentSelectorOutlet   : UINT;
    xSelectorAtTarget         : BOOL;

    udiTargetFeedCentiKg      : UDINT;
    udiDeliveredFeedCentiKg   : UDINT;
    udiRemainingFeedCentiKg   : UDINT;
    uiProgressPermille        : UINT;

    udiElapsedTimeSec         : UDINT;
    udiRemainingTimeSec       : UDINT;

    xBlowerRunning            : BOOL;
    xDosing1Running           : BOOL;
    xDosing2Running           : BOOL;

    uiActiveAlarmId           : UINT;
END_STRUCT;
END_TYPE
```

## Field Rules

- `xCompleted` is a one-scan event unless the communication contract defines a separate latched handshake.
- active job and recipe IDs are references, not master records.
- feed quantities use 0.01 kg per count and never wrap or become negative.
- `uiProgressPermille` is clamped to 0–1000.
- delivered feed changes only from validated Dosing increments.
- `uiActiveAlarmId` is zero when no line alarm is active.
- Simulation Mode shall not energize physical outputs without an approved IO simulation boundary.

## Invariants

```text
Dosing1Running OR Dosing2Running -> BlowerRunning
Dosing1Running OR Dosing2Running -> SelectorAtTarget
Running -> ActiveJobValid
Completed -> eLineState = LINE_COMPLETE
Fault -> NOT Ready
Emergency -> eLineState = LINE_EMERGENCY
DeliveredFeedCentiKg <= TargetFeedCentiKg + approved tolerance
RemainingFeedCentiKg >= 0
0 <= ProgressPermille <= 1000
```

## Related Documents

- [E_LineState](E_LineState.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [IF_Line](../04_Interfaces/IF_Line.md)
