# TEST_Communication

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_CommunicationManager, ST_CommunicationChannel, IF_Communication |

| ID | Test | Expected result |
|---|---|---|
| COM-001 | Disabled channel | disabled, not ready/fresh/faulted |
| COM-002 | Invalid zero identity or threshold | fail closed with configuration diagnostic |
| COM-003 | Transport ready before first receive | Starting; static connection does not prove freshness |
| COM-004 | First valid receive | Ready and Fresh; Rx count exact |
| COM-005 | Duplicate application sequence | freshness refreshed; accepted sequence unchanged |
| COM-006 | New application sequence | accepted exactly once |
| COM-007 | Valid transmit event | Tx count and last Tx tick exact |
| COM-008 | Protocol error | payload ignored; error and consecutive counters increment |
| COM-009 | Timeout event | timeout, retry, error, and consecutive counters increment |
| COM-010 | Simultaneous protocol and timeout events | one consecutive failure; both diagnostic counters exact |
| COM-011 | Failure threshold reached | fault and one-scan NewFault event |
| COM-012 | Fault remains without valid receive | no duplicate fault event |
| COM-013 | Valid receive after fault | fault clears and one-scan Recovery event |
| COM-014 | Freshness timeout | Stale and not ready |
| COM-015 | Tick wrap during freshness timeout | wrap-safe result remains correct |
| COM-016 | Counter near maximum | saturation; no wrap |
| COM-017 | Reset without Service permission | rejected; counters unchanged |
| COM-018 | New permitted reset sequence | counters reset; active fault/freshness unchanged |
| COM-019 | Replayed reset sequence | no repeated reset or result event |
| COM-020 | Transport unavailable | not ready/fresh; no physical output action |
| COM-021 | Desktop loss during healthy accepted job | status blocks new transfer; execution owner remains authoritative |
| COM-022 | VFD channel loss while Blower runs | fault published; Blower contract removes Run |
| COM-023 | Sixteen static instances | bounded cyclic work meets scan budget |
| COM-024 | 72-hour endurance | no queue growth, blocking, or sequence corruption |

Vendor-adapter tests separately verify Modbus TCP map framing, RTU CRC, bus arbitration, and device-specific register profiles. Desktop/Edge verifies VPN, cloud, MQTT, OPC UA, databases, remote sessions, and persistent logs.
