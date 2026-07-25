# IF_Recovery

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.0 |

## Request

| Name | Type | Description |
|---|---|---|
| `xEvaluateRequest` | BOOL | Requests checkpoint evaluation. |
| `xResumeApproval` | BOOL | Local/operator-approved resume request. |
| `xRejectRequest` | BOOL | Rejects/abandons checkpoint. |
| `udiRecoverySequence` | UDINT | Idempotent request sequence. |

## Conditions

Safety status, stopped-equipment proof, current job/recipe identity, configuration, IO, communication, selector, blower, dosing, and Desktop cancellation sequence are explicit inputs.

## Output

| Name | Type | Description |
|---|---|---|
| `stRecovery` | ST_RecoveryStatus | Current recovery result. |
| `xResumeCommandAccepted` | BOOL | One-scan acceptance event; not a motor start. |
| `xRequestRejected` | BOOL | One-scan rejection event. |

Power return, communication return, reset, or snapshot presence alone never generates resume acceptance.
