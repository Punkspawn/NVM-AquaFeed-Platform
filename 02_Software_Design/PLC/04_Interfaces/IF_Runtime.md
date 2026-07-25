# IF_Runtime

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 2.0 |

## Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables accounting. |
| `xOneSecondTick` | BOOL | Validated monotonic one-scan tick. |
| `eSystemState` | E_SystemState | Current authoritative global state. |
| `xJobCompleted` | BOOL | One-scan validated completion event. |
| `udiDeliveredFeedCentiKg` | UDINT | Validated feed increment for completed transaction. |
| `xMachineStartEvent` | BOOL | One-scan start event. |
| `xEmergencyEvent` | BOOL | One-scan emergency activation event. |
| `xAlarmOccurrenceEvent` | BOOL | One-scan new alarm occurrence event. |

## Output

| Name | Type | Description |
|---|---|---|
| `stRuntime` | ST_Runtime | Authoritative retentive lifetime counters. |
| `xCounterSaturated` | BOOL | At least one counter reached maximum. |
| `uiDiagnosticCode` | UINT | Bounded accounting diagnostic. |

## Rules

- OneSecondTick must be monotonic and processed once.
- Replayed event sequence is not counted twice.
- Exactly one state bucket accumulates per accepted tick.
- Desktop wall-clock time is not used for runtime accumulation.
- No normal reset command exists.
