# IF_Communication

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Version | 3.0 |
| Instance rule | One instance per statically configured channel |

## Channel Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables supervision/polling. |
| `uiChannelId` / `uiProfileId` | UINT | Static approved identities. |
| `xRequiredForControl` | BOOL | Marks control-critical feedback channel. |
| `xRxEvent` / `xTxEvent` | BOOL | One-scan valid activity events. |
| `xProtocolErrorEvent` / `xTimeoutEvent` | BOOL | One-scan error events. |
| `udiReceivedSequence` | UDINT | Validated application/profile sequence. |
| `udiMonotonicTickMs` | UDINT | Timeout timebase. |

## Service Command

| Name | Type | Description |
|---|---|---|
| `xResetCountersRequest` | BOOL | Requests diagnostic counter reset. |
| `udiResetSequence` | UDINT | Idempotent reset sequence. |
| `xServicePermission` | BOOL | Local approved permission. |

## Output

| Name | Type | Description |
|---|---|---|
| `stChannel` | ST_CommunicationChannel | Current bounded channel state. |
| `xNewFaultEvent` / `xRecoveryEvent` | BOOL | One-scan lifecycle events. |
| `uiResultCode` | UINT | Stable bounded reason. |

## Profiles

- Desktop/HMI Modbus TCP: client/master outside PLC; PLC server/slave; heartbeat freshness; versioned flat map.
- VFD Modbus RTU: PLC sole master; bounded poll, timeout, and retry; separate device profile per approved model.

## Rules

- static connection alone never proves freshness
- channel counter reset does not clear an active physical/protocol condition
- failure never directly writes physical outputs
- Desktop loss blocks new remote transfers; healthy accepted PLC execution continues
- VFD loss is acted on by the owning equipment contract
- application payloads never use implicit compiler structure serialization
