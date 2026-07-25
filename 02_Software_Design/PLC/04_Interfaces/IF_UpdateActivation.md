# IF_UpdateActivation

| Field | Value |
|---|---|
| Status | Authoritative boundary contract |
| Owner | PLC Runtime / Integration Edge |
| Version | 1.0 |

## Integration/Edge to PLC

| Name | Type | Description |
|---|---|---|
| `udiRequestSequence` | UDINT | Idempotent activation request sequence. |
| `udiPackageId` | UDINT | Approved package identity reference. |
| `udiTargetId` | UDINT | Target device/controller identity. |
| `udiVersionCode` | UDINT | Monotonic approved version code. |
| `xActivationRequest` | BOOL | Requests entry to the approved activation state. |

## PLC Conditions

| Name | Type | Description |
|---|---|---|
| `xServicePermission` | BOOL | Local approved service/commissioning mode. |
| `xEquipmentStopped` | BOOL | Controlled equipment is stopped. |
| `xSafetyOK` | BOOL | Required safety chain is healthy. |
| `xActiveJob` | BOOL | An execution is active; activation is rejected when true. |

## PLC to Integration/Edge

| Name | Type | Description |
|---|---|---|
| `xRequestAccepted` | BOOL | One-scan acceptance event. |
| `xRequestRejected` | BOOL | One-scan rejection event. |
| `uiResultCode` | UINT | Bounded rejection/result reason. |
| `udiLastAcceptedSequence` | UDINT | Replay protection. |
| `xActivationWindowOpen` | BOOL | Safe activation conditions currently hold. |

## Rules

- PLC does not download, store, verify, distribute, or install packages.
- Integration/Edge proves package signature and compatibility before requesting activation.
- PLC independently validates local mode, stopped state, safety, active job, identity, version, and sequence.
- Replayed requests are idempotent.
- Package or activation failure cannot silently start equipment.
