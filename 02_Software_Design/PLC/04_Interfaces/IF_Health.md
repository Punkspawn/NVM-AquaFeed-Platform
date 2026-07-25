# IF_Health

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 1.1 |

## Inputs

| Name | Type | Description |
|---|---|---|
| `xSystemOperational` | BOOL | System lifecycle permits controlled operation. |
| `xSafetyHealthy` | BOOL | SafetyCoordinator permits standard-control evaluation. |
| `xIOHealthy` | BOOL | Required process image is valid. |
| `xRequiredCommunicationHealthy` | BOOL | Required field-device feedback is current. |
| `xDesktopCommunicationHealthy` | BOOL | Desktop transfer heartbeat is current. |
| `xSelectorHealthy` / `xBlowerHealthy` / `xDosingHealthy` | BOOL | Assigned equipment path is healthy. |
| `xConfigurationValid` | BOOL | Approved runtime configuration is valid. |
| `xDiagnosticsBlocking` | BOOL | Diagnostics publishes a current blocking condition. |
| `xDiagnosticsDegraded` | BOOL | Diagnostics publishes a current non-blocking degradation. |
| `uiDiagnosticsSeverity` | UINT | Bounded current severity, 0..40. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `stHealth` | ST_HealthStatus | Current readiness/degradation snapshot. |
| `xTransitionEvent` | BOOL | One-scan material status transition after initialization. |
| `uiTransitionCode` | UINT | Current stable blocking or degraded reason. |

## Rules

- no reset, acknowledgement, output, score, history, or wall-clock input
- new-job readiness additionally requires Desktop communication
- Desktop communication alone never removes current-job continuation
- fixed priority resolves simultaneous conditions
- unchanged inputs emit no repeated transition

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Defined bounded health boundary. |
| 1.1 | 2026-07-26 | Added explicit source inputs and transition semantics. |
