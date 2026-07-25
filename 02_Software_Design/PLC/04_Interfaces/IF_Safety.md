# IF_Safety

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC boundary |
| Version | 1.1 |

## Observed Hardware Feedback

| Name | Type | Description |
|---|---|---|
| `xFeedbackValid` | BOOL | Safety feedback mapping/plausibility valid. |
| `xEmergencyActive` | BOOL | Observed E-stop circuit active. |
| `xSafetyRelayHealthy` | BOOL | Observed safety relay status. |
| `xSTOFeedbackHealthy` | BOOL | Upstream-validated STO feedback plausibility; not an STO command. |
| `xContactorFeedbackHealthy` | BOOL | Upstream-validated contactor feedback plausibility; not a raw coil command/state comparison. |
| `xStandardControlPermitRequest` | BOOL | Requests standard PLC control permission after safety restoration; never commands safety hardware. |

## Reset Conditions

| Name | Type | Description |
|---|---|---|
| `xLocalResetRequest` | BOOL | Local acknowledgement request. |
| `udiResetSequence` | UDINT | Idempotent reset sequence. |
| `xEquipmentStopped` | BOOL | All controlled equipment stopped. Reset also requires the standard-control permit request to be false. |

## Output

| Name | Type | Description |
|---|---|---|
| `stSafety` | ST_SafetyStatus | Observed status and standard-control permits. |
| `xResetAccepted` / `xResetRejected` | BOOL | One-scan result events. |

No remote reset, bypass, force, simulation, STO command, or safety relay command is exposed.

## Rules

- Feedback inputs are validated observations from approved IO mapping; this interface does not interpret raw dual-channel timing or implement safety diagnostics.
- Startup, invalid feedback, a trip, or feedback fault latches ResetRequired and keeps every permit false.
- A valid local reset requires healthy feedback, inactive emergency, stopped equipment, a new sequence, and StandardControlPermitRequest false.
- Clearing ResetRequired never grants a permit in the reset scan. A later permit request is required.
- Automatic, Motion, Blower, and Dosing permits share the same safety-coordination gate; equipment blocks still apply their own operational interlocks.
- Recovery is permitted only while the safety gate is clear and equipment is stopped.

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Defined the standard-PLC safety observation boundary. |
| 1.1 | 2026-07-26 | Added the explicit standard-control permit request and restart-safe reset conditions. |
