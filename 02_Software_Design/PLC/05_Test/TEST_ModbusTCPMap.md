# TEST_ModbusTCPMap

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | AquaFeed Modbus TCP Register Map v1.0 |

## Required Tests

| ID | Test | Expected result |
|---|---|---|
| MBT-001 | Read offset 0 | Magic equals 0x4E56 |
| MBT-002 | Read map version | Supported major version accepted |
| MBT-003 | Use 4xxxx address as zero-based offset | Client test detects and rejects off-by-one configuration |
| MBT-004 | Encode UDINT 0x11223344 | lower offset contains 0x3344; next contains 0x1122 |
| MBT-005 | Encode REAL known vectors | Desktop and PLC values match IEEE-754 low-word-first profile |
| MBT-006 | Write read-only SystemStatus | Modbus exception or rejected write; PLC state unchanged |
| MBT-007 | Replay same command sequence | One execution; same acknowledgement |
| MBT-008 | Change payload without new sequence | Rejected |
| MBT-009 | Invalid CRC | Rejected; active state unchanged |
| MBT-010 | Partial multi-register snapshot | Rejected; no partial acceptance |
| MBT-011 | Transfer Job/Recipe pair | Atomic accept or atomic reject |
| MBT-012 | Stop Desktop heartbeat | Communication alarm; active healthy job continues |
| MBT-013 | Attempt new transfer while offline | Rejected |
| MBT-014 | Reconnect and reconcile sequences | No duplicate command/job/alarm event |
| MBT-015 | Read line blocks 1–6 | Correct 64-word stride and values |
| MBT-016 | Read reserved line blocks 7–16 | Stable zero/reserved response |
| MBT-017 | Raise 32 alarms | Table layout stable |
| MBT-018 | Raise alarm 33 | Overflow visible; no memory corruption |
| MBT-019 | Unsupported map major version | Desktop remains read-only |
| MBT-020 | Poll under normal production load | PLC scan and feeding timing remain within approved limits |

## Release Gate

Word order, float encoding, offset notation, command idempotency, and atomic snapshot acceptance must pass against the actual Delta DVP-SV3 PLC and the production Desktop Modbus library before release.
