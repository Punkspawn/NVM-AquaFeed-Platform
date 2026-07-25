# IF_Dosing

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 2.1 |

## Accepted Transaction Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables dosing control. |
| `xStartRequest` / `xStopRequest` | BOOL | Transaction commands. |
| `udiCommandSequence` | UDINT | Idempotent transaction sequence. |
| `udiResetSequence` | UDINT | Idempotent fault-reset sequence; reset never starts dosing. |
| `udiJobId` | UDINT | Accepted job identity. |
| `uiOutletId` | UINT | Latched selector outlet. |
| `udiTargetCentiKg` | UDINT | Target; 1 count = 0.01 kg. |
| `uiTargetSpeedPermille` | UINT | 0–1000 bounded speed reference. |
| `udiCentiKgPer1000Pulses` | UDINT | Integer calibration factor. |
| `uiCalibrationVersion` | UINT | Approved calibration identity. |

## Interlocks and Feedback

| Name | Type | Description |
|---|---|---|
| `xSelectorInPosition` | BOOL | Selector at latched outlet. |
| `xBlowerAtSpeed` | BOOL | Stable transport airflow. |
| `xFeedAvailable` / `xSafetyOK` | BOOL | Required permissions. |
| `xDriveRunning` / `xDriveFault` | BOOL | Dosing drive feedback. |
| `xPulse` | BOOL | Validated one-scan pulse event. |

## Configuration and Time

| Name | Type | Description |
|---|---|---|
| `stConfig` | ST_DosingConfig | Approved quantity, calibration, speed, tolerance, rate, and timeout bounds. |
| `udiMonotonicTickMs` | UDINT | Monotonic millisecond tick for wrap-safe elapsed checks. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `eState` | E_DosingState | Current state. |
| `xMotorRunRequest` | BOOL | Logical dosing output. |
| `uiSpeedPermille` | UINT | Applied requested speed, 0–1000. |
| `xReady` / `xRunning` / `xFault` | BOOL | Current status. |
| `xCompletedEvent` | BOOL | One-scan successful completion event. |
| `udiDeliveredCentiKg` | UDINT | Frozen/current transaction quantity. |
| `udiDeliveredIncrementCentiKg` | UDINT | Validated new increment for runtime accounting. |
| `uiDiagnosticCode` | UINT | Stable reason code. |
| `udiLastAcceptedSequence` | UDINT | Replay protection. |

Parameter changes after command acceptance are ignored and diagnosed. A fault reset requires a new reset sequence, stopped command/output, removed fault cause, and all start interlocks healthy; it produces no automatic restart.
