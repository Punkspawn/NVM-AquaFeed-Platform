# NVM AquaFeed Platform

## Project State

**Current phase:** PLC implementation  
**Branch strategy:** focused normalization PRs  
**Status:** Active

## Current Activity

Implement the approved PLC core from normalized authoritative contracts.

## Current Focus

1. Enforce PLC/Desktop/Integration boundaries.
2. Resolve duplicate Device, System, and Line Manager designs.
3. Separate realtime PLC responsibilities from business and historical services.
4. Normalize filenames, document templates, and relative links.

## Completed

- Repository created and uploaded to GitHub.
- Initial engineering and PLC documentation structure created.
- `ST_Runtime` and `ST_OperationData` reviewed.
- `ST_Device` and the new runtime `FB_DeviceManager` drafted.
- Repository-wide architecture audit completed.
- Desktop-domain manager documents removed from the PLC tree and classified under the Desktop boundary.
- Integration/Edge platform managers removed from the PLC tree; a safe update-activation contract remains at the PLC boundary.
- Diagnostics and IO contracts normalized with bounded process images, deterministic scan order, safe output arbitration, and explicit Modbus diagnostics.
- Selector, Blower, and Dosing normalized as authoritative deterministic equipment blocks with versioned states, interfaces, and tests.
- Communication, channel supervision, and monotonic PLC time normalized; platform network/NTP responsibilities removed from PLC.
- Recovery, bounded health aggregation, and standard-PLC safety coordination normalized with fail-closed restart prevention.
- Optional physical module scope classified under `AD-004`: Motion excluded as duplicate; CIP, Water, Aeration, and Oxygen retained as future options outside the current release.
- Remaining mixed managers removed from active PLC scope; service mode reduced to a fail-closed permission contract without duplicate control or platform services.
- PLC implementation baseline created with importable core types, bounded global constants, and a deterministic main-program entry point.
- `FB_TimeService` implemented with wrap-safe monotonic timing, bounded second sequencing, and idempotent observational UTC synchronization.
- `FB_IOManager` safety core implemented with safe startup, fixed process-image bounds, permission/safety/watchdog arbitration, and zero/false baseline safe outputs.
- `FB_Selector` automatic positioning/homing core implemented with bounded configurable outlets, linear-limit and cyclic-360 travel modes, shortest-path selection, replay protection, wrap-safe timeouts, and mutually exclusive logical outputs.
- `FB_Blower` control core implemented with bounded frequency validation, VFD start/acceleration supervision, stable-speed dosing permission, controlled post-run, critical-stop priority, replay protection, and reset without automatic restart.
- Blower hardware baseline approved as a panel-mounted 22 kW, 380–480 V Delta C2000 Plus for TMM equipment; vendor register handling remains isolated in a replaceable Modbus RTU device profile.
- `FB_Dosing` pulse-based transaction core implemented with immutable accepted parameters, guarded integer quantity conversion, first-pulse/no-flow/rate/target supervision, immediate interlock stop, replay protection, and one-scan successful completion.
- Line execution contract aligned to centi-kilograms, permille, and centi-Hz; current jobs select exactly one of two installed Dosing units, and `TEST_Line` now closes the implementation gate.
- `FB_LineManager` deterministic single-job core implemented with immutable transfer acceptance, replay protection, Selector/Blower/Dosing coordination, bounded progress arithmetic, controlled pause/stop/cancel post-run, one-scan completion, and fail-closed fault/emergency handling.
- `FB_SystemManager` lifecycle core implemented with exclusive mode arbitration, edge-triggered commands, safety-priority state transitions, controlled Automatic-mode loss, line permission, and bounded global status publication.
- Delta DVP-SV3/ISPSoft vendor compile gate defined with exact import order, isolated compile acceptance, syntax-risk checks, one-line bench prerequisites, six-line composition evidence, and hardware commissioning stop conditions.
- Platform architecture decision `AD-001` accepted.
- Normalization plan, system boundary, PLC module index, and document-status manifest created.

## Implementation Gate

New PLC code is admitted only when an authoritative contract and test specification already exist.

## Next Tasks

1. Run Vendor Compile Gate A and B in ISPSoft and record the exact version, CPU/firmware, errors, and warnings.
2. Approve one line's physical IO list, channel enable masks, polarity, safe values, time base, and equipment parameters.
3. Compose and bench-test one disabled line before expanding to six line/equipment groups.
4. Approve explicit Selector manual-jog commands and maximum jog duration before implementing service jog.
