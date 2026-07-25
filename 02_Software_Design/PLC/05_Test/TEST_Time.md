# TEST_Time

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_TimeService, ST_TimeService, IF_Time |

| ID | Test | Expected result |
|---|---|---|
| TIM-001 | 1000 ms monotonic progress | exactly one one-second event |
| TIM-002 | scan jitter around second boundary | no missed or duplicate event |
| TIM-003 | millisecond tick wrap | elapsed calculation remains correct |
| TIM-004 | replay sync sequence | no second acceptance |
| TIM-005 | wall clock jumps forward | timers/runtime unchanged |
| TIM-006 | wall clock jumps backward | timers/runtime unchanged |
| TIM-007 | invalid UTC range | sync rejected; prior observation retained |
| TIM-008 | Desktop disconnected | monotonic ticks continue; wall clock becomes stale/degraded by policy |
| TIM-009 | second sequence near maximum | saturates; diagnostic; no wrap |
| TIM-010 | PLC restart | safe initialization; no false timeout or duplicate second |
| TIM-011 | timezone/DST boundary | no PLC control effect |
| TIM-012 | long-duration timer | wrap-safe behavior within approved bound |
