# IF_MaintenanceCounter

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / Desktop service boundary |
| Version | 1.0 |

## Desktop to PLC

| Name | Type | Description |
|---|---|---|
| `udiResetSequence` | UDINT | Idempotent service-reset sequence. |
| `uiTargetDeviceId` | UINT | Target device/scope. |
| `udiServiceIntervalSec` | UDINT | Approved runtime interval. |
| `udiGraceIntervalSec` | UDINT | Approved overdue grace interval. |
| `xResetRequest` | BOOL | Requests baseline update after service. |

## PLC Conditions

| Name | Type | Description |
|---|---|---|
| `xServicePermission` | BOOL | Approved service/commissioning mode. |
| `xEquipmentStopped` | BOOL | Equipment confirmed stopped. |
| `xSafetyOK` | BOOL | Required safety condition healthy. |

## PLC to Desktop

| Name | Type | Description |
|---|---|---|
| `stCounter` | ST_MaintenanceCounter | Bounded realtime maintenance snapshot. |
| `xResetAccepted` | BOOL | One-scan acceptance event. |
| `xResetRejected` | BOOL | One-scan rejection event. |
| `uiResultCode` | UINT | Bounded reason code. |

## Rules

- authorization and user attribution are Desktop responsibilities
- PLC independently enforces service mode, stopped state, identity, sequence, and bounds
- reset changes baseline, not lifetime runtime
- replayed sequence is idempotent
