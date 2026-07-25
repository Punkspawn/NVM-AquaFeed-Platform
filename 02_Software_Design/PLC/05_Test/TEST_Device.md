# TEST_Device

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_DeviceManager, ST_Device, IF_Device |

| ID | Test | Expected result |
|---|---|---|
| DEV-001 | Zero DeviceId | invalid configuration; unavailable |
| DEV-002 | Zero DeviceType | invalid configuration; unavailable |
| DEV-003 | Disabled healthy device | unavailable; no selected mode |
| DEV-004 | Enabled healthy Auto device | available and ready in Auto only |
| DEV-005 | Enabled healthy Manual device | available and ready in Manual only |
| DEV-006 | No mode request | available but not ready |
| DEV-007 | Simultaneous mode requests | neither mode; conflict diagnostic |
| DEV-008 | Active equipment fault | unavailable and faulted |
| DEV-009 | Interlock open | unavailable |
| DEV-010 | Required communication lost | unavailable |
| DEV-011 | Valid running feedback | Running true |
| DEV-012 | Running feedback while disabled | Running false; unexpected-run fault |
| DEV-013 | Running feedback with interlock open | fail closed |
| DEV-014 | Running feedback with communication lost | fail closed |
| DEV-015 | Running feedback with equipment fault | fail closed |
| DEV-016 | Global auxiliary LineId zero | accepted when identities are valid |
| DEV-017 | Condition clears | current snapshot clears without reset |
| DEV-018 | Repeated unchanged inputs | deterministic unchanged snapshot |
| DEV-019 | Diagnostic priority with multiple failures | stable documented first reason |
| DEV-020 | Maximum static instances | bounded work remains within scan budget |

Equipment-specific tests remain under Selector, Blower, Dosing, IO, and Communication contracts.
