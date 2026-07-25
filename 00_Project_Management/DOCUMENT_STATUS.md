# Document Status Manifest

## Status

Authoritative classification manifest

## Root

| Path | Action | Reason |
|---|---|---|
| `README.md` | KEEP / REWRITE | Must become the authoritative repository entry point |
| `REPOSITORY_AUDIT.md` | KEEP | Baseline audit and normalization rationale |
| `deneme.txt` | DELETE LATER | Connection test; no engineering value |

## 00_Project_Management

| Scope | Action |
|---|---|
| `Decisions/**` | KEEP — highest architecture authority |
| `PROJECT_STATE.md` | KEEP / UPDATE after each phase |
| `ROADMAP.md` | KEEP / REWRITE with normalization phase |
| Normalization authority documents | KEEP |

## 01_System_Engineering

| Scope | Action |
|---|---|
| System overview and functional requirements | KEEP / NORMALIZE |
| Selector, blower, dosing, line, state-machine specifications | KEEP / MERGE into authoritative system specifications |
| Communication, alarm, service, maintenance, commissioning documents | KEEP / MERGE |
| Database, UI/UX, Smart Farm, recipe, mission and business-domain documents | MOVE to `03_Desktop` |
| Old numbered Function Block documents | ARCHIVE after useful content is merged |
| Folder/naming/architecture rules superseded by current authority documents | ARCHIVE |
| Antigravity development rules | MOVE to Desktop development documentation if still applicable |

## 02_Software_Design — Project Documents

| Path | Action |
|---|---|
| `README.md` | MERGE into root README |
| `PROJECT_OVERVIEW.md` | MERGE with System Overview |
| `PROJECT_STRUCTURE.md` | REPLACE with normalized target structure |
| `PROJECT_GLOSSARY.md` | KEEP / NORMALIZE |
| `SYSTEM_REQUIREMENTS_SPECIFICATION.md` | KEEP / MERGE |
| `SYSTEM_SPECIFICATION.md` | KEEP / MERGE |
| `SYSTEM_ARCHITECTURE.md` | ARCHIVE after rewrite; conflicts with AD-001 |

## PLC/00_Architecture

| Path | Action |
|---|---|
| `SYSTEM_ARCHITECTURE.md` | MERGE into authoritative PLC architecture |
| `COMMUNICATION_PROTOCOL.md` | KEEP / NORMALIZE |
| `NAMING_CONVENTIONS.md` | MERGE with coding standards |
| `MASTER_PROMPT.md` | MOVE to project tooling documentation; non-engineering authority |

## PLC/01_Function_Blocks — Exact Domain Actions

### Keep and normalize

- `FB_LineManager.md` — KEEP; authoritative consolidated PLC specification
- `Archive/Legacy/PLC/Function_Blocks/57_FB_LineManager.md` — ARCHIVED
- `58_FB_Selector.md`
- `59_FB_Blower.md`
- `60_FB_Dosing.md`
- `FB_AlarmManager.md` — KEEP; authoritative bounded PLC alarm lifecycle
- `Archive/Legacy/PLC/Function_Blocks/61_FB_AlarmManager.md` — ARCHIVED
- `62_FB_RecoveryManager.md`
- `63_FB_HealthMonitor.md`
- `88_FB_DiagnosticsManager.md`
- `FB_SystemManager.md` — KEEP; authoritative consolidated PLC specification
- `Archive/Legacy/PLC/Function_Blocks/90_FB_SystemManager_PlatformOrchestrator.md` — ARCHIVED
- `100_FB_NetworkManager.md` — communication scope only
- `101_FB_TimeManager.md` — bounded PLC time service only
- `102_FB_IOManager.md`
- `103_FB_MotionManager.md` — only if required by physical motion
- `105_FB_SafetyManager.md`
- `106_FB_CIPManager.md` — only if CIP equipment is in scope
- `107_FB_WaterManager.md` — only if physical equipment is in scope
- `108_FB_AerationManager.md` — only if physical equipment is in scope
- `109_FB_OxygenManager.md` — only if physical equipment is in scope
- `110_FB_FeedingControlManager.md` — merge into Line Manager unless separate responsibility is proven
- `FB_DeviceManager.md` — KEEP; authoritative PLC runtime design

