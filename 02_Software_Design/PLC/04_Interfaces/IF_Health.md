# IF_Health

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.0 |

## Inputs

Current bounded status from Safety, IO, Diagnostics, required Communication channels, Selector, Blower, Dosing, System, and active Line.

## Outputs

| Name | Type | Description |
|---|---|---|
| `stHealth` | ST_HealthStatus | Current readiness/degradation snapshot. |
| `xTransitionEvent` | BOOL | One-scan material status transition. |
| `uiTransitionCode` | UINT | Stable reason code. |

## Rules

- no generic reset or acknowledgement command
- no direct output command
- new-job readiness and current-job continuation are separate decisions
- missing Desktop heartbeat affects new-job readiness, not an otherwise healthy accepted job
