# FB_RuntimeCounter

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Deterministic retentive lifetime counter accumulation |
| Version | 1.0 |

## Purpose

Accumulates bounded lifetime seconds and event/quantity counters from monotonic PLC timing and validated events.

## Rules

- use monotonic elapsed-time ticks, never Desktop wall-clock differences
- accumulate only validated state ownership; mutually exclusive runtime categories do not double count
- retentive counters never decrease in normal operation
- counters saturate and raise diagnostics before overflow
- reset of lifetime counters requires a separate engineering recovery procedure, never routine operation
- feed accumulation uses centi-kilograms in UDINT to avoid long-term REAL precision drift
- daily, weekly, monthly, OEE, charts, and historical analytics are excluded

## Minimum Inputs

- validated one-second tick
- powered, automatic, feeding, paused, and fault state flags
- completed job event
- validated delivered feed increment in centi-kilograms
- machine start, emergency, and alarm occurrence events

## Output

One authoritative `ST_Runtime` snapshot.
