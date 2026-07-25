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
- `58_FB_Selector.md` — AUTHORITATIVE
- `59_FB_Blower.md` — AUTHORITATIVE
- `60_FB_Dosing.md` — AUTHORITATIVE
- `FB_AlarmManager.md` — KEEP; authoritative bounded PLC alarm lifecycle
- `Archive/Legacy/PLC/Function_Blocks/61_FB_AlarmManager.md` — ARCHIVED
- `FB_RecoveryManager.md` — AUTHORITATIVE; former numbered draft archived
- `FB_HealthMonitor.md` — AUTHORITATIVE bounded readiness; predictive scope excluded
- `88_FB_DiagnosticsManager.md` — AUTHORITATIVE; bounded current PLC diagnostics only
- `FB_SystemManager.md` — KEEP; authoritative consolidated PLC specification
- `Archive/Legacy/PLC/Function_Blocks/90_FB_SystemManager_PlatformOrchestrator.md` — ARCHIVED
- `FB_CommunicationManager.md` — AUTHORITATIVE bounded channel supervision; former `100_FB_NetworkManager.md` archived
- `FB_TimeService.md` — AUTHORITATIVE monotonic control time; former `101_FB_TimeManager.md` archived
- `102_FB_IOManager.md` — AUTHORITATIVE; deterministic process-image and output arbitration
- `FB_SafetyCoordinator.md` — AUTHORITATIVE standard-PLC coordination; former SafetyManager archived
- `FB_DeviceManager.md` — KEEP; authoritative PLC runtime design

### Excluded and future optional modules

- `Archive/Legacy/PLC/Optional_Modules/103_FB_MotionManager.md` — ARCHIVED / EXCLUDED; duplicates Selector, Blower, and Dosing equipment ownership
- `Archive/Legacy/PLC/Optional_Modules/106_FB_CIPManager.md` — ARCHIVED / FUTURE OPTION
- `Archive/Legacy/PLC/Optional_Modules/107_FB_WaterManager.md` — ARCHIVED / FUTURE OPTION
- `Archive/Legacy/PLC/Optional_Modules/108_FB_AerationManager.md` — ARCHIVED / FUTURE OPTION
- `Archive/Legacy/PLC/Optional_Modules/109_FB_OxygenManager.md` — ARCHIVED / FUTURE OPTION

Current authority is `AD-004_Current_Physical_Scope.md` and `01_System_Engineering/CURRENT_PHYSICAL_SCOPE.md`. Reactivation requires an approved scope change and admission-gate evidence.

### Resolved mixed managers

- `Archive/Legacy/PLC/Mixed_Managers/64_FB_DataLogger.md` — ARCHIVED; persistence, archive, search, and synchronization belong to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/69_FB_Scheduler.md` — ARCHIVED; calendar and queue scheduling belong to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/70_FB_RecipeManager.md` — ARCHIVED; recipe master/version/history belongs to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/71_FB_FeedProgramManager.md` — ARCHIVED; program and meal planning belong to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/85_FB_NotificationManager.md` — ARCHIVED; PLC retains only current alarm state
- `Archive/Legacy/PLC/Mixed_Managers/86_FB_SecurityManager.md` — ARCHIVED; identity, roles, passwords, sessions, and audit belong to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/104_FB_EnergyManager.md` — ARCHIVED; no approved physical energy-control scope; analytics belong to Desktop
- `Archive/Legacy/PLC/Mixed_Managers/110_FB_FeedingControlManager.md` — ARCHIVED; duplicates execution transfer, LineManager, Dosing, and Desktop domains
- `FB_RuntimeCounter.md` and `FB_MaintenanceCounter.md` — KEEP; authoritative PLC counters
- `Archive/Legacy/PLC/Function_Blocks/84_FB_MaintenanceManager.md` — ARCHIVED; platform maintenance belongs to Desktop
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
| `ST_Diagnostics.md` | KEEP; authoritative bounded current diagnostic snapshot |
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
| `IF_Service.md` | AUTHORITATIVE; fail-closed service permission only, with no users, credentials, output forcing, or duplicate equipment commands |

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
| 2026-07-25 | Diagnostics and IO | Normalized bounded structures, managers, interfaces, tests, safe output arbitration, and explicit Modbus diagnostic offsets; archived seven expanded drafts. |
| 2026-07-25 | Selector, Blower, and Dosing | Normalized three core equipment state machines, integer-unit interfaces, safety/interlock behavior, and tests; archived 16 superseded sources. |
| 2026-07-25 | Communication, Network, and Time | Replaced platform network/time managers with bounded channel supervision and monotonic PLC time; added interfaces, structures, tests, and 16 Modbus channel summaries. |
| 2026-07-25 | Recovery, Health, and Safety | Defined restart-safe recovery, bounded readiness aggregation, and standard-PLC safety coordination; archived five expanded manager/test sources. |
| 2026-07-25 | Optional physical modules | Accepted AD-004; excluded duplicate generic Motion and archived CIP, Water, Aeration, and Oxygen as future options with an explicit admission gate. |
| 2026-07-25 | Mixed managers and service interface | Archived eight cross-domain/duplicate managers and normalized `IF_Service` as a fail-closed permission contract. |
