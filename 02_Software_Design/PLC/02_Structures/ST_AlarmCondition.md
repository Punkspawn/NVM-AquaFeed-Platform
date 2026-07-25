# ST_AlarmCondition

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC alarm source aggregation boundary |
| Version | 1.0 |

## Purpose

Carries one current numeric alarm condition from its owning PLC module to `FB_AlarmManager`.

## Definition

```iecst
TYPE ST_AlarmCondition :
STRUCT
    Valid           : BOOL;
    ConditionActive : BOOL;
    AlarmCode       : UINT;
    Source          : E_AlarmSource;
    Severity        : E_AlarmSeverity;
    LineId          : USINT;
    DeviceId        : UINT;
    ResetRequired   : BOOL;
    Blocking        : BOOL;
END_STRUCT
END_TYPE
```

## Rules

- The fixed input image contains 32 entries indexed `0..31`.
- `Valid = FALSE` means the entry is unused and shall not modify an existing alarm.
- A source reports `Valid = TRUE` and `ConditionActive = FALSE` at least once when a previously reported condition is removed.
- Identity is `AlarmCode + Source + LineId + DeviceId`.
- Catalog-owned Severity, ResetRequired, and Blocking values are immutable during one active lifecycle.
- Information severity with Blocking is invalid.
- The structure contains no text, user, timestamp, or history field.
