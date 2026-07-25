# FB_RecoveryManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Validate and coordinate recovery from an interrupted accepted execution |
| Version | 3.0 |

## Principle

Recovery never starts a new job and never automatically re-energizes equipment after PLC restart, power return, safety trip, or critical fault.

## Flow

`Idle → Evaluating → Available/Rejected → AwaitingApproval → Reinitializing → ReadyToResume → Completed/Failed`

## Validation

Recovery is available only when all are true:

- retained snapshot identity, version, CRC, job, recipe, line, and outlet are valid
- delivered quantity and accepted command sequences are internally consistent
- configured recovery policy permits the interruption type
- hardwired safety chain is healthy and reset is complete
- all equipment is stopped and feedback is known
- Selector, Blower, Dosing, IO, communication, and configuration prerequisites pass
- no newer Desktop cancellation/replacement sequence exists

## Resume

- requires a new local/operator-approved recovery sequence
- reinitializes equipment from safe outputs
- revalidates selector position, blower readiness, and remaining dosing target
- resumes only from an explicitly defined checkpoint
- never reports an interrupted dosing transaction complete without proof
- rejects ambiguous quantity/snapshot state and requires Desktop reconciliation

## Boundary

PLC stores only the bounded recovery checkpoint required for deterministic reconciliation. Desktop owns history, user identity, reports, workflow, and business decision records.
