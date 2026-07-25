# IF_Line

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Producer | `FB_LineManager` |
| Version | 2.0 |

## Purpose

Defines the command, condition, equipment-feedback, and published-status contract for one feeding line.

## System Commands and Conditions

| Name | Type | Description |
|---|---|---|
| `xEnableFromSystem` | BOOL | Global permission from SystemManager. |
| `xStart` | BOOL | Starts an accepted job or resumes from Paused. |
| `xPause` | BOOL | Requests controlled pause. |
| `xStop` | BOOL | Requests controlled stop. |
| `xCancel` | BOOL | Cancels active execution after safe shutdown. |
| `xReset` | BOOL | Requests reset after fault conditions are removed. |
| `xEmergencyStop` | BOOL | Active emergency input; highest priority. |
| `xSafetyOK` | BOOL | Approved line safety summary. |
| `xBlockingFault` | BOOL | Fault that prevents or stops execution. |
| `xDesktopCommunicationOK` | BOOL | Diagnostic link state; does not stop a healthy active job. |

## Active Execution Snapshot

| Name | Type | Description |
|---|---|---|
| `xJobAvailable` | BOOL | A complete candidate snapshot is available. |
| `stActiveJob` | ST_JobExecution | Bounded candidate job snapshot. |
| `stActiveRecipe` | ST_RecipeExecution | Bounded candidate recipe snapshot. |
| `xAcceptJob` | BOOL | One-scan acceptance request; LineManager copies and locks required fields. |

Candidates are accepted through `IF_ExecutionTransfer`. After acceptance, LineManager copies them to private immutable storage; later Desktop changes do not modify active execution.

## Equipment Feedback Inputs

| Name | Type | Description |
|---|---|---|
| `xSelectorReady` | BOOL | Selector available for command. |
| `xSelectorAtTarget` | BOOL | Target position is confirmed. |
| `uiSelectorPosition` | USINT | Confirmed current position. |
| `xSelectorFault` | BOOL | Selector blocking fault. |
| `xBlowerReady` | BOOL | Blower available for command. |
| `xBlowerRunning` | BOOL | Blower running feedback. |
| `xBlowerFault` | BOOL | Blower blocking fault. |
| `xDosing1Ready` | BOOL | First Dosing unit available. |
| `xDosing1Running` | BOOL | First Dosing running feedback. |
| `xDosing1Fault` | BOOL | First Dosing blocking fault. |
| `xDosing2Ready` | BOOL | Optional second Dosing unit available. |
| `xDosing2Running` | BOOL | Optional second Dosing running feedback. |
| `xDosing2Fault` | BOOL | Optional second Dosing blocking fault. |
| `rDeliveredFeedKg` | REAL | Validated cumulative delivered quantity. |

## Equipment Command Outputs

| Name | Type | Description |
|---|---|---|
| `xSelectorMoveRequest` | BOOL | Requests Selector movement. |
| `uiSelectorTarget` | USINT | Accepted immutable target position. |
| `xBlowerRunRequest` | BOOL | Requests Blower operation. |
| `rBlowerSetpoint` | REAL | Accepted bounded Blower setpoint. |
| `xDosing1RunRequest` | BOOL | Requests first Dosing operation. |
| `xDosing2RunRequest` | BOOL | Requests optional second Dosing operation. |
| `rDosingSetpoint` | REAL | Accepted bounded Dosing setpoint. |
| `xEquipmentResetRequest` | BOOL | One-scan reset after LineManager acceptance rules pass. |

## Published Outputs

| Name | Type | Description |
|---|---|---|
| `stLine` | ST_Line | Authoritative bounded realtime snapshot. |
| `xReady` | BOOL | Convenience output matching `stLine.Ready`. |
| `xBusy` | BOOL | Line owns an active job or safe shutdown. |
| `xCompleted` | BOOL | One-scan successful completion event. |
| `xJobAccepted` | BOOL | One-scan acceptance acknowledgement. |
| `xJobRejected` | BOOL | One-scan rejection event with reason ID. |
| `uiResultCode` | UINT | Bounded completion, cancellation, or rejection code. |

## Contract Rules

- No job is accepted while Desktop communication is unavailable.
- A healthy active job continues during Desktop communication loss.
- Dosing command requires Selector at target and Blower running.
- Stop, Cancel, Fault, and Emergency remove Dosing command before airflow shutdown unless approved safety engineering requires a more immediate action.
- Resume and Recovery never enter directly into Dosing.
- Only LineManager writes `ST_Line`.
- Equipment outputs are requests to equipment Function Blocks, never direct physical outputs.
- Completion, acceptance, and rejection events are emitted exactly once per transaction.

## Related Documents

- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [ST_Line](../02_Structures/ST_Line.md)
- [E_LineState](../02_Structures/E_LineState.md)
- [FB_SystemManager](../01_Function_Blocks/FB_SystemManager.md)
- [IF_ExecutionTransfer](IF_ExecutionTransfer.md)
- [ST_JobExecution](../02_Structures/ST_JobExecution.md)
- [ST_RecipeExecution](../02_Structures/ST_RecipeExecution.md)

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | Legacy | Initial minimal line interface. |
| 2.0 | 2026-07-25 | Consolidated command, feedback, equipment request, and status contract. |
