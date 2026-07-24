# NVM AquaFeed Platform — Repository Audit

## Audit Status

- Date: 2026-07-24
- Branch: `main`
- Scope: repository-wide structural scan and focused semantic review of the core architecture, PLC structures, Function Blocks, Functions, engineering documents, and documentation indexes.
- Result: **Usable foundation, but normalization is required before further implementation.**

---

## Executive Summary

The repository contains a large amount of useful engineering knowledge and demonstrates strong intent around modularity, deterministic PLC execution, traceability, serviceability, and future expansion.

However, the current repository mixes several generations of design work. This has created:

- duplicate or overlapping documents,
- inconsistent file extensions and naming,
- conflicting ownership definitions,
- PLC/Desktop responsibility drift,
- oversized manager responsibilities,
- broken or stale cross-references,
- inconsistent document templates,
- and multiple parallel architecture concepts.

The project should **not continue by adding more Function Blocks yet**. First, the repository needs a controlled normalization pass.

---

## Critical Findings

### 1. Duplicate `FB_DeviceManager` definitions

Two different Device Manager designs currently exist:

- `02_Software_Design/PLC/01_Function_Blocks/98_FB_DeviceManager.md.txt`
- `02_Software_Design/PLC/01_Function_Blocks/FB_DeviceManager.md`

They describe fundamentally different responsibilities.

The numbered legacy document defines a platform-wide industrial asset registry, provisioning, firmware, heartbeat, lifecycle, and inventory service.

The new normalized document defines one deterministic runtime manager per physical device and owns one `ST_Device` instance.

These are not two versions of the same Function Block. They are two different architectural concepts using the same name.

**Decision required:**

- Keep `FB_DeviceManager` for PLC runtime device state.
- Move asset registry, firmware inventory, provisioning, and long-term device lifecycle to Desktop/Edge services.
- Archive or rename the legacy document.

Priority: **Critical**

---

### 2. PLC/Desktop responsibility drift

The agreed architecture is:

```text
Desktop
- Database
- Users
- Reports
- Historical data
- Statistics
- Job orders

PLC
- IO
- Machine control
- Runtime
- Safety
- Modbus
- Realtime state
```

The current PLC Function Block folder includes concepts such as:

- DatabaseSync
- ReportManager
- BackupManager
- UserManager
- InventoryManager
- PurchaseManager
- WarehouseManager
- SupplierManager
- CostManager
- AIManager
- CloudManager
- DigitalTwinManager
- AnalyticsManager
- LicenseManager

Most of these are Desktop, Edge, Cloud, or business-domain services rather than deterministic PLC control blocks.

Keeping them as PLC FBs conflicts with the platform boundary and risks producing a non-deterministic, oversized PLC application.

Priority: **Critical**

---

### 3. Inconsistent file extensions

The repository contains a mixture of:

- `.md`
- `.md.txt`

Examples include:

- `57_FB_LineManager.md.txt`
- `98_FB_DeviceManager.md.txt`
- `108_FB_AerationManager.md.txt`
- `Change_Log.md.txt`

Files intended as Markdown should use `.md` only.

Priority: **High**

---

### 4. Inconsistent naming strategy

The repository currently mixes:

```text
57_FB_LineManager.md.txt
90_FB_SystemManager.md
FB_DeviceManager.md
CODING_RULES.md
Project_Design_Principles.md
```

The documented naming rules also conflict with actual usage:

- some files use numeric prefixes,
- some do not,
- some use uppercase names,
- some use PascalCase,
- some use underscore-separated names,
- and some include the extension inside the document title.

A single naming policy must be adopted before migration.

Recommended policy:

```text
FB_DeviceManager.md
FB_LineManager.md
ST_Device.md
System_State.md
Coding_Standard.md
```

Document IDs should provide ordering and traceability; filenames should remain semantic.

Priority: **High**

---

### 5. Oversized manager documents and God Object risk

Several legacy manager documents assign a very broad set of responsibilities to one block.

For example, the legacy Device Manager includes:

- discovery,
- registration,
- provisioning,
- firmware tracking,
- asset inventory,
- heartbeat,
- health monitoring,
- persistent storage,
- archives,
- network scanning,
- and reporting.

This conflicts with the repository's own rules:

- one Function Block, one primary responsibility,
- avoid unnecessary abstractions,
- do not duplicate existing blocks,
- maintain deterministic execution.

Priority: **High**

---

### 6. Conflicting boolean naming conventions

`CODING_RULES.md` recommends boolean names such as:

```text
IsRunning
IsReady
HasAlarm
CanStart
```

The current PLC structures and new reference implementation use IEC-style prefixes:

```text
xReady
xReset
xFaultFeedback
xCommunicationOK
```

Both approaches are valid, but mixing them reduces consistency.

Recommended PLC convention:

```text
xRunning
xReady
xAlarmActive
xCanStart
```

Recommended Desktop convention:

```text
isRunning
isReady
hasAlarm
canStart
```

Priority: **Medium**

---

### 7. Historical ownership is not consistently enforced

Some legacy PLC documents assign History, Statistics, Reports, Archive, Database, and Long-Term Storage responsibilities to PLC managers.

This conflicts with the principle:

> Desktop owns history. PLC is not a historian.

