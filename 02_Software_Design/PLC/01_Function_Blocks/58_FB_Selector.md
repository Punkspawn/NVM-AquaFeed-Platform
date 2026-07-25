# FB_Selector

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Position one physical feed selector |
| Version | 3.0 |

## State Machine

`Disabled → Initializing → Homing/Ready → Moving → Settling → Ready`; any blocking condition enters `Fault`.

## Behavior

- latch one validated target outlet and command sequence before movement
- determine the shortest permitted direction from the approved calibration table
- never energize left and right outputs together
- reject movement beyond an active directional limit
- stop motion before evaluating settling
- assert InPosition only when position remains inside tolerance for the full settle time
- require homing after position validity is lost or startup policy demands it
- stop immediately on safety loss, feedback contradiction, invalid position, motor fault, or movement timeout
- manual jog requires local Service permission, stopped feeding, hold-to-run command, and maximum jog duration
- calibration editing and long-term position history are outside normal runtime behavior

## Command Rules

A new command is accepted only while Ready, unless it is Stop. Replayed sequence values do nothing. Target changes while moving are rejected; LineManager must stop and issue a new sequence.

## Output Ownership

The block produces logical left/right motor requests only. `FB_IOManager` owns physical outputs and conflict-safe application.

## Contracts

- state: `E_SelectorState.md`
- interface: `IF_Selector.md`
- verification: `TEST_Selector.md`
