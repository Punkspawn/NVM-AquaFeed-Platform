# IF_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / Desktop observation boundary |
| Version | 2.0 |

## PLC Internal Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables diagnostic aggregation. |
| `udiScanTimeUs` | UDINT | Current measured scan duration. |
| `xScanOverrunEvent` | BOOL | One-scan overrun occurrence. |
| `xWatchdogHealthy` | BOOL | PLC watchdog status. |
| `xConfigurationValid` | BOOL | Approved configuration status. |
| `stIO` | ST_IO | IO health snapshot. |
| `uiOfflineChannelCount` | UINT | Bounded communication summary. |
| `uiActiveAlarmCount` | UINT | AlarmManager active count. |

## Output

| Name | Type | Description |
|---|---|---|
| `stDiagnostics` | ST_Diagnostics | Current bounded diagnostic snapshot. |
| `xDiagnosticOccurrence` | BOOL | One-scan new-condition event. |
| `uiOccurrenceCode` | UINT | Stable diagnostic catalog code. |

## Commands

No generic StartTest, StopTest, or Reset command exists during normal operation. Intrusive tests are separate commissioning procedures and require stopped equipment plus local Service permission.

## Rules

- Desktop reads status but cannot clear physical diagnostic conditions
- acknowledgement is handled by AlarmManager and does not alter diagnostic truth
- history and reporting are persisted outside the PLC
- diagnostic codes are stable catalog identifiers; zero means no new occurrence
