# TEST_Recovery

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_RecoveryManager v3.1, E_RecoveryState, ST_RecoveryStatus v1.1, IF_Recovery v1.1 |

| ID | Test | Expected result |
|---|---|---|
| REC-001 | Valid retained checkpoint | RecoveryAvailable; no output start |
| REC-002 | Bad CRC/version | Rejected |
| REC-003 | Job/recipe identity mismatch | Rejected |
| REC-004 | Ambiguous delivered quantity | Rejected; Desktop reconciliation required |
| REC-005 | Power return | outputs safe; approval required |
| REC-006 | Safety reset incomplete | resume rejected |
| REC-007 | Equipment feedback unknown | resume rejected |
| REC-008 | Newer Desktop cancellation | checkpoint rejected |
| REC-009 | Replay recovery sequence | idempotent; no second acceptance |
| REC-010 | Approved selector checkpoint | position revalidated before continuation |
| REC-011 | Approved partial dosing checkpoint | remaining target guarded; no duplicate quantity |
| REC-012 | Failure during reinitialization | Failed; outputs safe |
| REC-013 | Snapshot present after completion | no false resume |
| REC-014 | Communication return only | no automatic recovery |
| REC-015 | Candidate buffer changes after Evaluate | private checkpoint remains immutable |
| REC-016 | Delivered quantity greater than target | rejected without unsigned underflow |
| REC-017 | Retry count equals/exceeds maximum | rejected |
| REC-018 | Job recovery policy disabled | rejected |
| REC-019 | Completed or cancelled checkpoint | rejected |
| REC-020 | Evaluate/Approve/Reject command conflict | rejected; state unchanged |
| REC-021 | Approval with a changed live prerequisite | rejected; no ReinitializeRequest |
| REC-022 | Valid approval sequence | one-scan acceptance; Reinitializing; no motor start command |
| REC-023 | ReinitializationComplete and ReinitializationFailed together | Failed; approved handoff invalid |
| REC-024 | ReadyToResume without LineResumeAccepted | remains ready; no automatic LineManager start |
| REC-025 | Explicit LineResumeAccepted | Completed handshake exactly once |
| REC-026 | Reject request from pending recovery | checkpoint/handoff invalidated; no equipment command |
| REC-027 | Replay accepted or rejected sequence | idempotent; no second event or transition |
| REC-028 | Undefined state or sequence exhaustion | fail closed with bounded result |
| REC-029 | Remaining target calculation | Target minus trustworthy Delivered, bounded without wrap |
