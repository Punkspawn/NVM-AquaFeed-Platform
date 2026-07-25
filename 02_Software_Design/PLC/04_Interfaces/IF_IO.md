# IF_IO

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / physical IO boundary |
| Version | 2.0 |

## Hardware to IO Manager

| Name | Type | Description |
|---|---|---|
| `stRawInputs` | ST_IO | Raw physical input image and module validity. |
| `xHardwareConfigValid` | BOOL | Static mapping/configuration accepted. |
| `xWatchdogHealthy` | BOOL | Watchdog permits normal output application. |

## Application to IO Manager

| Name | Type | Description |
|---|---|---|
| `stRequestedOutputs` | ST_IO | Requested logical outputs. |
| `xOutputsPermitted` | BOOL | System-level output permission. |
| `xSafetyOK` | BOOL | Safety status used for standard-control inhibition. |
| `xCommissioningMode` | BOOL | Approved commissioning state. |
| `udiCommandSequence` | UDINT | Output-request sequence for diagnostics. |

## IO Manager to Application

| Name | Type | Description |
|---|---|---|
| `stValidatedInputs` | ST_IO | Stable validated input image for the scan. |
| `stAppliedOutputs` | ST_IO | Final output image after arbitration. |
| `xReady` | BOOL | IO mapping and required modules healthy. |
| `xFault` | BOOL | Blocking IO fault. |
| `uiDiagnosticCode` | UINT | Stable bounded reason code. |

## Rules

- one producer owns `stValidatedInputs` and `stAppliedOutputs`
- application blocks consume validated logical names, never hardware addresses
- output requests are intents; only IO Manager writes physical outputs
- invalid configuration or unsafe state forces the approved safe image
- command replay does not create extra output transitions
