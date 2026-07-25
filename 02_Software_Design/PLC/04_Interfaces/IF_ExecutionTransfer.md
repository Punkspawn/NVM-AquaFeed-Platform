# IF_ExecutionTransfer

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | Desktop–PLC integration boundary |
| Direction | Desktop to PLC request; PLC to Desktop acknowledgement |
| Version | 1.2 |

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
- all quantities, integer-unit setpoints, timings, positions, masks, and policies are within engineering limits
- current-release Dosing mask selects exactly one unit: `16#01` or `16#02`
- target line and required equipment configuration are compatible

## Integrity Handoff

The transfer owner validates both candidate CRC values and presents the combined result to LineManager as `xCandidateIntegrityValid`. LineManager does not recalculate CRCs; it accepts or rejects the already bounded atomic pair and copies accepted values into private storage.

Every processed `udiTransferSequence`, accepted or rejected, is idempotent. Changed payload requires a new sequence.

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

## Realtime Units

- feed quantity and tolerance: centi-kilograms
- Dosing speed: permille
- Blower frequency: centi-Hz
- floating-point values are excluded from the accepted PLC execution pair

## Related Documents

- [ST_JobExecution](../02_Structures/ST_JobExecution.md)
- [ST_RecipeExecution](../02_Structures/ST_RecipeExecution.md)
- [IF_Line](IF_Line.md)
- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.1 | 2026-07-26 | Normalized the atomic execution transfer contract. |
| 1.2 | 2026-07-26 | Assigned CRC validation to the transfer owner and defined the LineManager integrity input. |
