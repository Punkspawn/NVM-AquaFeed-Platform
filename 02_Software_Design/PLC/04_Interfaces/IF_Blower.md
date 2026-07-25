# IF_Blower

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / VFD boundary |
| Version | 2.0 |

## Commands

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables control. |
| `xRunRequest` | BOOL | Requests transport airflow. |
| `xNormalStopRequest` | BOOL | Requests controlled stop/post-run. |
| `uiTargetFreqCentiHz` | UINT | Frequency reference; 1 count = 0.01 Hz. |
| `udiCommandSequence` | UDINT | Idempotent run command. |
| `udiResetSequence` | UDINT | Idempotent reset request. |
| `xSafetyOK` | BOOL | Standard-control safety permission. |

## VFD Feedback

| Name | Type | Description |
|---|---|---|
| `xDriveReady` / `xDriveRunning` / `xDriveFault` | BOOL | Validated drive status. |
| `xCommunicationHealthy` | BOOL | VFD channel health. |
| `uiActualFreqCentiHz` | UINT | Actual frequency. |
| `uiDriveFaultCode` | UINT | Bounded VFD fault code. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `eState` | E_BlowerState | Current state. |
| `xDriveRunRequest` | BOOL | Logical VFD run command. |
| `uiDriveFreqCentiHz` | UINT | Bounded frequency command. |
| `xReady` / `xRunning` / `xAtSpeed` | BOOL | Current status. |
| `xDosingPermitted` | BOOL | True only with stable airflow conditions. |
| `uiDiagnosticCode` | UINT | Stable reason code. |
| `udiLastAcceptedSequence` | UDINT | Command replay protection. |

Critical stop conditions remove Run without waiting for post-run.