### Merge then archive source

- `64_FB_DataLogger.md` — keep only bounded event snapshot/buffer behavior
- `69_FB_Scheduler.md` — keep only execution of an accepted current mission
- `70_FB_RecipeManager.md` — keep only validation/use of active PLC recipe snapshot
- `71_FB_FeedProgramManager.md` — merge active execution into Line Manager
- `FB_RuntimeCounter.md` and `FB_MaintenanceCounter.md` — KEEP; authoritative PLC counters
- `Archive/Legacy/PLC/Function_Blocks/84_FB_MaintenanceManager.md` — ARCHIVED; platform maintenance belongs to Desktop
- `85_FB_NotificationManager.md` — merge active alarm signals; move notifications
- `86_FB_SecurityManager.md` — retain machine access interlocks only
- `Archive/Legacy/PLC/Function_Blocks/98_FB_DeviceManager_AssetRegistry.md` — ARCHIVED; non-authoritative Desktop/Edge concept source

### Moved to Desktop

The following former PLC documents now reside in `03_Desktop/Legacy_Design` as non-authoritative design inputs:

- DatabaseSync, ReportManager, BackupManager, UserManager
- BiomassManager, CageManager, GrowthManager, FCRManager
- MortalityManager, HarvestManager
- InventoryManager, PurchaseManager, WarehouseManager, SupplierManager, CostManager
- QualityManager, LicenseManager, AnalyticsManager

Authoritative ownership is defined by `03_Desktop/Domain/DOMAIN_INDEX.md`.

### Moved to Integration / Edge

The former Update, AI, Remote, Digital Twin, Integration, Cloud, Edge, and Firmware manager documents now reside in `04_Integration/Legacy_Design` as non-authoritative design inputs.

Authoritative ownership is defined by `04_Integration/INTEGRATION_INDEX.md`; the PLC retains only the bounded `IF_UpdateActivation.md` safety handshake. Network communication supervision remains in PLC pending normalization.

## PLC/02_Structures

| Path | Action |
|---|---|
| `ST_Device.md` | KEEP — authoritative current structure |
| `ST_Alarm.md` | KEEP; authoritative bounded active alarm record |
| `ST_Diagnostics.md` | KEEP / NORMALIZE |
| `ST_Line.md` | KEEP; authoritative bounded realtime line snapshot |
| `ST_ModbusMap.md` | KEEP; authoritative flat 4000-WORD publication buffer |
| `ST_Runtime.md` | KEEP; authoritative retentive lifetime counters |
| `ST_SystemStatus.md` | KEEP / NORMALIZE |
| `ST_JobExecution.md` | KEEP; authoritative bounded PLC job snapshot |
| `ST_RecipeExecution.md` | KEEP; authoritative bounded PLC recipe snapshot |
| `Archive/Legacy/PLC/Structures/ST_JobOrder.md` | ARCHIVED; split into Desktop master and PLC execution snapshot |
| `Archive/Legacy/PLC/Structures/ST_Recipe.md` | ARCHIVED; split into Desktop master and PLC execution snapshot |
| `ST_OperationData.md` | SPLIT PLC current snapshot / Desktop history |
| `ST_MaintenanceCounter.md` | KEEP; authoritative per-device runtime service threshold |
| `Archive/Legacy/PLC/Structures/ST_Maintenance.md` | ARCHIVED; mixed Desktop/PLC structure |
| `ST_User.md` | MOVE to Desktop |

## PLC/03_Functions

### Keep categories

- scaling, clamp, limit, mapping, rounding
- time conversion and timeout checks
- CRC and Modbus helpers
- equipment readiness and feedback validation
- selector direction, limits, and transition validation
- feed amount/rate, calibration, pulse, and active-job calculations
- bounded alarm-code and priority helpers

### Move categories to Desktop

- OEE and business performance
- quality, reject, yield, and process capability metrics
- cost impact calculations
- long-term failure, maintenance, downtime, utilization, and statistical analytics
- report-oriented average and historical KPI calculations

Every retained function must be reviewed for deterministic, stateless execution. Unreviewed functions remain non-authoritative.

## PLC/04_Interfaces

