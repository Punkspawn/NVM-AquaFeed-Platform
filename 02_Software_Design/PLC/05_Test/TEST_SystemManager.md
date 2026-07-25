# TEST_SystemManager

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_SystemManager, E_SystemState, ST_SystemStatus, IF_System |
| Version | 2.0 |

| ID | Test | Expected result |
|---|---|---|
| SYS-001 | Disabled, healthy system | state Off; LineEnable false |
| SYS-002 | Healthy enable with one valid mode and ready lines | Initializing reaches Ready deterministically |
| SYS-003 | No mode request | not Ready; all mode outputs false |
| SYS-004 | Two or more mode requests | ModeConflict true; not Ready; LineEnable false |
| SYS-005 | Automatic Start rising edge | Ready transitions once to Running |
| SYS-006 | Held Start through later stop cycle | no automatic restart without a new rising edge |
| SYS-007 | Running Pause rising edge | state Paused; automatic line permission remains safety-gated |
| SYS-008 | Paused Start rising edge | returns to Running only with valid Automatic mode and ready lines |
| SYS-009 | Stop from Ready, Running, or Paused | state Stopping until AllLinesStopped |
| SYS-010 | Automatic-mode loss while Running or Paused | controlled Stopping; no continued production state |
| SYS-011 | Emergency from every state | state Emergency; SystemReady and LineEnable false |
| SYS-012 | Safety loss or blocking fault from every state | state Fault; SystemReady and LineEnable false |
| SYS-013 | Reset while cause active | rejected; state remains Fault or Emergency |
| SYS-014 | Reset after cause removed but lines not stopped | rejected |
| SYS-015 | Valid Reset rising edge | one-scan ResetAccepted; state Initializing; no automatic restart |
| SYS-016 | Held Reset | no repeated acceptance event |
| SYS-017 | Desktop communication loss while Running | running lifecycle unchanged; status flag false |
| SYS-018 | Manual, Service, or Simulation mode | mutually exclusive status; automatic LineEnable false |
| SYS-019 | Feeding inactive | CurrentLine, ActiveRecipeId, and CurrentJobId publish zero |
| SYS-020 | Feeding active with bounded summary | supplied current references are published without business/history data |
| SYS-021 | Undefined internal state | fail-closed Fault state |
| SYS-022 | Status invariants | one primary state; Running implies AutoMode; ModeConflict implies not Ready |

## Gate

Implementation is accepted only when all state transitions are deterministic, command replay is prevented, safety priority is preserved, and Desktop communication remains diagnostic rather than a safety interlock.
