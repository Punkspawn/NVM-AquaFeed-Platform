# ST_MaintenanceCounter

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Instance rule | One instance per maintained device/scope |
| Version | 1.0 |

## Definition

```iecst
TYPE ST_MaintenanceCounter :
STRUCT
    DeviceId                 : UINT;
    Enabled                  : BOOL;

    LifetimeRuntimeSec       : UDINT;
    RuntimeAtLastServiceSec  : UDINT;
    ServiceIntervalSec       : UDINT;
    GraceIntervalSec         : UDINT;

    RuntimeSinceServiceSec   : UDINT;
    RemainingServiceSec      : UDINT;
    OverdueServiceSec        : UDINT;

    ServiceDue               : BOOL;
    ServiceOverdue           : BOOL;

    LastAcceptedResetSequence : UDINT;
    ResetCount               : UDINT;
END_STRUCT
END_TYPE
```

## Rules

- LifetimeRuntimeSec never resets during maintenance.
- RuntimeSinceServiceSec = LifetimeRuntimeSec - RuntimeAtLastServiceSec using guarded non-negative arithmetic.
- RemainingServiceSec never becomes negative.
- OverdueServiceSec remains zero until the interval is exceeded.
- Reset sets RuntimeAtLastServiceSec to current LifetimeRuntimeSec.
- ResetCount saturates and never wraps silently.
- Dates, users, notes, plans, work orders, and history are excluded.
