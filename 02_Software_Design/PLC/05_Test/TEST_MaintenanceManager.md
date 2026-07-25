# TEST_MaintenanceCounter

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_MaintenanceCounter, ST_MaintenanceCounter, IF_MaintenanceCounter |

| ID | Test | Expected result |
|---|---|---|
| MNT-001 | Independent device runtimes | Counters do not interfere |
| MNT-002 | Reach service interval | ServiceDue becomes true |
| MNT-003 | Exceed interval + grace | ServiceOverdue true; overdue seconds correct |
| MNT-004 | Valid reset in safe Service mode | Baseline becomes current lifetime; ResetCount +1 |
| MNT-005 | Valid reset | LifetimeRuntimeSec does not reset |
| MNT-006 | Reset while equipment running | Rejected |
| MNT-007 | Reset outside Service permission | Rejected |
| MNT-008 | Replay reset sequence | Idempotent; ResetCount unchanged |
| MNT-009 | Power cycle | Lifetime, baseline, interval, and reset sequence retained |
| MNT-010 | Near-maximum counters | Saturation diagnostic; no wrap |
| MNT-011 | Desktop offline | Runtime and due flags continue |
| MNT-012 | Reconnect | Events synchronize without duplicate maintenance history |

Desktop tests separately verify user authorization, work orders, notes, dates, plans, parts, cost, and permanent history.
