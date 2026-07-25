# ST_RecipeExecution

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Lifetime | Candidate transfer and one active execution |
| Version | 1.1 |

## Purpose

Contains only immutable machine parameters required to execute one accepted recipe revision.

## Definition

```iecst
TYPE ST_RecipeExecution :
STRUCT
    uiSnapshotVersion        : UINT;
    uiRecipeId               : UINT;
    udiRecipeRevision        : UDINT;

    uiDosingSpeedPermille    : UINT;
    uiBlowerFreqCentiHz      : UINT;

    udiSelectorSettleTimeMs  : UDINT;
    udiBlowerPreRunTimeMs    : UDINT;
    udiBlowerPostRunTimeMs   : UDINT;
    udiMaximumDosingTimeSec  : UDINT;

    udiFeedToleranceCentiKg  : UDINT;

    uiPayloadCRC16           : UINT;
END_STRUCT;
END_TYPE
```

## Rules

- Dosing speed uses 0–1000 permille and is validated against equipment configuration.
- Blower frequency uses 0.01 Hz per count and is validated against the commissioned VFD/blower range.
- All timing values are bounded before acceptance.
- Feed tolerance uses 0.01 kg per count and must be smaller than the accepted target.
- Recipe name, users, timestamps, line masks, repeat programs, and history are excluded.
- Accepted values remain immutable for the active job.
- No floating-point value crosses the LineManager/equipment execution boundary.

## Related Documents

- [ST_JobExecution](ST_JobExecution.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
