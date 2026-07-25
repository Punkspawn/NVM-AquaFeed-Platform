# IF_Selector

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 2.1 |

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
| `stConfig` | ST_SelectorConfig | Approved bounded calibration and timeout configuration. |
| `udiMonotonicTickMs` | UDINT | Wrap-safe monotonic time source for movement and settling. |

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

## Configuration Boundary

- maximum configured outlet capacity is 64; the physical outlet count remains project data
- outlet positions and calibrated flags are retentive commissioning data
- `SelectorLinearLimited` uses directional limits and homes logically left before verifying outlet 1
- `SelectorCyclic360` ignores directional limits, requires absolute cyclic position feedback, and selects the shortest permitted direction
- cyclic positions use `0..diCycleLength-1`; wrap distance is evaluated across zero
- tolerance must be positive; settle and movement timeouts must be non-zero
- the current 12-outlet machine is represented by `uiOutletCount := 12`; this is configuration, not a software limit
- manual jog remains disabled until explicit hold-to-run command fields and maximum jog duration are approved