| Scope | Action |
|---|---|
| `IF_Line.md` | KEEP; authoritative line command/feedback/status contract |
| Selector and diagnostics interfaces | KEEP / NORMALIZE |
| `IF_System.md` | KEEP; authoritative consolidated command/status contract |
| `Archive/Legacy/PLC/Interfaces/IF_SystemStatus.md` | ARCHIVED; superseded duplicate |
| `IF_Communication.md` | KEEP; authoritative bounded channel-health contract |
| `IF_ExecutionTransfer.md` | KEEP; authoritative atomic Desktop-to-PLC transfer contract |
| Legacy JobOrder and Recipe interfaces | ARCHIVED; CRUD and queue actions belong to Desktop |
| Service | KEEP realtime machine-service subset only |

## PLC/05_Test

- KEEP tests for the approved PLC core.
- MOVE Desktop manager tests with their corresponding Desktop specifications.
- ARCHIVE tests whose target module is archived.
- Treat all current files as test specifications, not evidence of executed tests.

## PLC/06_Documentation

| Scope | Action |
|---|---|
| Coding, naming, state machine, Modbus, alarms | KEEP / MERGE |
| Commissioning, maintenance, troubleshooting, deployment | MOVE to their lifecycle root folders |
| Backup/restore | SPLIT PLC project backup from Desktop database backup |
| Change log and version history | MOVE to release management |
| README | REWRITE after migration |

## 03_Hardware

The eight `FN_*.md` files are software functions, not hardware artifacts.

- MOVE realtime functions to the normalized PLC Functions directory.
- MOVE Desktop validation/formatting functions to Desktop.
- Reserve the Hardware/Electrical area for IO lists, drawings, BOM, panel, power, network, and device documentation.

## Execution Rule

A file marked MOVE, MERGE, or ARCHIVE remains non-authoritative until migration is completed and linked from the relevant index.


## Completed Migrations

| Date | Source | Result |
|---|---|---|
| 2026-07-25 | `PLC/01_Function_Blocks/98_FB_DeviceManager.md` | Archived as `Archive/Legacy/PLC/Function_Blocks/98_FB_DeviceManager_AssetRegistry.md`; authoritative PLC document remains `FB_DeviceManager.md`. |
| 2026-07-25 | `PLC/01_Function_Blocks/90_FB_SystemManager.md` and `01_System_Engineering/56_FB_System_Manager.md` | Consolidated into authoritative `PLC/01_Function_Blocks/FB_SystemManager.md`; both sources archived. |
| 2026-07-25 | `PLC/04_Interfaces/IF_SystemStatus.md` | Consolidated into authoritative `IF_System.md`; former interface archived. |
| 2026-07-25 | `ST_SystemStatus.md` | Normalized as bounded realtime PLC snapshot; `E_SystemState.md` added. |
| 2026-07-25 | Three LineManager source documents | Consolidated into authoritative `PLC/01_Function_Blocks/FB_LineManager.md`; sources archived without content loss. |
| 2026-07-25 | `ST_Line.md` and `IF_Line.md` | Normalized as the authoritative bounded line contract; `E_LineState.md` added. |
| 2026-07-25 | Job/Recipe structures and interfaces | Split into Desktop domain masters, bounded PLC execution snapshots, and atomic transfer contract; four mixed legacy documents archived. |
| 2026-07-25 | Alarm architecture | Consolidated manager, lifecycle enums, active structure, interface, catalog, and tests; three legacy sources archived. |
| 2026-07-25 | Modbus TCP map and communication topology | Defined fixed 4000-WORD map, corrected TCP/RTU roles, added interoperability tests, and archived two conflicting system-engineering drafts. |
| 2026-07-25 | Runtime and maintenance | Kept retentive lifetime/service counters in PLC; moved plans, users, dates, work orders, history, and analytics to Desktop. |
| 2026-07-25 | Desktop-domain managers | Removed 18 business/service manager specifications from the PLC tree; preserved them as non-authoritative Desktop design inputs and added an authoritative Desktop domain index. |
| 2026-07-25 | Integration/Edge managers | Removed eight platform-service specifications from the PLC tree; defined the Integration/Edge boundary and retained only a bounded PLC update-activation handshake. |
