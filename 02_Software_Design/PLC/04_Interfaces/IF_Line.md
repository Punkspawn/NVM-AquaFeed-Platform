# IF_Line

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Producer | `FB_LineManager` |
| Version | 2.3 |

## System Commands and Conditions

| Name | Type | Description |
|---|---|---|
| `xEnableFromSystem` | BOOL | Global permission from SystemManager. |
| `xStart` / `xPause` / `xStop` / `xCancel` | BOOL | Requested line action. |
| `udiCommandSequence` | UDINT | Idempotent line-command identity. |
| `udiResetSequence` | UDINT | Idempotent reset identity. |
| `xEmergencyStop` | BOOL | Highest-priority emergency input. |
| `xSafetyOK` | BOOL | Approved line safety summary. |
| `xBlockingFault` | BOOL | Fault that prevents or stops execution. |
| `xDesktopCommunicationOK` | BOOL | Diagnostic link; does not stop a healthy active job. |
| `stConfig` | ST_LineConfig | Static approved line/equipment bounds. |
| `udiMonotonicTickMs` | UDINT | Wrap-safe control timebase. |

## Candidate Execution Snapshot

| Name | Type | Description |
|---|---|---|
| `xJobAvailable` / `xAcceptJob` | BOOL | Complete candidate and one-scan acceptance request. |
| `xCandidateIntegrityValid` | BOOL | Transfer owner has validated atomic payload completeness and CRC; false candidates are rejected. |
| `stJobCandidate` | ST_JobExecution | Candidate immutable job snapshot. |
| `stRecipeCandidate` | ST_RecipeExecution | Candidate immutable recipe snapshot. |

Accepted candidates are copied into private immutable storage. Current release accepts one Dosing unit per job: mask `16#01` or `16#02`.

## Equipment Feedback Inputs

| Name | Type | Description |
|---|---|---|
| `xSelectorReady` | BOOL | Selector accepts a new move. |
| `xSelectorInPosition` | BOOL | Selector is settled at its reported outlet. |
| `uiSelectorOutlet` | UINT | Confirmed outlet; zero means unknown. |
| `xSelectorFault` | BOOL | Selector blocking fault. |
| `xBlowerReady` / `xBlowerRunning` / `xBlowerAtSpeed` | BOOL | Normalized Blower status. |
| `xBlowerDosingPermitted` | BOOL | Stable airflow permission from FB_Blower. |
| `xBlowerFault` | BOOL | Blower blocking fault. |
| `xDosing1Ready` / `xDosing1Running` / `xDosing1Fault` | BOOL | Dosing 1 status. |
| `xDosing1CompletedEvent` | BOOL | One-scan successful Dosing 1 completion. |
| `udiDosing1DeliveredCentiKg` | UDINT | Current/frozen Dosing 1 transaction quantity. |
| `udiDosing1IncrementCentiKg` | UDINT | One-scan validated Dosing 1 increment. |
| `xDosing2Ready` / `xDosing2Running` / `xDosing2Fault` | BOOL | Dosing 2 status. |
| `xDosing2CompletedEvent` | BOOL | One-scan successful Dosing 2 completion. |
| `udiDosing2DeliveredCentiKg` | UDINT | Current/frozen Dosing 2 transaction quantity. |
| `udiDosing2IncrementCentiKg` | UDINT | One-scan validated Dosing 2 increment. |

## Equipment Command Outputs

| Name | Type | Description |
|---|---|---|
| `xSelectorMoveRequest` | BOOL | Move to accepted outlet. |
| `uiSelectorTargetOutlet` | UINT | Accepted outlet. |
| `udiSelectorCommandSequence` | UDINT | Selector command identity. |
| `xBlowerRunRequest` | BOOL | Maintain airflow. |
| `xBlowerNormalStopRequest` | BOOL | Execute controlled Blower post-run/stop. |
| `uiBlowerTargetFreqCentiHz` | UINT | Accepted Blower frequency. |
| `udiBlowerRequestedPostRunTimeMs` | UDINT | Accepted recipe post-run, latched by FB_Blower with the run command. |
| `udiBlowerCommandSequence` | UDINT | Blower command identity. |
| `xDosing1StartRequest` / `xDosing1StopRequest` | BOOL | Dosing 1 transaction command. |
| `udiDosing1CommandSequence` | UDINT | Dosing 1 transaction identity. |
| `udiDosing1JobId` | UDINT | Accepted job identity. |
| `uiDosing1OutletId` | UINT | Accepted selector outlet. |
| `udiDosing1TargetCentiKg` | UDINT | Selected transaction target or trusted remaining target on resume. |
| `uiDosing1SpeedPermille` | UINT | Accepted Dosing speed. |
| `xDosing2StartRequest` / `xDosing2StopRequest` | BOOL | Dosing 2 transaction command. |
| `udiDosing2CommandSequence` | UDINT | Dosing 2 transaction identity. |
| `udiDosing2JobId` | UDINT | Accepted job identity. |
| `uiDosing2OutletId` | UINT | Accepted selector outlet. |
| `udiDosing2TargetCentiKg` | UDINT | Selected transaction target or trusted remaining target on resume. |
| `uiDosing2SpeedPermille` | UINT | Accepted Dosing speed. |
| `xEquipmentResetRequest` | BOOL | One-scan reset after line reset acceptance. |
| `udiEquipmentResetSequence` | UDINT | Shared accepted reset identity. |

Static Dosing calibration and equipment configuration are wired from approved configuration storage directly to each equipment block; LineManager does not modify them.

## Published Outputs

| Name | Type | Description |
|---|---|---|
| `stLine` | ST_Line | Authoritative bounded realtime snapshot. |
| `xReady` / `xBusy` | BOOL | Convenience status. |
| `xCompleted` | BOOL | One-scan successful completion event. |
| `xJobAccepted` / `xJobRejected` | BOOL | One-scan transfer result. |
| `uiResultCode` | UINT | Bounded completion, cancellation, fault, or rejection reason. |
| `udiLastAcceptedCommandSequence` | UDINT | Line-command replay protection. |

## Contract Rules

- No job is accepted while Desktop communication is unavailable.
- A healthy active job continues during Desktop communication loss.
- Dosing Start requires Selector at the accepted outlet and Blower dosing permission.
- Only the mask-selected Dosing unit may receive Start.
- Stop, Cancel, Fault, and Emergency remove Dosing Start before airflow shutdown unless safety engineering requires immediate removal of all commands.
- Resume and Recovery never enter directly into Dosing.
- Only LineManager writes `ST_Line`.
- Equipment outputs are requests to equipment Function Blocks, never physical outputs.
- Completion, acceptance, and rejection events are emitted exactly once.
- No REAL value is used across the realtime LineManager/equipment boundary.

## Related Documents

- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [ST_Line](../02_Structures/ST_Line.md)
- [ST_LineConfig](../02_Structures/ST_LineConfig.md)
- [IF_ExecutionTransfer](IF_ExecutionTransfer.md)
