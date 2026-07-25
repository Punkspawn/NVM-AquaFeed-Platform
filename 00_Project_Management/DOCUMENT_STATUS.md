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

- `57_FB_LineManager.md`
- `58_FB_Selector.md`
- `59_FB_Blower.md`
- `60_FB_Dosing.md`
- `61_FB_AlarmManager.md`
- `62_FB_RecoveryManager.md`
- `63_FB_HealthMonitor.md`
- `88_FB_DiagnosticsManager.md`
- `90_FB_SystemManager.md`
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
- `FB_DeviceManager.md` — authoritative new runtime design

### Merge then archive source

- `64_FB_DataLogger.md` — keep only bounded event snapshot/buffer behavior
- `69_FB_Scheduler.md` — keep only execution of an accepted current mission
- `70_FB_RecipeManager.md` — keep only validation/use of active PLC recipe snapshot
- `71_FB_FeedProgramManager.md` — merge active execution into Line Manager
- `84_FB_MaintenanceManager.md` — retain counters/status; move history/plans
- `85_FB_NotificationManager.md` — merge active alarm signals; move notifications
- `86_FB_SecurityManager.md` — retain machine access interlocks only
- `89_FB_UpdateManager.md` — move delivery to Edge; retain safe activation rules if needed
- `95_FB_IntegrationManager.md`
- `97_FB_EdgeManager.md`
- `98_FB_DeviceManager.md` — legacy asset registry; conflicts with authoritative Device Manager
- `99_FB_FirmwareManager.md`

### Move to Desktop

- `65_FB_DatabaseSync.md`
- `66_FB_ReportManager.md`
- `67_FB_BackupManager.md`
- `68_FB_UserManager.md`
- `72_FB_BiomassManager.md`
- `73_FB_CageManager.md`
- `74_FB_GrowthManager.md`
- `75_FB_FCRManager.md`
- `76_FB_MortalityManager.md`
- `77_FB_HarvestManager.md`
- `78_FB_InventoryManager.md`
- `79_FB_PurchaseManager.md`
- `80_FB_WarehouseManager.md`
- `81_FB_SupplierManager.md`
- `82_FB_CostManager.md`
- `83_FB_QualityManager.md`
- `87_FB_LicenseManager.md`
- `94_FB_AnalyticsManager.md`

### Move to Integration / Edge

- `91_FB_AIManager.md`
- `92_FB_RemoteManager.md`
- `93_FB_DigitalTwinManager.md`
- `96_FB_CloudManager.md`
- platform-wide portions of Network, Update, Integration, Edge, Device and Firmware managers

## PLC/02_Structures

| Path | Action |
|---|---|
| `ST_Device.md` | KEEP — authoritative current structure |
| `ST_Alarm.md` | KEEP / COMPLETE |
| `ST_Diagnostics.md` | KEEP / NORMALIZE |
| `ST_Line.md` | KEEP / NORMALIZE |
| `ST_ModbusMap.md` | KEEP / NORMALIZE |
| `ST_Runtime.md` | KEEP bounded counters only |
| `ST_SystemStatus.md` | KEEP / NORMALIZE |
| `ST_JobOrder.md` | SPLIT Desktop master / PLC execution snapshot |
| `ST_Recipe.md` | SPLIT Desktop master / PLC active snapshot |
| `ST_OperationData.md` | SPLIT PLC current snapshot / Desktop history |
| `ST_Maintenance.md` | SPLIT PLC counters / Desktop history and plans |
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
| Line, selector, diagnostics, system status | KEEP / NORMALIZE |
| Communication | KEEP / NORMALIZE |
| Job order and recipe | SPLIT Desktop master / PLC snapshot |
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