PLC should expose bounded runtime counters and event/status snapshots. The Desktop application should persist and analyze them.

Priority: **Critical**

---

### 8. Cross-reference quality is inconsistent

Examples include references such as:

```text
01_System_Engineering/14_Line_Manager_Specification.md
01_System_Engineering/15_State_Machine_Specification.md
97_Software_Architecture
91_Software_Architecture
```

Some references use filenames, some use document names, some omit extensions, and some appear to use obsolete numbering.

All related-document references should use repository-relative Markdown links.

Example:

```markdown
[ST_Device](../02_Structures/ST_Device.md)
```

Priority: **High**

---

### 9. Document templates are inconsistent

The repository includes at least three document styles:

1. Standard Markdown headings and tables.
2. Plain numbered text with blank lines between every phrase.
3. Separator-based engineering documents using repeated dashed lines.

This makes review, search, maintenance, and automated validation difficult.

A common template should include:

- Title
- Document ID
- Status
- Version
- Purpose
- Scope
- Ownership
- Interface
- Rules/Invariants
- Dependencies
- Related Documents
- Test Requirements
- Revision History

Priority: **High**

---

### 10. Root README is insufficient

The root `README.md` currently provides only the project name and one-line description.

It should become the main repository entry point and include:

- platform purpose,
- system boundary,
- current maturity/status,
- high-level architecture,
- repository map,
- engineering principles,
- build/development workflow,
- and links to authoritative documents.

Priority: **Medium**

---

## Positive Findings

The following principles are strong and should be preserved:

- PLC remains operational without the PC.
- PLC is the primary realtime controller.
- Communication loss shall not interrupt a healthy feeding process.
- Safety has priority over production.
- Blocking execution and `WAIT` logic are prohibited.
- Function Blocks coordinate behavior but equipment-specific blocks own physical sequences.
- Functions are intended to be deterministic and stateless.
- Structures are intended as data containers.
- The system is designed for expansion beyond six lines.
- Manual, Automatic, Service, and Simulation modes are recognized.
- Traceability and maintainability are treated as first-class requirements.

---

## Recommended Authoritative Architecture

```text
Desktop Application
├── Database
├── Users and permissions
├── Job orders and scheduling
├── Recipes and business configuration
├── Historical alarms and events
├── Reports
├── Statistics and analytics
├── Inventory and feed lots
├── Fish, cage, biomass, growth and FCR data
└── Backup and long-term archive

PLC Runtime
├── IO processing
├── Safety and operational interlocks
├── Equipment control
├── Line coordination
├── Realtime state
├── Current job execution
├── Bounded runtime counters
├── Alarm conditions and IDs
├── Recovery sequences
└── Modbus communication

Edge/Integration Layer — optional
├── Protocol translation
├── Store-and-forward buffering
├── Remote access gateway
├── Update delivery
└── Cloud synchronization
```

---

## Proposed PLC Core

The initial PLC runtime should remain small:

```text
FB_SystemManager
FB_LineManager
FB_Selector
FB_Blower
FB_Dosing
FB_DeviceManager
FB_AlarmManager
FB_RecoveryManager
FB_CommunicationManager
FB_IOManager
```

Additional blocks should be added only when a concrete realtime requirement exists.

---

## Normalization Plan

### Phase 1 — Freeze

Do not add more manager documents until ownership and naming are normalized.

### Phase 2 — Classify every document

Each document shall be classified as one of:

- Authoritative
- Merge required
- Desktop responsibility
- PLC responsibility
- Edge/Integration responsibility
- Future concept
- Archive

### Phase 3 — Resolve duplicates

Start with:

1. `FB_DeviceManager`
2. `FB_SystemManager`
3. `FB_LineManager`
4. Alarm architecture
5. Runtime/history ownership

### Phase 4 — Normalize files

- Convert `.md.txt` to `.md`.
- Apply one filename convention.
- Apply one document template.
- Repair relative links.
- Remove duplicate numbering conflicts.

### Phase 5 — Establish authoritative indexes

Create:

- `DOCUMENT_INDEX.md`
- `PLC_MODULE_INDEX.md`
- `DATA_OWNERSHIP.md`
- `SYSTEM_BOUNDARY.md`
- `DOCUMENT_STATUS.md`

### Phase 6 — Continue design

After normalization, continue in this order:

1. Structures
2. Core PLC Function Blocks
3. Interfaces
4. Execution flow
5. Modbus contract
6. Unit tests
7. Desktop contract

---

## Immediate Decision

Before creating `FB_LineManager.md`, the project should first decide what happens to the existing legacy files.

Recommended decision:

- Preserve legacy documents temporarily.
- Mark them as `Legacy / Under Review`.
- Create authoritative normalized documents without numeric filename prefixes.
- Delete or archive legacy documents only after their useful content has been merged.

---

## Audit Conclusion

The repository is not empty or poorly conceived. It contains substantial project knowledge and several correct engineering principles.

The main problem is **architecture accumulation without consolidation**.

The next engineering task should therefore be repository normalization, not adding more modules.

Overall assessment:

```text
Concept Quality:          Strong
Documentation Quantity:  Very High
Documentation Consistency: Low
PLC Boundary Clarity:     Needs correction
Maintainability:          At risk without normalization
Recoverability:           High
Recommended Status:       Architecture normalization required
```
