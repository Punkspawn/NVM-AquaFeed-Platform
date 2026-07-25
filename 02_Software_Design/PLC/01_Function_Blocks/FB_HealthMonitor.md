# FB_HealthMonitor

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Bounded current readiness/degradation aggregation |
| Version | 3.0 |

## Purpose

Aggregates explicit current status from System, IO, diagnostics, communication, safety coordination, lines, and core equipment.

It does not calculate a health score, trend, prediction, maintenance plan, report, fleet comparison, root cause, or historical KPI.

## Rules

- fixed inputs and bounded loops only
- readiness is derived from documented Boolean/severity rules
- a blocking condition makes `xReadyForNewJob` false
- a degraded non-blocking condition may permit the current accepted job to continue
- Desktop communication loss blocks new transfers but does not by itself stop a healthy active job
- safety loss always removes standard-control permits
- missing required VFD/IO feedback is blocking for its owning equipment
- HealthMonitor never commands outputs or clears alarms/faults
- current status clears with its source condition; occurrence/history remains owned elsewhere

## Output

One `ST_HealthStatus` snapshot and a one-scan health-transition event for diagnostics/history transfer.
