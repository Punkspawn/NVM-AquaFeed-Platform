# IF_Blower

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / VFD boundary |
| Version | 2.2 |

## Commands

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables control. |
| `xRunRequest` | BOOL | Requests transport airflow. |
| `xNormalStopRequest` | BOOL | Requests controlled stop/post-run. |
| `uiTargetFreqCentiHz` | UINT | Frequency reference; 1 count = 0.01 Hz. |
| `udiRequestedPostRunTimeMs` | UDINT | Accepted job post-run; zero selects configured default, nonzero must not exceed the configured maximum. |
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

## Configuration and Time

| Name | Type | Description |
|---|---|---|
| `stConfig` | ST_BlowerConfig | Approved frequency bounds, tolerance, stable-time, start/acceleration/feedback/stop timeouts, and post-run limits. |
| `udiMonotonicTickMs` | UDINT | Monotonic millisecond tick used for wrap-safe elapsed-time checks. |

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

Frequency and requested post-run are latched together with the accepted command. Later input changes do not alter the active run. Critical stop conditions remove Run without waiting for post-run.
