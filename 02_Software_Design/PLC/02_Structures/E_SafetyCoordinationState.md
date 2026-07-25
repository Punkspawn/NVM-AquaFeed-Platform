# E_SafetyCoordinationState

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC status enum |
| Version | 1.0 |

```iecst
TYPE E_SafetyCoordinationState :
(
    SafetyUnknown := 0,
    SafetyHealthyStopped := 10,
    SafetyHealthyPermitted := 20,
    SafetyTripActive := 80,
    SafetyResetRequired := 90,
    SafetyFeedbackFault := 100
);
END_TYPE
```

This enum describes observed standard-PLC coordination state, not a safety integrity level.
