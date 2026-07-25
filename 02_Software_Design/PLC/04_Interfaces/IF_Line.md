# IF_Line

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Producer | `FB_LineManager` |
| Version | 2.1 |

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
| `udiMonotonicTickMs` | UDINT | Wrap-safe control timebase. |

## Candidate Execution Snapshot

| Name | Type | Description |
|---|---|---|
| `xJobAvailable` / `xAcceptJob` | BOOL | Complete candidate and one-scan acceptance request. |
| `stJobCandidate` | ST_JobExecution | Candidate immutable job snapshot. |
| `stRecipeCandidate` | ST_RecipeExecution | Candidate immutable recipe snapshot. |

Accepted candidates are copied into private immutable storage. Current release accepts one Dosing unit per job: mask `16#01` or `16#02`.

## Equipment Feedback Inputs

| Group | Signals |
|---|---|
| Selector | `xSelectorReady`, `xSelectorInPosition`, `uiSelectorOutlet`, `xSelectorFault` |
| Blower | `xBlowerReady`, `xBlowerRunning`, `xBlowerAtSpeed`, `xBlowerDosingPermitted`, `xBlowerFault` |
| Dosing 1 | `xDosing1Ready`, `xDosing1Running`, `xDosing1Fault`, `xDosing1CompletedEvent`, `udiDosing1DeliveredCentiKg`, `udiDosing1IncrementCentiKg` |
| Dosing 2 | Same fields with `Dosing2`; inactive unit remains uncommanded. |

## Equipment Command Outputs

| Group | Signals |
|---|---|
| Selector | `xSelectorMoveRequest`, `uiSelectorTargetOutlet`, `udiSelectorCommandSequence` |
| Blower | `xBlowerRunRequest`, `xBlowerNormalStopRequest`, `uiBlowerTargetFreqCentiHz`, `udiBlowerCommandSequence` |
| Dosing 1 | `xDosing1StartRequest`, `xDosing1StopRequest`, `udiDosing1CommandSequence`, accepted job/outlet/target/speed fields |
| Dosing 2 | Same fields with `Dosing2`; only the mask-selected unit may receive Start. |
| Reset | `xEquipmentResetRequest`, `udiEquipmentResetSequence`; emitted only after reset acceptance rules pass. |

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
- Stop, Cancel, Fault, and Emergency remove Dosing Start before airflow shutdown unless safety engineering requires immediate removal of all commands.
- Resume and Recovery never enter directly into Dosing.
- Only LineManager writes `ST_Line`.
- Equipment outputs are requests to equipment Function Blocks, never physical outputs.
- Completion, acceptance, and rejection events are emitted exactly once.
- No REAL value is used across the realtime LineManager/equipment boundary.

## Related Documents

- [FB_LineManager](../01_Function_Blocks/FB_LineManager.md)
- [ST_Line](../02_Structures/ST_Line.md)
- [IF_ExecutionTransfer](IF_ExecutionTransfer.md)
