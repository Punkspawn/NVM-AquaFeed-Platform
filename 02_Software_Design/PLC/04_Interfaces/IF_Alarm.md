# IF_Alarm

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 2.1 |

## Purpose

Defines the standard condition-reporting and lifecycle-command boundary between alarm source modules, AlarmManager, and Desktop/HMI.

## Source Modules to AlarmManager

| Name | Type | Description |
|---|---|---|
| `astConditions` | ARRAY[0..31] OF ST_AlarmCondition | Fixed current-condition input image; unused entries have Valid false. |

The aggregation caller presents at most 32 valid condition updates per scan. A previously reported condition is removed only by a matching valid entry with ConditionActive false; an omitted/invalid entry does not clear it.

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
| `udiAcceptedEventSequence` | UDINT | Exact oldest event sequence persisted by Desktop; zero means no acknowledgement. |

## AlarmManager Outputs

| Name | Type | Description |
|---|---|---|
| `astActiveAlarms` | ARRAY[0..63] OF ST_Alarm | Fixed active-lifecycle table; inactive entries are unused. |
| `stPendingEvent` | ST_AlarmEvent | Oldest unsynchronized event. |
| `xPendingEventValid` | BOOL | Pending event output is valid. |
| `uiPendingEventCount` | UINT | Number of retained unsynchronized events, maximum 128. |
| `xAnyAlarmActive` | BOOL | At least one active lifecycle record exists. |
| `xAnyBlockingAlarm` | BOOL | At least one blocking alarm exists. |
| `xAnyCriticalAlarm` | BOOL | Critical or Emergency alarm exists. |
| `xAnyEmergencyAlarm` | BOOL | Emergency alarm exists. |
| `eHighestSeverity` | E_AlarmSeverity | Highest current severity. |
| `uiActiveAlarmCount` | UINT | Bounded active count. |
| `xTableOverflow` | BOOL | Active table capacity was exceeded. |
| `xInputRejected` | BOOL | One or more condition updates were rejected this scan. |
| `uiInputResultCode` | UINT | Bounded last input rejection reason for this scan. |
| `xEventBufferOverflow` | BOOL | Unsynchronized event capacity was exceeded. |
| `xCommandAccepted` | BOOL | One-scan command acknowledgement. |
| `xCommandRejected` | BOOL | One-scan command rejection. |
| `uiCommandResultCode` | UINT | Bounded rejection/acceptance reason. |
| `udiLastProcessedCommandSequence` | UDINT | Last new command sequence accepted for evaluation, including rejected commands. |

## Rules

- Acknowledge does not clear ConditionActive.
- Reset is rejected while ConditionActive is true.
- Multiple sources may report simultaneously.
- Same active key maps to one active record.
- Duplicate valid updates for one key in the same scan are rejected after the first entry.
- Severity, reset policy, and blocking policy cannot change during an active lifecycle.
- Information severity cannot be Blocking.
- AlarmManager outputs summaries only; machine modules decide operational transitions.
- Command sequences are idempotent.

## Revision History

| Version | Date | Description |
|---|---|---|
| 2.0 | 2026-07-25 | Consolidated the numeric alarm lifecycle boundary. |
| 2.1 | 2026-07-26 | Replaced the ambiguous singular source input with a 32-entry update image and defined the oldest-event persistence handshake for a 128-event ring buffer. |
