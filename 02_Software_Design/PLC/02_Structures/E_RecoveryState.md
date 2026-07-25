# E_RecoveryState

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.0 |

```iecst
TYPE E_RecoveryState :
(
    RecoveryIdle := 0,
    RecoveryEvaluating := 10,
    RecoveryAvailable := 20,
    RecoveryAwaitingApproval := 30,
    RecoveryReinitializing := 40,
    RecoveryReadyToResume := 50,
    RecoveryCompleted := 60,
    RecoveryRejected := 80,
    RecoveryFailed := 90
);
END_TYPE
```

Undefined values fail closed with no equipment start permission.
