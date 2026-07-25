# FB_IOManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Deterministic physical IO acquisition, validation, and output application |
| Version | 3.0 |

## Scan Order

1. copy physical input image into a local raw snapshot
2. validate module/channel availability
3. debounce digital inputs and validate analog ranges
4. publish one immutable validated input snapshot for the scan
5. collect requested outputs from equipment/control blocks
6. apply mode, interlock, safety, and mutual-exclusion rules
7. write the final output image once
8. publish applied-output feedback and IO diagnostics

## Rules

- application blocks never address physical IO directly
- physical mapping exists in one hardware mapping layer
- inputs are read once and remain stable for the application scan
- outputs are written once after arbitration
- startup, disabled, configuration-invalid, watchdog, and unsafe states apply the defined safe output image
- conflicting output commands are rejected, diagnosed, and never resolved by last-writer-wins
- simulation/force is allowed only in approved commissioning mode, with explicit channel allow-list and visible active status
- safety-rated functions remain hardwired or safety-controller-owned; this block does not replace them
- no database, HMI, cloud, history, report, dynamic discovery, or unbounded channel list logic is permitted

## Contracts

- structure: `ST_IO.md`
- interface: `IF_IO.md`
- aggregate diagnostics: `ST_Diagnostics.md`
- verification: `TEST_IO.md`
