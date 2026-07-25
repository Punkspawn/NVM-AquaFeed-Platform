# TEST_Health

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_HealthMonitor, ST_HealthStatus, IF_Health |

| ID | Test | Expected result |
|---|---|---|
| HLT-001 | Initial all-healthy snapshot | both permissions true; no transition event |
| HLT-002 | Desktop heartbeat lost | new-job false; current-job continuation true; degraded |
| HLT-003 | Desktop heartbeat restored | degradation clears; one transition event |
| HLT-004 | Safety unhealthy | both permissions false; reason priority Safety; severity 40 |
| HLT-005 | Configuration invalid | blocking reason Configuration |
| HLT-006 | Required IO invalid | blocking reason IO |
| HLT-007 | System not operational | blocking reason System |
| HLT-008 | Required field communication lost | both permissions false |
| HLT-009 | Selector unhealthy | assigned execution path blocked |
| HLT-010 | Blower unhealthy | assigned execution path blocked |
| HLT-011 | Dosing unhealthy | assigned execution path blocked |
| HLT-012 | Blocking diagnostic | both permissions false |
| HLT-013 | Non-blocking diagnostic | Degraded true; both permissions otherwise remain true |
| HLT-014 | Simultaneous failures | fixed blocking priority is stable |
| HLT-015 | Diagnostic severity above 40 | published severity clamped to 40 |
| HLT-016 | Source condition clears | current status clears; one transition event |
| HLT-017 | Unchanged replay | no repeated transition event or sequence advance |
| HLT-018 | Status sequence at maximum | saturates without wrap |
| HLT-019 | Wall-clock change | no health effect |
| HLT-020 | Maximum system composition | fixed work remains within scan budget |

Desktop/Edge separately owns health history, trend, notification, prediction, and reports.
