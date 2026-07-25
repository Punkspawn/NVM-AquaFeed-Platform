# TEST_Recovery

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_RecoveryManager, E_RecoveryState, ST_RecoveryStatus, IF_Recovery |

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
