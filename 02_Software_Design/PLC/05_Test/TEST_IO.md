# TEST_IO

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_IOManager, ST_IO, IF_IO |

| ID | Test | Expected result |
|---|---|---|
| IO-001 | Read digital input | validated snapshot changes after configured debounce |
| IO-002 | Valid analog range | scaled integer value and Valid bit correct |
| IO-003 | Open/short analog signal | channel invalid; fallback applied; diagnostic raised |
| IO-004 | Normal output request | requested output appears in applied image and physical map |
| IO-005 | Conflicting direction requests | both rejected; safe state; diagnostic raised |
| IO-006 | Output request without permission | applied image remains safe |
| IO-007 | Watchdog/configuration failure | all controlled outputs use defined safe image |
| IO-008 | Power-up with stale memory | no output pulse; safe image applied first |
| IO-009 | Input changes during scan | application consumes one stable snapshot |
| IO-010 | Duplicate command sequence | no duplicate edge/event |
| IO-011 | Commissioning force outside Service mode | rejected |
| IO-012 | Approved commissioning force | only allow-listed channel changes; force-active status visible |
| IO-013 | Missing required module | Ready false; equipment start inhibited |
| IO-014 | Safety input activation | standard outputs inhibited; hardwired safety behavior independently verified |
| IO-015 | Maximum configured channels | bounded execution meets scan-time budget |

Electrical commissioning separately verifies addresses, wiring, polarity, ranges, fail-safe states, and field-device response for every channel.
