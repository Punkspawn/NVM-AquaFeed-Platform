# TEST_Health

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_HealthMonitor, ST_HealthStatus, IF_Health |

| ID | Test | Expected result |
|---|---|---|
| HLT-001 | All required sources healthy | ReadyForNewJob true |
| HLT-002 | Desktop heartbeat lost while idle | new-job readiness false |
| HLT-003 | Desktop heartbeat lost during healthy accepted job | CurrentJobMayContinue true |
| HLT-004 | Safety unhealthy | both permissions false; blocking |
| HLT-005 | Required VFD feedback lost | owning job continuation false |
| HLT-006 | Non-blocking diagnostic | Degraded true; documented continuation policy |
| HLT-007 | Multiple conditions | highest severity and stable priority reason |
| HLT-008 | Source condition clears | current status clears; transition event once |
| HLT-009 | Replay unchanged inputs | no repeated transition event |
| HLT-010 | Maximum lines/channels | bounded execution |
| HLT-011 | Wall-clock change | no health effect |
| HLT-012 | Desktop attempts reset | no reset interface; status unchanged |
