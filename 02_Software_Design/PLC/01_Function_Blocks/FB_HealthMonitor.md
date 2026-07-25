# FB_HealthMonitor

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Bounded current readiness/degradation aggregation |
| Version | 3.1 |

## Purpose

Aggregates explicit current status from System, Safety, IO, Diagnostics, required field communication, Desktop communication, configuration, Selector, Blower, and Dosing.

It does not calculate a score, trend, prediction, maintenance plan, root cause, or history.

## Decision Policy

Blocking priority is deterministic: Safety, Configuration, IO, System, required field communication, Selector, Blower, Dosing, then Diagnostics.

- any blocking condition removes both new-job readiness and current-job continuation
- Desktop communication loss blocks only new-job readiness
- a non-blocking diagnostic condition marks Degraded but permits operation
- equipment health inputs apply to the currently assigned execution path
- Safety failure publishes severity 40; other blocking failures publish severity 30
- Desktop loss or non-blocking diagnostics publish severity 20
- transition sequence saturates and advances only when a material published field changes
- the initial snapshot does not emit a transition event
- HealthMonitor never commands outputs or clears source conditions

## Output

One `ST_HealthStatus` snapshot and a one-scan material-transition event.

## Revision History

| Version | Date | Description |
|---|---|---|
| 3.0 | 2026-07-25 | Normalized bounded health ownership. |
| 3.1 | 2026-07-26 | Closed explicit inputs, blocking priority, severity, and transition semantics. |
