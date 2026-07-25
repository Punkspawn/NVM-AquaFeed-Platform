# FB_DiagnosticsManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Bounded aggregation of current PLC diagnostic truth |
| Version | 3.1 |

## Purpose

Builds one deterministic snapshot from validated runtime, IO, communication, equipment, and alarm summaries. It does not perform history, reports, prediction, root-cause analytics, text, or cloud diagnostics.

## Current Diagnostic Priority

1. invalid configuration
2. unhealthy watchdog
3. required IO module offline
4. invalid required input
5. invalid requested output
6. output mismatch
7. required communication unavailable
8. equipment blocking diagnostic
9. scan-time budget exceeded
10. non-required communication offline
11. equipment degraded diagnostic
12. counter saturation

Priorities 1–8 are blocking. Priorities 9–12 are degraded.

## Execution

- fixed inputs and no dynamic work
- maximum scan duration and occurrence counters saturate
- scan-overrun event is accepted once per sequence
- other occurrences use rising-edge detection of current conditions
- one scan publishes at most one occurrence, using fixed priority
- active alarm count is observed but does not duplicate AlarmManager fault truth
- acknowledgement/reset cannot alter a physical diagnostic condition
- no physical output command exists

## Revision History

| Version | Date | Description |
|---|---|
| 3.0 | 2026-07-25 | Normalized bounded diagnostic ownership. |
| 3.1 | 2026-07-26 | Closed IO mapping, blocking/degraded inputs, priority, and replay-safe overrun semantics. |
