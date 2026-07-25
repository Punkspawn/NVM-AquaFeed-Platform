# ST_Line

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Primary writer | `FB_LineManager` |
| Instance rule | One instance per physical feeding line |
| Version | 2.0 |

## Purpose

Publishes one bounded realtime snapshot of a feeding line.

It contains current execution and equipment-summary data only. Job queues, history, user identity, cage records, Smart Farm data, reports, and long-term statistics remain Desktop-owned.

## Structure

```iecst
TYPE ST_Line :
STRUCT
    LineId                   : USINT;
    LineState                : E_LineState;

    Enabled                  : BOOL;
    Ready                    : BOOL;
    Busy                     : BOOL;
    Running                  : BOOL;
    Paused                   : BOOL;
    Completed                : BOOL;
    Fault                    : BOOL;
    Emergency                : BOOL;

    AutoMode                 : BOOL;
    ManualMode               : BOOL;
    ServiceMode              : BOOL;
    SimulationMode           : BOOL;

    ActiveJobValid           : BOOL;
    ActiveJobId              : UDINT;
    ActiveRecipeId           : UINT;

    TargetSelectorPosition   : USINT;
    CurrentSelectorPosition  : USINT;
    SelectorAtTarget         : BOOL;

    TargetFeedKg             : REAL;
    DeliveredFeedKg          : REAL;
    RemainingFeedKg          : REAL;
    ProgressPercent          : REAL;

    ElapsedTimeSec           : UDINT;
    RemainingTimeSec         : UDINT;

    BlowerRunning            : BOOL;
    Dosing1Running           : BOOL;
    Dosing2Running           : BOOL;

    ActiveAlarmId            : UINT;
END_STRUCT
END_TYPE
```

## Ownership

Only the assigned `FB_LineManager` writes its `ST_Line` instance.

Equipment blocks supply feedback; LineManager copies the bounded summary. SystemManager, HMI, Desktop, diagnostics, alarms, and Modbus publication read the snapshot.

## Field Rules

- `Completed` is a one-scan event unless the communication contract defines a separate latched handshake.
- `ActiveJobId` and `ActiveRecipeId` are references, not master records.
- `RemainingFeedKg` shall never be negative.
- `ProgressPercent` is clamped from 0 to 100.
- `DeliveredFeedKg` changes only from validated Dosing feedback.
- `ActiveAlarmId` is zero when no line alarm is active.
- Simulation Mode shall not energize physical outputs without an approved IO simulation boundary.

## Invariants

```text
Dosing1Running OR Dosing2Running -> BlowerRunning
Dosing1Running OR Dosing2Running -> SelectorAtTarget
Running -> ActiveJobValid
Completed -> LineState = LINE_COMPLETE
Fault -> NOT Ready
Emergency -> LineState = LINE_EMERGENCY
RemainingFeedKg >= 0
0 <= ProgressPercent <= 100
```

## Removed or Renamed Legacy Fields

- `Selected`: HMI selection state, not PLC line runtime.
- `CurrentRecipe` -> `ActiveRecipeId`.
- `CurrentJob` -> `ActiveJobId` with `UDINT`.
- `FeedAmountKg` -> `TargetFeedKg`.
- `FeededAmountKg` -> grammatically correct `DeliveredFeedKg`.
- `FeedingTimeSec` -> `ElapsedTimeSec`.
- `SelectorPosition` split into target, current, and verified-at-target fields.
- `DosingRunning` split for two supported Dosing units.
- `LastAlarm` -> current bounded `ActiveAlarmId`.

## Related Documents

- [E_LineState](E_LineState.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [IF_Line](../04_Interfaces/IF_Line.md)

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | Legacy | Initial mixed line status. |
| 2.0 | 2026-07-25 | Normalized bounded realtime line snapshot. |
