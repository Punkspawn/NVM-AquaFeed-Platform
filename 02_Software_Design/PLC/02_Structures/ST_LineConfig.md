# ST_LineConfig

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / commissioning |
| Version | 1.0 |

## Purpose

Defines fixed, approved bounds for one physical feeding line. It contains no job, recipe, history, or dynamically discovered equipment.

## Definition

```iecst
TYPE ST_LineConfig :
STRUCT
    usiLineId                       : USINT;
    uiSelectorOutletCount           : UINT;

    xDosing1Enabled                 : BOOL;
    xDosing2Enabled                 : BOOL;

    udiMaximumTargetCentiKg         : UDINT;
    udiMaximumFeedToleranceCentiKg  : UDINT;

    uiMinimumDosingSpeedPermille    : UINT;
    uiMaximumDosingSpeedPermille    : UINT;
    uiMinimumBlowerFreqCentiHz      : UINT;
    uiMaximumBlowerFreqCentiHz      : UINT;

    udiMaximumSelectorSettleTimeMs  : UDINT;
    udiMaximumBlowerPreRunTimeMs    : UDINT;
    udiMaximumBlowerPostRunTimeMs   : UDINT;
    udiMaximumDosingTimeSec         : UDINT;
    udiMaximumExecutionTimeSec      : UDINT;
END_STRUCT;
END_TYPE
```

## Rules

- Line ID is fixed and nonzero.
- At least one Dosing unit is enabled.
- Current jobs select exactly one enabled Dosing unit.
- minimum setpoints are positive and do not exceed maximum setpoints.
- accepted target and tolerance remain within configured bounds; tolerance is smaller than target.
- accepted timing values are positive and within configured maxima.
- configuration changes do not mutate an active private execution snapshot.
