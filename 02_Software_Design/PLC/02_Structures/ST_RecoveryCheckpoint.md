# ST_RecoveryCheckpoint

| Field | Value |
|---|---|
| Status | Authoritative retained PLC checkpoint |
| Owner | Line execution / Recovery boundary |
| Version | 1.0 |

## Purpose

Retains the minimum complete execution snapshot and quantity evidence required to evaluate one interrupted feeding job without guessing.

## Definition

```iecst
TYPE ST_RecoveryCheckpoint :
STRUCT
    uiCheckpointVersion           : UINT;
    stJob                         : ST_JobExecution;
    stRecipe                      : ST_RecipeExecution;
    udiDeliveredFeedCentiKg       : UDINT;
    udiLastAcceptedCommandSequence : UDINT;
    uiInterruptionReason          : UINT;
    usiRetryCount                 : USINT;
    xQuantityTrustworthy          : BOOL;
    xExecutionCompleted           : BOOL;
    xExecutionCancelled           : BOOL;
    uiPayloadCRC16                : UINT;
END_STRUCT
END_TYPE
```

## Rules

- Checkpoint version for the current release is 1.
- Job and Recipe snapshots are the immutable accepted execution pair, not Desktop master records.
- Integrity validation is performed by the checkpoint transfer/retention owner and supplied to RecoveryManager as one explicit Boolean.
- Delivered quantity uses centi-kilograms and shall not exceed the accepted target.
- Quantity that cannot be proven trustworthy makes recovery unavailable.
- Completed or cancelled execution cannot be resumed.
- RetryCount shall remain below the accepted job MaximumRetryCount.
- The structure contains no motor/output command, user, timestamp, history, report, or business workflow field.
