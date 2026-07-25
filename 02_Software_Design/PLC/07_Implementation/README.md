# PLC Implementation

This directory contains importable IEC 61131-3 Structured Text sources.

## Initial Target

- Delta DVP-SV3
- cyclic execution
- six feeding lines
- one Selector, one Blower, and two Dosing units per line

## Import and Compile Gate

Use [VENDOR_COMPILE_GATE.md](VENDOR_COMPILE_GATE.md) for the exact listed-source import order, isolated compile sequence, ISPSoft syntax checks, one-line bench prerequisites, six-line composition gate, and commissioning stop conditions.

## Implemented Function Blocks

- `Function_Blocks/FB_SystemManager.st` — global lifecycle, mode arbitration, command-edge handling, safety-priority permissions, and bounded realtime status publication
- `Function_Blocks/FB_LineManager.st` — immutable single-job acceptance, Selector/Blower/Dosing coordination, bounded progress, controlled shutdown, and one-scan completion
- `Function_Blocks/FB_AlarmManager.st` — 64-record active lifecycle, oldest-first 128-event persistence handshake, replay-safe commands, and bounded priority summaries
- `Function_Blocks/FB_HealthMonitor.st` — fixed-priority readiness, continuation, degradation, severity, and one-scan material transition aggregation
- `Function_Blocks/FB_CommunicationManager.st` — bounded per-channel freshness, failure/recovery lifecycle, saturating counters, and service-authorized replay-safe reset
- `Function_Blocks/FB_RecoveryManager.st` — immutable checkpoint validation, local approval, safe reinitialization handshake, and explicit LineManager handoff
- `Function_Blocks/FB_SafetyCoordinator.st` — fail-closed observed-safety state, latched restart prevention, local reset sequencing, and standard-control permissions
- `Function_Blocks/FB_TimeService.st` — monotonic timing, wrap-safe elapsed calculation, saturated second sequence, and idempotent UTC observation acceptance
- `Function_Blocks/FB_IOManager.st` — safe startup image, immutable input snapshot, bounded output arbitration, and single applied-output image
- `Function_Blocks/FB_Selector.st` — bounded linear or cyclic automatic positioning and homing core
- `Function_Blocks/FB_Blower.st` — bounded VFD start, stable-speed permission, controlled post-run, and fail-safe stop core
- `Function_Blocks/FB_Dosing.st` — latched pulse-based delivery, guarded integer conversion, interlock supervision, and one-scan completion
- `Functions/F_ElapsedMs.st` — wrap-safe unsigned elapsed-time helper
- `Functions/F_CyclicDistance.st` — shortest distance across a cyclic position range

## Rules

- Documentation under the sibling design folders remains the behavioral authority.
- Only implemented and reviewed blocks may be called from the main program.
- Physical outputs are eventually written once per scan by IO Manager.
- Safety and fault permissions are evaluated before automatic commands.
- No placeholder Function Blocks are created.
