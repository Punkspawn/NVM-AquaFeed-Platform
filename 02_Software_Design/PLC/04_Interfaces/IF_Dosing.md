# IF_Dosing

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 2.0 |

## Accepted Transaction Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables dosing control. |
| `xStartRequest` / `xStopRequest` | BOOL | Transaction commands. |
| `udiCommandSequence` | UDINT | Idempotent transaction sequence. |
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

Parameter changes after command acceptance are ignored and diagnosed.
