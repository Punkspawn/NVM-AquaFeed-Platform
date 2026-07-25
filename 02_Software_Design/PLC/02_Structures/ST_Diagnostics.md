# ST_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative |
| Persistence | Current flags non-retentive; counters retentive |
| Version | 3.1 |

```iecst
TYPE ST_Diagnostics :
STRUCT
    xReady : BOOL;
    xDegraded : BOOL;
    xFault : BOOL;
    xWatchdogHealthy : BOOL;
    xConfigurationValid : BOOL;
    uiLastDiagnosticCode : UINT;
    uiHighestSeverity : UINT;
    uiActiveDiagnosticCount : UINT;
    uiActiveAlarmCount : UINT;
    uiInvalidInputCount : UINT;
    uiInvalidOutputCount : UINT;
    uiOutputMismatchCount : UINT;
    uiOfflineChannelCount : UINT;
    udiScanTimeUs : UDINT;
    udiMaxScanTimeUs : UDINT;
    udiScanOverrunCount : UDINT;
    udiDiagnosticOccurrenceCount : UDINT;
END_STRUCT;
END_TYPE
```

Counts saturate. Ready requires valid configuration, healthy watchdog, healthy required IO/communication, and no blocking equipment diagnostic. Degraded permits bounded operation. Historical interpretation belongs to Desktop.

## Revision History

| Version | Date | Description |
|---|---|
| 3.0 | 2026-07-25 | Defined bounded current snapshot. |
| 3.1 | 2026-07-26 | Aligned invalid IO counters with ST_IO and closed current severity semantics. |
