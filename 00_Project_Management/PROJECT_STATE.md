# NVM AquaFeed Platform

## Project State

**Current phase:** Architecture normalization  
**Branch strategy:** focused normalization PRs  
**Status:** Active

## Current Activity

Classify and consolidate accumulated engineering documents before implementation.

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
- Platform architecture decision `AD-001` accepted.
- Normalization plan, system boundary, PLC module index, and document-status manifest created.

## Frozen Until Normalization Completes

- New PLC Function Blocks
- New PLC Functions
- New Structures
- New Interfaces
- PLC implementation
- Desktop implementation

## Next Tasks

1. Normalize Selector, Blower, and Dosing core equipment blocks.
2. Resume remaining PLC implementation contracts.
