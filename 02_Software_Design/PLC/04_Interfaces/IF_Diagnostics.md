# IF_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 2.1 |

## Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables aggregation. |
| `udiScanTimeUs` / `udiMaximumScanTimeUs` | UDINT | Current duration and approved non-zero budget. |
| `xScanOverrunEvent` / `udiScanOverrunSequence` | BOOL / UDINT | Replay-safe measured overrun occurrence. |
| `xWatchdogHealthy` | BOOL | PLC watchdog status. |
| `xConfigurationValid` | BOOL | Approved runtime configuration status. |
| `stIO` | ST_IO | Current IO health summary. |
| `xRequiredCommunicationHealthy` | BOOL | Required field feedback is current. |
| `uiOfflineChannelCount` | UINT | All currently offline channels. |
| `uiActiveAlarmCount` | UINT | AlarmManager active count for publication only. |
| `xEquipmentBlockingDiagnostic` / `xEquipmentDegradedDiagnostic` | BOOL | Current equipment diagnostic class. |
| `uiEquipmentDiagnosticCode` / `uiEquipmentSeverity` | UINT | Stable source code and bounded 0..40 severity. |
| `xCounterSaturation` | BOOL | A monitored subsystem counter has saturated. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `stDiagnostics` | ST_Diagnostics | Current bounded snapshot. |
| `xDiagnosticOccurrence` | BOOL | One-scan highest-priority new occurrence. |
| `uiOccurrenceCode` | UINT | Stable occurrence code; zero means none. |

No StartTest, StopTest, Reset, acknowledgement, wall-clock, or physical command exists.
