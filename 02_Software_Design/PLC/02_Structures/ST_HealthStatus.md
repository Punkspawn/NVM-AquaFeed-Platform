# ST_HealthStatus

| Field | Value |
|---|---|
| Status | Authoritative |
| Persistence | Current non-retentive snapshot |
| Version | 1.0 |

```iecst
TYPE ST_HealthStatus :
STRUCT
    xReadyForNewJob           : BOOL;
    xCurrentJobMayContinue    : BOOL;
    xDegraded                 : BOOL;
    xBlockingFault            : BOOL;

    xSafetyHealthy            : BOOL;
    xIOHealthy                : BOOL;
    xRequiredCommunicationHealthy : BOOL;
    xSelectorHealthy          : BOOL;
    xBlowerHealthy            : BOOL;
    xDosingHealthy            : BOOL;
    xConfigurationValid       : BOOL;

    uiHighestSeverity         : UINT;
    uiBlockingReasonCode      : UINT;
    uiDegradedReasonCode      : UINT;
    udiStatusSequence         : UDINT;
END_STRUCT
END_TYPE
```

No score, percentage, trend, prediction, text, or history is stored.
