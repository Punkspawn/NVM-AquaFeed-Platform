# IF_Selector

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 2.0 |

## Commands and Conditions

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables selector control. |
| `xHomeRequest` | BOOL | Requests homing. |
| `xMoveRequest` | BOOL | Requests move to target outlet. |
| `uiTargetOutlet` | UINT | Validated outlet identity. |
| `udiCommandSequence` | UDINT | Idempotent command sequence. |
| `udiResetSequence` | UDINT | Idempotent fault-reset sequence. |
| `xStopRequest` | BOOL | Highest-priority normal stop. |
| `xServicePermission` | BOOL | Local approved service permission. |
| `xSafetyOK` | BOOL | Standard-control safety permission. |

## Feedback

| Name | Type | Description |
|---|---|---|
| `diPosition` | DINT | Scaled integer selector position. |
| `xPositionValid` | BOOL | Position feedback validity. |
| `xLeftLimit` / `xRightLimit` | BOOL | Directional limit feedback. |
| `xMotorRunning` / `xMotorFault` | BOOL | Motor feedback. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `eState` | E_SelectorState | Current state. |
| `xMoveLeftRequest` / `xMoveRightRequest` | BOOL | Mutually exclusive logical outputs. |
| `xReady` / `xMoving` / `xInPosition` | BOOL | Bounded status. |
| `uiCurrentOutlet` | UINT | Confirmed outlet; zero when unknown. |
| `uiDiagnosticCode` | UINT | Stable reason code. |
| `udiLastAcceptedSequence` | UDINT | Command replay protection. |

Stop and safety loss override all movement requests. Physical outputs are written only by IO Manager.
