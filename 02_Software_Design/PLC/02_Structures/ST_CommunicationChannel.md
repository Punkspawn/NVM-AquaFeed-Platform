# ST_CommunicationChannel

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Persistence | Current state non-retentive; counters retentive |
| Version | 1.0 |

```iecst
TYPE ST_CommunicationChannel :
STRUCT
    uiChannelId             : UINT;
    uiProfileId             : UINT;
    uiChannelType           : UINT;
    uiState                 : UINT;

    xEnabled                : BOOL;
    xRequiredForControl     : BOOL;
    xReady                  : BOOL;
    xFresh                  : BOOL;
    xFault                  : BOOL;

    udiLastRxTickMs         : UDINT;
    udiLastTxTickMs         : UDINT;
    udiLastAcceptedSequence : UDINT;

    udiTxCount              : UDINT;
    udiRxCount              : UDINT;
    udiErrorCount           : UDINT;
    udiTimeoutCount         : UDINT;
    udiRetryCount           : UDINT;

    uiConsecutiveFailureCount : UINT;
    uiDiagnosticCode        : UINT;
END_STRUCT;
END_TYPE
```

Counters saturate. Tick comparisons use wrap-safe unsigned elapsed arithmetic. Channel/profile/type identities and supervision thresholds come from static approved configuration. State codes are Disabled=0, Starting=10, Ready=20, Stale=30, and Fault=90.
