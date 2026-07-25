# IF_Device

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.0 |

## Inputs

| Name | Type | Description |
|---|---|---|
| `uiDeviceId` | UINT | Non-zero static device identity. |
| `uiDeviceType` | UINT | Non-zero approved device profile/type. |
| `usiLineId` | USINT | Owning line; zero is permitted for a global auxiliary device. |
| `xEnableConfig` | BOOL | Approved configuration enables the device. |
| `xAutoRequest` / `xManualRequest` | BOOL | Mutually exclusive current mode requests. |
| `xRunFeedback` | BOOL | Confirmed equipment/field running feedback. |
| `xFaultFeedback` | BOOL | Current equipment-specific fault. |
| `xInterlockOK` | BOOL | Current combined common operational interlocks. |
| `xCommunicationOK` | BOOL | Required feedback communication is current; TRUE for approved hardwired-only devices. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `stDevice` | ST_Device | Current common device snapshot. |
| `xReady` | BOOL | Device available with exactly one valid mode. |
| `xCommandConflict` | BOOL | Auto and Manual requested simultaneously. |
| `xUnexpectedRunFeedback` | BOOL | Running feedback exists while common permission is invalid. |
| `uiDiagnosticCode` | UINT | Stable fixed-priority current reason. |

## Rules

The interface has no reset or physical command. All outputs are derived every scan; AlarmManager owns event lifecycle.
