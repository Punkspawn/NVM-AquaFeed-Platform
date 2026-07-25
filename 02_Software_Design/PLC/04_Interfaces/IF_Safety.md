# IF_Safety

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC boundary |
| Version | 1.0 |

## Observed Hardware Feedback

| Name | Type | Description |
|---|---|---|
| `xFeedbackValid` | BOOL | Safety feedback mapping/plausibility valid. |
| `xEmergencyActive` | BOOL | Observed E-stop circuit active. |
| `xSafetyRelayHealthy` | BOOL | Observed safety relay status. |
| `xSTOFeedbackHealthy` | BOOL | Observed STO feedback. |
| `xContactorFeedbackHealthy` | BOOL | Observed power-contactor feedback. |

## Reset Conditions

| Name | Type | Description |
|---|---|---|
| `xLocalResetRequest` | BOOL | Local acknowledgement request. |
| `udiResetSequence` | UDINT | Idempotent reset sequence. |
| `xEquipmentStopped` | BOOL | All controlled equipment stopped. |

## Output

| Name | Type | Description |
|---|---|---|
| `stSafety` | ST_SafetyStatus | Observed status and standard-control permits. |
| `xResetAccepted` / `xResetRejected` | BOOL | One-scan result events. |

No remote reset, bypass, force, simulation, STO command, or safety relay command is exposed.
