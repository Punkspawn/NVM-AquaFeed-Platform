# ST_JobExecution

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Lifetime | Candidate transfer and one active execution |
| Version | 1.1 |

## Purpose

Contains only immutable fields required by one LineManager to execute one accepted feeding job.

## Definition

```iecst
TYPE ST_JobExecution :
STRUCT
    uiSnapshotVersion        : UINT;
    udiTransferSequence      : UDINT;
    udiJobId                 : UDINT;
    usiLineId                : USINT;
    uiRecipeId               : UINT;
    udiRecipeRevision        : UDINT;

    uiTargetSelectorOutlet   : UINT;
    byDosingUnitMask         : BYTE;
    udiTargetFeedCentiKg     : UDINT;
    udiMaximumExecutionTimeSec : UDINT;

    xAllowRecovery           : BOOL;
    usiMaximumRetryCount     : USINT;

    uiPayloadCRC16           : UINT;
END_STRUCT;
END_TYPE
```

## Rules

- Desktop writes the candidate transfer buffer.
- PLC validates bounds, identity, revision, assignment, and CRC before acceptance.
- LineManager copies the accepted snapshot to private active storage.
- The active copy is immutable until completion, cancellation, or terminal fault.
- User, schedule, queue, history, cage, fish-lot, stock, and reporting data are excluded.
- `udiTargetFeedCentiKg` uses 0.01 kg per count and must be positive and within configured line limits.
- Current release accepts exactly one Dosing unit per job: mask `16#01` or `16#02`.
- Mask `16#03` is reserved until an explicit dual-unit target-split policy and tests are approved.

## Related Documents

- [ST_RecipeExecution](ST_RecipeExecution.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
