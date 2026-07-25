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
- Platform architecture decision `AD-001` accepted.
- Normalization plan, system boundary, PLC module index, and document-status manifest created.

## Implementation Gate

New PLC code is admitted only when an authoritative contract and test specification already exist.

## Next Tasks

1. Implement and test the monotonic PLC TimeService.
2. Implement deterministic IO acquisition and safe output arbitration.
3. Implement Selector, Blower, and Dosing in dependency order.
