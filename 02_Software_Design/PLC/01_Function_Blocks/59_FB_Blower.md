# FB_Blower

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Control one blower through a validated VFD channel |
| Version | 3.0 |

## State Machine

`Disabled → Ready → Starting → Accelerating → AtSpeed → PostRun/Stopping → Ready`; any blocking condition enters `Fault`.

## Behavior

- validate frequency limits and latch the accepted command sequence
- issue Run and frequency reference only through the VFD/IO communication owner
- require drive ready and healthy communication before start
- declare AtSpeed only after actual frequency remains inside tolerance for the configured stable time
- enforce start timeout, acceleration timeout, feedback-loss timeout, stop timeout, and maximum post-run time
- keep blower running for the approved post-run interval after normal dosing completion
- bypass post-run and remove Run immediately for safety loss, drive fault, critical communication loss, or emergency stop
- remove dosing permission whenever AtSpeed, communication, safety, or drive feedback becomes false
- never calculate production statistics, energy cost, maintenance history, or reports

## Reset

Fault reset is accepted only with stopped command, physical cause removed, safe state, healthy communication, and a new reset sequence. Reset does not command a restart.

## Contracts

- state: `E_BlowerState.md`
- interface: `IF_Blower.md`
- verification: `TEST_Blower.md`
