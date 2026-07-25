# IF_Alarm

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 2.0 |

## Purpose

Defines the standard condition-reporting and lifecycle-command boundary between alarm source modules, AlarmManager, and Desktop/HMI.

## Source Module to AlarmManager

| Name | Type | Description |
|---|---|---|
| `xConditionActive` | BOOL | Physical or logical alarm condition owned by the source module. |
| `uiAlarmCode` | UINT | Catalog code. |
| `eSource` | E_AlarmSource | Realtime PLC source. |
| `eSeverity` | E_AlarmSeverity | Catalog severity; runtime override prohibited. |
| `usiLineId` | USINT | Zero for global/system alarms. |
| `uiDeviceId` | UINT | Zero when not device-specific. |
| `xResetRequired` | BOOL | Catalog manual-reset policy. |
| `xBlocking` | BOOL | Catalog operational blocking policy. |

## Desktop/HMI to AlarmManager

| Name | Type | Description |
|---|---|---|
| `xAcknowledgeRequest` | BOOL | Requests acknowledgement of one active alarm key. |
| `xResetRequest` | BOOL | Requests reset after source condition is inactive. |
| `udiCommandSequence` | UDINT | Idempotent command sequence. |
| `uiTargetAlarmCode` | UINT | Target code. |
| `eTargetSource` | E_AlarmSource | Target source. |
| `usiTargetLineId` | USINT | Target line. |
| `uiTargetDeviceId` | UINT | Target device. |

## AlarmManager Outputs

| Name | Type | Description |
|---|---|---|
| `xAnyAlarmActive` | BOOL | At least one active lifecycle record exists. |
| `xAnyBlockingAlarm` | BOOL | At least one blocking alarm exists. |
| `xAnyCriticalAlarm` | BOOL | Critical or Emergency alarm exists. |
| `xAnyEmergencyAlarm` | BOOL | Emergency alarm exists. |
| `eHighestSeverity` | E_AlarmSeverity | Highest current severity. |
| `uiActiveAlarmCount` | UINT | Bounded active count. |
| `xTableOverflow` | BOOL | Active table capacity was exceeded. |
| `xEventBufferOverflow` | BOOL | Unsynchronized event capacity was exceeded. |
| `xCommandAccepted` | BOOL | One-scan command acknowledgement. |
| `xCommandRejected` | BOOL | One-scan command rejection. |
| `uiCommandResultCode` | UINT | Bounded rejection/acceptance reason. |

## Rules

- Acknowledge does not clear ConditionActive.
- Reset is rejected while ConditionActive is true.
- Multiple sources may report simultaneously.
- Same active key maps to one active record.
- Information severity cannot be Blocking.
- AlarmManager outputs summaries only; machine modules decide operational transitions.
- Command sequences are idempotent.
