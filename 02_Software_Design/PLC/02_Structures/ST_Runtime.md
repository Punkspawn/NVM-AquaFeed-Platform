# ST_Runtime

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Persistence | Retentive lifetime counters |
| Version | 3.0 |
| Governing decisions | AD-002 and AD-003 |

## Definition

```iecst
TYPE ST_Runtime :
STRUCT
    TotalPoweredSec          : UDINT;

    TotalReadyIdleSec        : UDINT;
    TotalFeedingSec          : UDINT;
    TotalPausedSec           : UDINT;
    TotalFaultSec            : UDINT;
    TotalServiceSec          : UDINT;

    TotalFeedCentiKg         : UDINT;
    CompletedJobCount        : UDINT;
    MachineStartCount        : UDINT;
    EmergencyStopCount       : UDINT;
    AlarmOccurrenceCount     : UDINT;
END_STRUCT
END_TYPE
```

## Units

- Time: whole monotonic seconds.
- Feed: centi-kilograms; 1 count = 0.01 kg.
- Event values: monotonic occurrence counts.

## Rules

- All fields are retentive lifetime totals.
- Counters never decrease during normal operation.
- State buckets are mutually exclusive for each validated one-second tick.
- TotalPoweredSec accumulates independently while PLC runtime accounting is enabled.
- Feed increments only from validated delivered quantity.
- Counters saturate and raise diagnostics before overflow.
- Routine operator/service commands cannot reset lifetime values.
- Daily, weekly, monthly, shift, last-job, OEE, charts, and history are Desktop responsibilities.
- Equipment runtime is tracked independently by ST_MaintenanceCounter instances.

## Removed Legacy Fields

- LastFeedKg and LastCycleTimeSec: Desktop job result/history.
- BlowerRuntimeSec, DosingRuntimeSec, SelectorRuntimeSec: per-device counters.
- REAL TotalFeedKg: replaced with integer centi-kilograms to avoid long-term floating precision drift.
- overlapping production/idle classifications replaced by explicit mutually exclusive state buckets.
