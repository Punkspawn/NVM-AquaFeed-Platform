# IF_Recovery

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.1 |

## Request

| Name | Type | Description |
|---|---|---|
| `xEvaluateRequest` | BOOL | Requests checkpoint evaluation. |
| `xResumeApproval` | BOOL | Local/operator-approved resume request. |
| `xRejectRequest` | BOOL | Rejects/abandons checkpoint. |
| `udiRecoverySequence` | UDINT | Idempotent request sequence. |

## Retained Checkpoint

| Name | Type | Description |
|---|---|---|
| `xCheckpointPresent` | BOOL | A retained checkpoint is available for evaluation. |
| `stCheckpoint` | ST_RecoveryCheckpoint | Complete immutable accepted job/recipe and quantity evidence. |
| `xCheckpointIntegrityValid` | BOOL | Checkpoint owner validated versioned payload integrity. |
| `xDesktopCheckpointStillCurrent` | BOOL | No newer cancellation, completion, or replacement invalidates this checkpoint. |

## Live Conditions

| Name | Type | Description |
|---|---|---|
| `xSafetyRecoveryPermitted` | BOOL | SafetyCoordinator permits stopped-state recovery evaluation. |
| `xEquipmentStopped` | BOOL | All affected equipment is stopped. |
| `xEquipmentFeedbackKnown` | BOOL | Required equipment feedback is known and plausible. |
| `xConfigurationValid` | BOOL | Current line/equipment configuration matches the checkpoint. |
| `xIOHealthy` | BOOL | Required IO image is valid. |
| `xCommunicationHealthy` | BOOL | Required recovery/reconciliation communication is healthy. |
| `xSelectorReady` | BOOL | Assigned Selector can be revalidated. |
| `xBlowerReady` | BOOL | Assigned Blower can be revalidated. |
| `xDosingReady` | BOOL | Selected Dosing unit can be revalidated. |
| `xReinitializationComplete` | BOOL | External safe reinitialization sequence completed. |
| `xReinitializationFailed` | BOOL | External safe reinitialization sequence failed. |
| `xLineResumeAccepted` | BOOL | LineManager accepted the approved checkpoint for its own validation path. |

## Output

| Name | Type | Description |
|---|---|---|
| `stRecovery` | ST_RecoveryStatus | Current recovery result. |
| `stApprovedJob` | ST_JobExecution | Private approved job snapshot; valid only with ApprovedCheckpointValid. |
| `stApprovedRecipe` | ST_RecipeExecution | Private approved recipe snapshot; valid only with ApprovedCheckpointValid. |
| `udiApprovedDeliveredCentiKg` | UDINT | Proven delivered quantity used to calculate the remaining target. |
| `xReinitializeRequest` | BOOL | Requests external safe reinitialization; never an equipment run/start command. |
| `xResumeCommandAccepted` | BOOL | One-scan acceptance event; not a motor start. |
| `xRequestRejected` | BOOL | One-scan rejection event. |

Power return, communication return, reset, or snapshot presence alone never generates resume acceptance.

## Rules

- Evaluate, ResumeApproval, and Reject are mutually exclusive commands sharing one idempotent sequence.
- Evaluation copies the checkpoint into private storage before validation; later input-buffer changes cannot mutate it.
- Resume approval revalidates every live condition and requires a new sequence.
- ReinitializeRequest cannot directly energize equipment and remains subject to SafetyCoordinator and equipment blocks.
- Approved snapshots are exposed only after successful approval and remain invalid if reinitialization fails.
- ReadyToResume does not itself start LineManager; completion requires explicit LineResumeAccepted.

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Defined the initial recovery request boundary. |
| 1.1 | 2026-07-26 | Added the complete checkpoint, explicit live prerequisites, approved snapshot handoff, and reinitialization/LineManager acknowledgements. |
