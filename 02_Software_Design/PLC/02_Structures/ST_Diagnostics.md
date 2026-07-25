# ST_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Persistence | Current flags non-retentive; occurrence counters retentive |
| Version | 3.0 |

## Definition

```iecst
TYPE ST_Diagnostics :
STRUCT
    xReady                    : BOOL;
    xDegraded                 : BOOL;
    xFault                    : BOOL;
    xWatchdogHealthy          : BOOL;
    xConfigurationValid       : BOOL;

    uiLastDiagnosticCode      : UINT;
    uiHighestSeverity         : UINT;
    uiActiveDiagnosticCount   : UINT;
    uiActiveAlarmCount        : UINT;

    uiInvalidDigitalCount     : UINT;
    uiInvalidAnalogCount      : UINT;
    uiOutputMismatchCount     : UINT;
    uiOfflineChannelCount     : UINT;

    udiScanTimeUs             : UDINT;
    udiMaxScanTimeUs          : UDINT;
    udiScanOverrunCount       : UDINT;
    udiDiagnosticOccurrenceCount : UDINT;
END_STRUCT
END_TYPE
```

## Rules

- all counts are bounded and saturate instead of wrapping
- `xFault` represents a current PLC-relevant diagnostic condition, not historical events
- `xReady` requires valid configuration, healthy watchdog, no blocking IO/communication condition, and no diagnostic fault
- `xDegraded` indicates continued bounded operation with a non-blocking diagnostic
- scan time uses integer microseconds; REAL percentages and estimated CPU/memory values are excluded
- wall-clock timestamps, text, root-cause narratives, history, reports, and predictive fields are Desktop responsibilities
