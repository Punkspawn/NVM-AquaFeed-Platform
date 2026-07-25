# ST_SafetyStatus

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC observation |
| Persistence | Current state; reset sequence retained |
| Version | 1.0 |

```iecst
TYPE ST_SafetyStatus :
STRUCT
    eState                    : E_SafetyCoordinationState;
    xFeedbackValid            : BOOL;
    xEmergencyActive          : BOOL;
    xSafetyRelayHealthy       : BOOL;
    xSTOFeedbackHealthy       : BOOL;
    xContactorFeedbackHealthy : BOOL;
    xResetRequired            : BOOL;

    xAutomaticPermitted       : BOOL;
    xMotionPermitted          : BOOL;
    xBlowerPermitted          : BOOL;
    xDosingPermitted          : BOOL;
    xRecoveryPermitted        : BOOL;

    udiLastAcceptedResetSequence : UDINT;
    uiDiagnosticCode          : UINT;
END_STRUCT
END_TYPE
```

Permission bits are standard-control inhibits only and do not implement safety-rated removal of energy.
