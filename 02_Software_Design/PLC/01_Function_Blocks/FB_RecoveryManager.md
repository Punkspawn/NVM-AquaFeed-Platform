# FB_RecoveryManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Validate and coordinate recovery from an interrupted accepted execution |
| Version | 3.1 |

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

## Deterministic Command Flow

1. A new Evaluate sequence privately copies `ST_RecoveryCheckpoint` and enters Evaluating.
2. Evaluation validates the complete snapshot, quantity, policy, retry, Desktop-current, safety, stopped-equipment, IO, communication, configuration, and equipment prerequisites.
3. A valid checkpoint becomes Available for one scan, then AwaitingApproval; no equipment permission is emitted.
4. A new local ResumeApproval sequence revalidates all live prerequisites and enters Reinitializing.
5. ReinitializeRequest asks the external orchestration layer to restore safe known equipment states; it is not a run command.
6. ReinitializationComplete enters ReadyToResume and exposes the approved private snapshot.
7. Only explicit LineResumeAccepted completes the recovery handshake.
8. Reject, ambiguity, supersession, terminal execution, retry exhaustion, or reinitialization failure invalidates the approved handoff.

## Result Policy

Every rejection uses a bounded numeric reason. Unknown state, arithmetic ambiguity, sequence exhaustion, or contradictory completion/failure feedback fails closed. Automatic retry and automatic resume are prohibited.

## Revision History

| Version | Date | Description |
|---|---|---|
| 3.0 | 2026-07-25 | Defined restart-safe recovery ownership. |
| 3.1 | 2026-07-26 | Closed retained checkpoint, live validation, approval, reinitialization, and LineManager handoff semantics. |
