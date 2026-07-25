# IF_ExecutionTransfer

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | Desktop–PLC integration boundary |
| Direction | Desktop to PLC request; PLC to Desktop acknowledgement |
| Version | 1.0 |

## Purpose

Defines the atomic transfer and acceptance handshake for one job and recipe execution snapshot.

It replaces PLC-side job creation, queue management, recipe save/delete, and master-data interfaces.

## Desktop to PLC

| Name | Type | Description |
|---|---|---|
| `xTransferRequest` | BOOL | Requests validation of the candidate buffers. |
| `udiTransferSequence` | UDINT | Monotonically increasing idempotency sequence. |
| `stJobCandidate` | ST_JobExecution | Candidate immutable job snapshot. |
| `stRecipeCandidate` | ST_RecipeExecution | Candidate immutable recipe snapshot. |

## PLC to Desktop

| Name | Type | Description |
|---|---|---|
| `xTransferReady` | BOOL | PLC can evaluate a new candidate. |
| `xTransferAccepted` | BOOL | One-scan acceptance event. |
| `xTransferRejected` | BOOL | One-scan rejection event. |
| `udiAcceptedSequence` | UDINT | Last accepted transfer sequence. |
| `uiTransferResultCode` | UINT | Bounded acceptance/rejection reason. |

## Acceptance Rules

PLC accepts only when:

- Desktop communication is healthy
- no unacknowledged candidate is pending
- target line is not busy with another active job
- Job ID, Line ID, Recipe ID, and Recipe Revision are valid and mutually consistent
- both snapshot versions are supported
- both CRC values are valid
- all quantities, setpoints, timings, positions, masks, and policies are within engineering limits
- target line and required equipment configuration are compatible

## Handshake

```text
Desktop writes both candidate structures
        ↓
Desktop writes TransferSequence
        ↓
Desktop raises TransferRequest
        ↓
PLC copies candidates to validation buffer
        ↓
PLC validates complete atomic pair
        ↓
Accepted or Rejected + ResultCode
        ↓
Desktop observes matching sequence
        ↓
Desktop lowers TransferRequest
        ↓
PLC clears one-scan event
```

## Integrity Rules

- Partial job/recipe acceptance is prohibited.
- Repeated requests with an already accepted sequence are idempotent.
- A new sequence is required for changed payload.
- Active LineManager storage never references a mutable communication buffer.
- Communication loss during an already active job does not invalidate its private accepted snapshot.
- Communication loss prevents acceptance of a new transfer.

## Related Documents

- [ST_JobExecution](../02_Structures/ST_JobExecution.md)
- [ST_RecipeExecution](../02_Structures/ST_RecipeExecution.md)
- [IF_Line](IF_Line.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
