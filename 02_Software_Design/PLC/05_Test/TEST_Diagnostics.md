# TEST_Diagnostics

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_DiagnosticsManager, ST_Diagnostics, IF_Diagnostics |

| ID | Test | Expected result |
|---|---|---|
| DIA-001 | Disabled aggregation | not ready; no fabricated fault |
| DIA-002 | Healthy required inputs | Ready true |
| DIA-003 | Invalid configuration | blocking code and severity 30 |
| DIA-004 | Watchdog unhealthy | blocking with fixed priority |
| DIA-005 | Required IO module offline | blocking |
| DIA-006 | Invalid input count | exact count and blocking |
| DIA-007 | Invalid output count | exact count and blocking |
| DIA-008 | Output mismatch | exact count and blocking |
| DIA-009 | Required communication loss | blocking |
| DIA-010 | Non-required channel offline | degraded only |
| DIA-011 | Equipment blocking diagnostic | source code published; fault |
| DIA-012 | Equipment degraded diagnostic | source code published; degraded |
| DIA-013 | Equipment severity above 40 | clamped to 40 |
| DIA-014 | Scan duration exceeds budget | degraded |
| DIA-015 | New overrun sequence | overrun and occurrence counters +1 |
| DIA-016 | Replayed overrun sequence | counters unchanged |
| DIA-017 | Maximum scan duration | retained maximum exact |
| DIA-018 | Counter saturation input | degraded; no wrap |
| DIA-019 | Multiple conditions | stable fixed priority and one occurrence |
| DIA-020 | Condition remains active | no repeated occurrence |
| DIA-021 | Physical cause clears | current truth clears; counters remain |
| DIA-022 | Active alarm count changes | publication exact; no duplicated diagnostic fault |
| DIA-023 | Counter near maximum | saturates |
| DIA-024 | Wall-clock/Desktop change | no diagnostic effect |

Desktop separately verifies history, localization, reports, correlation, guidance, and prediction.
