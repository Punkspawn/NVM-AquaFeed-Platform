# ST_RecoveryStatus

| Field | Value |
|---|---|
| Status | Authoritative |
| Persistence | Bounded retained checkpoint and sequences |
| Version | 1.1 |

```iecst
TYPE ST_RecoveryStatus :
STRUCT
    eState                    : E_RecoveryState;
    xSnapshotPresent          : BOOL;
    xSnapshotValid            : BOOL;
    xRecoveryAvailable        : BOOL;
    xApprovalRequired         : BOOL;
    xReadyToResume            : BOOL;
    xApprovedCheckpointValid  : BOOL;

    udiJobId                  : UDINT;
    udiRecipeVersion          : UDINT;
    usiLineId                 : USINT;
    uiOutletId                : UINT;
    udiTargetFeedCentiKg      : UDINT;
    udiDeliveredCentiKg       : UDINT;
    udiRemainingFeedCentiKg   : UDINT;
    usiRetryCount             : USINT;
    udiLastAcceptedCommandSequence : UDINT;
    udiLastProcessedRecoverySequence : UDINT;

    uiInterruptionReason      : UINT;
    uiResultCode              : UINT;
END_STRUCT
END_TYPE
```

No motor/output command or wall-clock history is stored in this structure.

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Defined the initial bounded recovery status. |
| 1.1 | 2026-07-26 | Added approved-checkpoint, target, remaining quantity, retry count, and corrected line ID width. |
