# Maintenance Domain Model

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | AquaFeed Manager / Desktop |
| Persistence | Database |
| Version | 1.0 |

## Purpose

Owns maintenance plans, work orders, service history, users, calendar scheduling, notes, attachments, cost, and analytics.

## Desktop Responsibilities

- preventive, predictive, corrective, emergency, calibration, lubrication, and inspection plans
- device-specific service intervals and grace policies
- calendar-based maintenance
- work-order creation, assignment, priority, execution, verification, and closure
- technician/user identity and authorization
- service dates, notes, parts, documents, cost, and audit trail
- fleet/farm reporting and maintenance analytics
- transfer of approved runtime-based threshold configuration to PLC
- persistence of PLC maintenance due/overdue and reset events

## PLC Boundary

PLC owns only:

- retentive lifetime runtime counters
- current service baseline and runtime interval
- derived due/overdue flags
- validated reset sequence and event handshake

A maintenance reset never clears lifetime runtime. It sets the service baseline to the current lifetime counter.

## Rules

- Desktop authorizes the user and records who performed service.
- PLC accepts reset only in an approved safe/service condition.
- Replayed reset sequence is idempotent.
- Historical work orders are never stored in PLC.
- Calendar-based due dates are calculated by Desktop.
