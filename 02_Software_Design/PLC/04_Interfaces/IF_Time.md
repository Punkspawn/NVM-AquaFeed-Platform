# IF_Time

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / Desktop time boundary |
| Version | 1.0 |

## Desktop to PLC

| Name | Type | Description |
|---|---|---|
| `dtObservedUtc` | DT | Validated UTC observation. |
| `udiSyncSequence` | UDINT | Idempotent synchronization sequence. |
| `xSyncRequest` | BOOL | Requests observed-time update. |

## PLC Internal Input

| Name | Type | Description |
|---|---|---|
| `udiRuntimeTickMs` | UDINT | PLC monotonic/runtime millisecond source. |
| `xRuntimeTickHealthy` | BOOL | Source health. |

## PLC to Consumers

| Name | Type | Description |
|---|---|---|
| `stTime` | ST_TimeService | Current time-service snapshot. |
| `xSyncAccepted` / `xSyncRejected` | BOOL | One-scan result events. |
| `uiResultCode` | UINT | Bounded reason code. |

## Rules

Replayed synchronization requests are idempotent. Rejected or missing wall-clock synchronization cannot stop monotonic control timing.
