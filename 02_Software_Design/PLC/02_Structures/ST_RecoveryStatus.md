# ST_RecoveryStatus

| Field | Value |
|---|---|
| Status | Authoritative |
| Persistence | Bounded retained checkpoint and sequences |
| Version | 1.0 |

```iecst
TYPE ST_RecoveryStatus :
STRUCT
    eState                    : E_RecoveryState;
    xSnapshotPresent          : BOOL;
    xSnapshotValid            : BOOL;
    xRecoveryAvailable        : BOOL;
    xApprovalRequired         : BOOL;
    xReadyToResume            : BOOL;

    udiJobId                  : UDINT;
    udiRecipeVersion          : UDINT;
    uiLineId                  : UINT;
    uiOutletId                : UINT;
    udiDeliveredCentiKg       : UDINT;
    udiLastAcceptedCommandSequence : UDINT;
    udiLastProcessedRecoverySequence : UDINT;

    uiInterruptionReason      : UINT;
    uiResultCode              : UINT;
END_STRUCT
END_TYPE
```

No motor/output command or wall-clock history is stored in this structure.
