# TEST_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_DiagnosticsManager, ST_Diagnostics, IF_Diagnostics |

| ID | Test | Expected result |
|---|---|---|
| DIA-001 | Healthy required inputs | Ready true; Degraded/Fault false |
| DIA-002 | Invalid configuration | Ready false; Fault true; stable code |
| DIA-003 | One scan overrun event | overrun count increments once |
| DIA-004 | Replay same occurrence sequence | occurrence count unchanged |
| DIA-005 | Counter near maximum | saturates; never wraps |
| DIA-006 | One invalid analog channel | invalid count exact; severity per catalog |
| DIA-007 | Communication channel offline | offline count exact; active job behavior unchanged unless contract marks channel blocking |
| DIA-008 | Physical cause clears | current flag clears; retentive occurrence count remains |
| DIA-009 | Desktop disconnected | diagnostics continue deterministically |
| DIA-010 | Desktop acknowledgement | physical condition and current diagnostic truth unchanged |
| DIA-011 | Maximum configured channels | execution remains within approved scan budget |
| DIA-012 | Wall-clock change | no counter or lifecycle effect |

Desktop tests separately verify history, localization, reports, correlation, recommended actions, and predictive analytics.
