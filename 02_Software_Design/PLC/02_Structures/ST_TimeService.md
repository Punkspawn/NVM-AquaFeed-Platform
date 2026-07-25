# ST_TimeService

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Persistence | Monotonic sequence retentive when supported; wall clock observational |
| Version | 1.0 |

```iecst
TYPE ST_TimeService :
STRUCT
    udiMonotonicTickMs        : UDINT;
    udiMonotonicSecondSequence : UDINT;
    xOneSecondTick            : BOOL;
    xMonotonicHealthy         : BOOL;

    dtObservedUtc             : DT;
    xWallClockValid           : BOOL;
    udiLastAcceptedSyncSequence : UDINT;
    uiTimeDiagnosticCode      : UINT;
END_STRUCT
END_TYPE
```

## Rules

- `udiMonotonicTickMs` may wrap; elapsed comparisons use unsigned modular subtraction
- `xOneSecondTick` is true for one scan per accepted second
- second sequence and counters saturate rather than wrap silently
- `dtObservedUtc` is never used for safety, timeout, runtime, or sequence control
- timezone and daylight-saving conversion occur outside PLC
