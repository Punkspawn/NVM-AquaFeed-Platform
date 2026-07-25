# NVM AquaFeed Platform

## Project State

**Current phase:** Architecture normalization  
**Branch:** `agent/repository-normalization`  
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

1. Normalize Modbus map for system, line, execution, and alarm contracts.
2. Split runtime state from historical data.
3. Move Desktop-domain manager documents out of PLC.
4. Move Integration/Edge manager documents out of PLC.
5. Resume remaining core PLC structures and Function Blocks.
