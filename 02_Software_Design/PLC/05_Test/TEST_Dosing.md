# TEST_Dosing

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_Dosing, E_DosingState, IF_Dosing |

| ID | Test | Expected result |
|---|---|---|
| DOS-001 | Valid transaction | parameters latched; motor starts |
| DOS-002 | Selector not in position | start rejected |
| DOS-003 | Blower not AtSpeed | start rejected |
| DOS-004 | First-pulse timeout | motor off; Fault |
| DOS-005 | Pulse conversion | centi-kg result matches integer calibration |
| DOS-006 | Target reached | motor stops; one Complete event |
| DOS-007 | Replay command sequence | no second transaction/completion |
| DOS-008 | Target/calibration changed while running | latched values unchanged; diagnostic |
| DOS-009 | Pulse while stopped | unexpected-pulse diagnostic |
| DOS-010 | No-flow during run | motor off; Fault |
| DOS-011 | Selector/blower/safety loss | immediate motor request removal; not Complete |
| DOS-012 | Feed unavailable | safe stop; stable reason |
| DOS-013 | Normal stop before target | stopped; not Complete |
| DOS-014 | Near arithmetic maximum | saturation diagnostic; no wrap |
| DOS-015 | Power cycle mid-transaction | safe output; incomplete transaction not reported Complete |
| DOS-016 | Delivered increment publication | each accepted increment counted once |
