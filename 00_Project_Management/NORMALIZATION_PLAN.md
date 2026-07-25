# Repository Normalization Plan

## Status

Approved working plan

## Purpose

This plan converts the accumulated design documents into one authoritative architecture without discarding useful legacy engineering knowledge.

## Authority Order

When documents conflict, use this order:

1. Architecture Decisions in `00_Project_Management/Decisions`
2. `SYSTEM_BOUNDARY.md`
3. Authoritative module and document indexes
4. Current normalized design documents
5. Legacy documents in `Archive/Legacy`

## Classification States

- **KEEP** — authoritative in its current responsibility domain.
- **MOVE** — valid content stored in the wrong directory.
- **MERGE** — useful content must be consolidated into one authoritative document.
- **ARCHIVE** — retained for reference but prohibited as an implementation source.
- **DELETE** — no engineering value; deletion requires a separate confirmed cleanup.

## Normalization Phases

### Phase 1 — Freeze and classify

Do not create new Function Block, Function, Structure, Interface, or Test documents until this plan is complete.

### Phase 2 — Establish authority

Create and maintain:

- `SYSTEM_BOUNDARY.md`
- `DOCUMENT_STATUS.md`
- `PLC_MODULE_INDEX.md`
- `DATA_OWNERSHIP.md`

### Phase 3 — Separate responsibility domains

Use this target structure:

```text
00_Project_Management
01_System_Engineering
02_PLC
03_Desktop
04_Integration
05_Electrical
06_Test
07_Commissioning
08_Service
09_Releases
Archive/Legacy
```

### Phase 4 — Resolve critical duplicates

Resolve in this order:

1. Device Manager
2. System Manager
3. Line Manager
4. Alarm architecture
5. Runtime and historical-data ownership

### Phase 5 — Normalize names and extensions

- Use semantic filenames without numeric ordering prefixes.
- Rename `.md.txt` to `.md` only after content classification.
- Use IEC-style PLC boolean names such as `xReady` and `xFault`.
- Use desktop-style names such as `isReady` and `hasFault` outside the PLC.
- Replace stale document references with repository-relative Markdown links.

### Phase 6 — Resume implementation

Continue only in this order:

1. PLC structures
2. Core PLC Function Blocks
3. PLC interfaces
4. Execution flow
5. Modbus contract
6. Unit and integration tests
7. Desktop contract
8. PLC and Desktop implementation

## Safety Rules

- Never delete a legacy document before useful information is merged.
- Archived documents are non-authoritative.
- No business, reporting, database, user, inventory, cloud, or analytics service may be implemented as a PLC Function Block without a new accepted architecture decision.
- Every normalized document must declare owner, status, version, dependencies, test requirements, and related documents.
