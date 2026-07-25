# ST_JobExecution

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Lifetime | Candidate transfer and one active execution |
| Version | 1.0 |

## Purpose

Contains only immutable fields required by one LineManager to execute one accepted feeding job.

## Definition

```iecst
TYPE ST_JobExecution :
STRUCT
    SnapshotVersion          : UINT;
    TransferSequence         : UDINT;
    JobId                    : UDINT;
    LineId                   : USINT;
    RecipeId                 : UINT;
    RecipeRevision           : UDINT;

    TargetSelectorPosition   : USINT;
    DosingUnitMask           : BYTE;
    TargetFeedKg             : REAL;
    MaximumExecutionTimeSec  : UDINT;

    AllowRecovery            : BOOL;
    MaximumRetryCount        : USINT;

    PayloadCRC16             : UINT;
END_STRUCT
END_TYPE
```

## Rules

- Desktop writes the candidate transfer buffer.
- PLC validates bounds, identity, revision, assignment, and CRC before acceptance.
- LineManager copies the accepted snapshot to private active storage.
- The active copy is immutable until completion, cancellation, or terminal fault.
- User, schedule, queue, history, cage, fish-lot, stock, and reporting data are excluded.
- `DosingUnitMask` uses approved bits only; unsupported combinations are rejected.
- `TargetFeedKg` must be positive and within configured line limits.

## Related Documents

- [ST_RecipeExecution](ST_RecipeExecution.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
