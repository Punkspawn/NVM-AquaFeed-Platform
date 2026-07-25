# FB_DiagnosticsManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Bounded aggregation of current PLC diagnostic state |
| Version | 3.0 |

## Purpose

Builds one deterministic current diagnostic snapshot from validated subsystem status. It does not perform historical analysis, reporting, predictive maintenance, database inspection, root-cause analytics, or cloud diagnostics.

## Inputs

- scan duration and overrun event
- watchdog and PLC runtime status
- `ST_IO` health summary
- `IF_Communication` channel status
- active alarm summary
- equipment-local diagnostic codes
- counter-saturation and configuration-validity flags

## Output

One authoritative `ST_Diagnostics` snapshot and bounded diagnostic alarm conditions for `FB_AlarmManager`.

## Execution Rules

- execute once per normal PLC scan after input acquisition and subsystem updates
- use fixed arrays and bounded loops only
- do not allocate dynamic memory
- do not store histories, wall-clock timestamps, text, reports, users, or recommended actions
- latch occurrence counters with saturation; current condition flags clear only when their physical cause clears
- diagnostic acknowledgement never clears a physical fault
- health summary is derived from explicit severity and readiness rules, never a statistical score
- diagnostics must not directly command physical outputs

## Ownership Boundary

Equipment blocks own equipment-specific plausibility and fault conditions. IO owns channel validity. Communication owns channel timeout and sequence health. AlarmManager owns active alarm lifecycle. Desktop owns history, correlation, reports, analytics, localization, and troubleshooting guidance.
