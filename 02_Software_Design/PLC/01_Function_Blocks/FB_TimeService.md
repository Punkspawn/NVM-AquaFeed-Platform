# FB_TimeService

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Monotonic control timing and observed wall-clock publication |
| Version | 1.0 |
| Governing decision | AD-002 |

## Control Time

- derives a validated one-second event from the PLC monotonic/runtime source
- publishes a wrapping millisecond tick and monotonic second sequence
- timeout calculations use IEC timers or wrap-safe unsigned elapsed arithmetic
- scan jitter cannot create duplicate one-second events
- runtime and equipment timers never use wall-clock differences

## Observed Wall Clock

Desktop is the wall-clock authority. PLC may accept a validated UTC observation for display, event correlation, and diagnostics.

Wall-clock updates:

- use a new synchronization sequence
- require valid range and configured maximum step policy
- never modify elapsed timers, runtime counters, command sequences, or state-machine deadlines
- do not implement timezone, daylight-saving, calendar scheduling, NTP client, or historical aggregation in PLC

## Output

One `ST_TimeService` snapshot and one-scan `xOneSecondTick`.

## Faults

Loss or invalidity of Desktop wall-clock synchronization marks wall clock invalid/degraded only. Monotonic control timing continues independently.
