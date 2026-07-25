# PLC Implementation

This directory contains importable IEC 61131-3 Structured Text sources.

## Initial Target

- Delta DVP-SV3
- cyclic execution
- six feeding lines
- one Selector, one Blower, and two Dosing units per line

## Import Order

1. `Types/AquaFeed_CoreTypes.st`
2. `Globals/GVL_AquaFeed.st`
3. Function Blocks as they are implemented
4. `Programs/PRG_AquaFeedMain.st`

## Implemented Function Blocks

- `Function_Blocks/FB_TimeService.st` — monotonic timing, wrap-safe elapsed calculation, saturated second sequence, and idempotent UTC observation acceptance
- `Function_Blocks/FB_IOManager.st` — safe startup image, immutable input snapshot, bounded output arbitration, and single applied-output image
- `Function_Blocks/FB_Selector.st` — bounded linear or cyclic automatic positioning and homing core
- `Functions/F_ElapsedMs.st` — wrap-safe unsigned elapsed-time helper
- `Functions/F_CyclicDistance.st` — shortest distance across a cyclic position range

## Rules

- Documentation under the sibling design folders remains the behavioral authority.
- Only implemented and reviewed blocks may be called from the main program.
- Physical outputs are eventually written once per scan by IO Manager.
- Safety and fault permissions are evaluated before automatic commands.
- No placeholder Function Blocks are created.
