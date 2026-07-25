# IF_Communication

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Version | 3.1 |
| Instance rule | One instance per statically configured channel |

## Channel Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables channel supervision. |
| `uiChannelId` / `uiProfileId` / `uiChannelType` | UINT | Non-zero static approved identities. |
| `xRequiredForControl` | BOOL | Marks control-critical feedback. |
| `xTransportReady` | BOOL | Vendor protocol adapter is configured and available. |
| `udiFreshnessTimeoutMs` | UDINT | Non-zero maximum elapsed time since a valid receive. |
| `uiFailureThreshold` | UINT | Non-zero consecutive protocol/timeout events required to fault. |
| `xRxEvent` / `xTxEvent` | BOOL | One-scan valid activity events. |
| `xProtocolErrorEvent` / `xTimeoutEvent` | BOOL | One-scan error events. |
| `udiReceivedSequence` | UDINT | Validated application/profile sequence. |
| `udiMonotonicTickMs` | UDINT | Wrap-safe timeout timebase. |

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
| `uiResultCode` | UINT | Stable bounded command/configuration reason. |

## Rules

- static connection alone never proves freshness
- repeated ReceiveSequence refreshes transport freshness but changes no accepted application sequence
- simultaneous protocol and timeout inputs count as one failed observation
- counter reset never clears an active condition or fabricates freshness
- failure never directly writes physical outputs
- application payloads never use implicit compiler structure serialization

## Revision History

| Version | Date | Description |
|---|---|---|
| 3.0 | 2026-07-25 | Normalized channel supervision interface. |
| 3.1 | 2026-07-26 | Added explicit channel type, transport readiness, freshness timeout, and failure threshold. |
