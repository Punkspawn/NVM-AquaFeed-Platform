# TEST_Communication

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_CommunicationManager, ST_CommunicationChannel, IF_Communication |

| ID | Test | Expected result |
|---|---|---|
| COM-001 | Desktop TCP read | explicit map read succeeds |
| COM-002 | Supported map write | sequence/payload accepted once |
| COM-003 | Duplicate Desktop command | no duplicate PLC action |
| COM-004 | Unsupported major map version | read-only diagnostic mode |
| COM-005 | Static heartbeat | freshness becomes false |
| COM-006 | Desktop disconnect during healthy active job | job continues; new transfer blocked |
| COM-007 | Reconnect with old sequences | stale writes rejected; state reconciled |
| COM-008 | One RTU VFD response | channel fresh; counters exact |
| COM-009 | RTU timeout and bounded retry | finite retries; fault after configured threshold |
| COM-010 | VFD communication loss while blower runs | communication fault published; blower contract removes Run |
| COM-011 | CRC/protocol error | invalid payload ignored; error count +1 |
| COM-012 | Counter near maximum | saturation; no wrap |
| COM-013 | Tick wrap during timeout | timeout remains correct |
| COM-014 | Maximum configured channels | bounded work meets scan budget |
| COM-015 | Two RTU requests same bus | only one transaction active |
| COM-016 | Counter reset without Service permission | rejected |
| COM-017 | Counter reset with active fault | counters reset by policy; current fault remains true |
| COM-018 | 72-hour endurance | no queue growth, blocking, or sequence corruption |

Desktop/Edge separately verifies VPN, cloud, MQTT, OPC UA, databases, remote sessions, and persistent logs.
