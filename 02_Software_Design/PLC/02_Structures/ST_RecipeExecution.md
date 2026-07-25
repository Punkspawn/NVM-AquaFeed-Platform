# ST_RecipeExecution

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Lifetime | Candidate transfer and one active execution |
| Version | 1.0 |

## Purpose

Contains only immutable machine parameters required to execute one accepted recipe revision.

## Definition

```iecst
TYPE ST_RecipeExecution :
STRUCT
    SnapshotVersion          : UINT;
    RecipeId                 : UINT;
    RecipeRevision           : UDINT;

    DosingSpeedPercent       : REAL;
    BlowerSpeedPercent       : REAL;

    SelectorSettleTimeMs     : UDINT;
    BlowerPreRunTimeMs       : UDINT;
    BlowerPostRunTimeMs      : UDINT;
    MaximumDosingTimeSec     : UDINT;

    FeedToleranceKg          : REAL;

    PayloadCRC16             : UINT;
END_STRUCT
END_TYPE
```

## Rules

- Setpoints are validated against engineering configuration, not merely 0–100 percent.
- All timing values are bounded before acceptance.
- Feed tolerance must be non-negative and within approved limits.
- Recipe name, users, timestamps, line masks, repeat programs, and history are excluded.
- Accepted values remain immutable for the active job.

## Related Documents

- [ST_JobExecution](ST_JobExecution.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
