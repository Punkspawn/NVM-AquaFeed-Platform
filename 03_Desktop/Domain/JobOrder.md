# Job Order Domain Model

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | AquaFeed Manager / Desktop |
| Persistence | Database |
| Version | 1.0 |

## Purpose

Represents the complete business record of one requested feeding operation.

Desktop owns creation, editing, validation, scheduling, queue priority, user attribution, history, and reporting. The PLC never stores the complete Job Order master.

## Core Data

- unique Job ID
- lifecycle status: Draft, Scheduled, Queued, Transferred, Running, Paused, Completed, Cancelled, Failed
- target farm/site and machine
- target Line ID
- Recipe ID and revision
- cage/fish-lot/feed-lot references
- requested feed quantity and schedule
- priority
- requested, approved, and supervised user references
- creation, modification, planned, start, and completion timestamps
- Desktop validation result
- PLC transfer sequence and acknowledgement
- final delivered quantity and result code
- historical events and audit trail

## Rules

- Completed and Cancelled records are immutable except for approved administrative annotations.
- Desktop validates permissions, cage/fish/feed records, stock, scheduling, and business rules.
- Exactly one bounded execution snapshot is generated for PLC transfer.
- Changes after PLC acceptance create a new revision; they never mutate the active PLC snapshot.
- PLC events are persisted idempotently using Job ID and transfer sequence.

## PLC Boundary

The PLC receives [ST_JobExecution](../../02_Software_Design/PLC/02_Structures/ST_JobExecution.md), not this complete domain model.
