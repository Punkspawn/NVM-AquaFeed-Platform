# IF_System

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Producer | `FB_SystemManager` |
| Version | 2.0 |

## Purpose

Defines the single command and status contract for global PLC lifecycle control.

This document replaces the overlapping former `IF_System` and `IF_SystemStatus` specifications.

## Commands Into FB_SystemManager

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables the PLC application lifecycle. |
| `xStart` | BOOL | Requests automatic execution from Ready or resume from Paused. |
| `xStop` | BOOL | Requests controlled stopping. |
| `xPause` | BOOL | Requests pause of active automatic execution. |
| `xReset` | BOOL | Requests reset after the physical fault or emergency condition is removed. |
| `xAutoRequest` | BOOL | Requests Automatic mode. |
| `xManualRequest` | BOOL | Requests Manual mode. |
| `xServiceRequest` | BOOL | Requests Service mode. |
| `xSimulationRequest` | BOOL | Requests Simulation mode. |

## Realtime Conditions Into FB_SystemManager

| Name | Type | Description |
|---|---|---|
| `xEmergencyStop` | BOOL | Active emergency input; highest priority. |
| `xSafetyOK` | BOOL | Aggregated approved safety-chain state. |
| `xBlockingFault` | BOOL | Active fault that prevents readiness or operation. |
| `xAllRequiredLinesReady` | BOOL | Required lines are ready for requested operation. |
| `xAnyLineRunning` | BOOL | At least one line is executing. |
| `xAllLinesStopped` | BOOL | Controlled stop sequence is complete. |
| `xDesktopCommunicationOK` | BOOL | Desktop link status; diagnostic only, not a safety interlock. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `stSystemStatus` | ST_SystemStatus | Authoritative bounded realtime snapshot. |
| `xSystemReady` | BOOL | Convenience output matching `stSystemStatus.SystemReady`. |
| `xLineEnable` | BOOL | Global permission for line execution. |
| `xModeConflict` | BOOL | More than one operating mode was requested. |
| `xResetAccepted` | BOOL | Reset request passed all acceptance rules. |

## Contract Rules

- Emergency overrides every command.
- Active safety or blocking faults prevent Ready and Running.
- Exactly one operating mode may be selected.
- Service Mode prevents automatic feeding.
- Desktop communication loss updates status and alarms but does not stop a healthy PLC-controlled feeding cycle.
- Consumers shall read `ST_SystemStatus` instead of maintaining independent global status flags.
- Only `FB_SystemManager` writes global lifecycle and mode fields.

## Related Documents

- [FB_SystemManager](../01_Function_Blocks/FB_SystemManager.md)
- [ST_SystemStatus](../02_Structures/ST_SystemStatus.md)
- [E_SystemState](../02_Structures/E_SystemState.md)

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | Legacy | Initial command-only interface. |
| 2.0 | 2026-07-25 | Consolidated command and status contract. |
