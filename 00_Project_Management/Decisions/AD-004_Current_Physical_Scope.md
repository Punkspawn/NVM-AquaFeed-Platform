# AD-004 - Current Physical Equipment Scope

## Status

Accepted

## Date

2026-07-25

## Decision

The current AquaFeed PLC implementation scope contains:

- six feeding lines
- one Selector per line
- one Blower/VFD per line
- two Dosing units per line
- the IO, communication, safety-coordination, alarm, diagnostics, runtime, recovery, and line/system services required to operate those devices

The following generic or process modules are not in the current implementation scope:

- MotionManager
- CIPManager
- WaterManager
- AerationManager
- OxygenManager

Their former specifications are archived and non-authoritative.

## Reasons

- the current System Overview names only Selector, Blower, and Dosing as physical line equipment
- no approved P&ID, IO list, electrical design, equipment schedule, control narrative, risk assessment, or commissioning test establishes the five optional modules
- generic Motion duplicates responsibility already owned by Selector, Blower, and Dosing
- keeping speculative modules active creates false implementation and safety obligations

## Consequences

No code, IO reservation, Modbus allocation, alarm catalog entry, test acceptance, or commissioning work is required for these modules in the current release.

A future project may reactivate a module only through an approved scope change and a new authoritative design package.
