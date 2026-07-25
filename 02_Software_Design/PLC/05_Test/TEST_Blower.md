# TEST_Blower

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_Blower, E_BlowerState, IF_Blower |

| ID | Test | Expected result |
|---|---|---|
| BLW-001 | Valid start | Run issued; acceleration monitored |
| BLW-002 | Stable target frequency | AtSpeed after full stable interval |
| BLW-003 | Frequency oscillates near tolerance | stable timer restarts; no early permission |
| BLW-004 | Start/acceleration timeout | Run removed; Fault |
| BLW-005 | VFD communication loss | Run removed; dosing permission false |
| BLW-006 | Drive fault | immediate critical stop; stable code |
| BLW-007 | Normal dosing completion | post-run maintained for configured time |
| BLW-008 | Safety loss during post-run | Run removed immediately |
| BLW-009 | Stop feedback timeout | Fault; no Ready |
| BLW-010 | Out-of-range frequency | command rejected |
| BLW-011 | Replay command sequence | no duplicate start |
| BLW-012 | Reset with active drive fault | rejected |
| BLW-013 | Reset after cause removed | Ready; no automatic restart |
| BLW-014 | Counter/time boundary | bounded arithmetic; no wrap |
