# PLC Module Index

## Status

Authoritative scope index

## Initial PLC Core

| Module | Status | Primary responsibility |
|---|---|---|
| `FB_SystemManager` | AUTHORITATIVE | Global PLC lifecycle, operating mode, readiness, and realtime system state |
| `FB_LineManager` | AUTHORITATIVE | Deterministic execution of one active feeding job on one physical line |
| `FB_Selector` | AUTHORITATIVE | Deterministic selector positioning and local diagnostics |
| `FB_Blower` | AUTHORITATIVE | Deterministic blower/VFD sequence and airflow permission |
| `FB_Dosing` | AUTHORITATIVE | Deterministic pulse-based delivery of one accepted target |
| `FB_DeviceManager` | AUTHORITATIVE | One physical device runtime state; owns one `ST_Device` |
| `FB_AlarmManager` | AUTHORITATIVE | Bounded active lifecycle, priority summaries, acknowledgement/reset, and Desktop event handshake |
| `FB_RecoveryManager` | AUTHORITATIVE | Validated interrupted-execution recovery without automatic restart |
| `FB_TimeService` | AUTHORITATIVE | Monotonic PLC control timing and observational UTC boundary |
| `FB_CommunicationManager` | AUTHORITATIVE | Bounded Modbus TCP publication, RTU scheduling, and channel supervision |
| `FB_IOManager` | AUTHORITATIVE | Deterministic IO acquisition, validation, safe arbitration, and single-write output application |
| `FB_SafetyCoordinator` | AUTHORITATIVE | Standard-PLC mirror/inhibit coordination; never replaces hardwired safety |
| `FB_HealthMonitor` | AUTHORITATIVE | Bounded current readiness and degradation aggregation |
| `FB_DiagnosticsManager` | AUTHORITATIVE | Bounded current PLC diagnostics; no history, reporting, or predictive analytics |

## Equipment Blocks

Current release scope is governed by `AD-004_Current_Physical_Scope.md` and `01_System_Engineering/CURRENT_PHYSICAL_SCOPE.md`:

- `FB_Selector` — **IN SCOPE**
- `FB_Blower` — **IN SCOPE**
- `FB_Dosing` — **IN SCOPE**
- generic Motion manager — **EXCLUDED**; duplicates owned equipment behavior
- CIP, Water, Aeration, and Oxygen managers — **FUTURE OPTIONS**; archived until an approved scope change satisfies the admission gate

Excluded and future-option modules create no current code, IO, alarm, Modbus, test, or commissioning obligation.

## Authoritative Physical Scope

- decision: `00_Project_Management/Decisions/AD-004_Current_Physical_Scope.md`
- system scope: `01_System_Engineering/CURRENT_PHYSICAL_SCOPE.md`
- preserved optional-module sources: `Archive/Legacy/PLC/Optional_Modules/`


## Move Out of PLC

These concepts belong to Desktop:

- DatabaseSync
- ReportManager
- BackupManager
- UserManager
- Scheduler
- Recipe master-data management
- FeedProgram master-data management
- Biomass, Cage, Growth, FCR, Mortality, Harvest
- Inventory, Purchase, Warehouse, Supplier, Cost, Quality
- Notification and License management
- Analytics and Digital Twin business services

These concepts belong to Integration / Edge:

- CloudManager
- EdgeManager
- IntegrationManager
- RemoteManager
- Firmware inventory and update delivery
- platform-wide asset provisioning and discovery
- AI integration services

## Resolved Mixed Managers and Service Boundary

- DataLogger, Scheduler, RecipeManager, FeedProgramManager, NotificationManager, SecurityManager, EnergyManager, and FeedingControlManager are not active PLC Function Blocks.
- Persistent logs, calendars, recipe/program masters, notifications, identity, sessions, audit attribution, and energy analytics belong to Desktop.
- Accepted job/recipe execution is already owned by `IF_ExecutionTransfer` and `FB_LineManager`.
- Current alarm events are already owned by `FB_AlarmManager`; current measurements remain in IO/Diagnostics.
- No approved energy meter, generator-control, or demand-control equipment exists in the current physical scope.
- Legacy sources are preserved under `Archive/Legacy/PLC/Mixed_Managers/`.
- `IF_Service.md` is authoritative for fail-closed service permission. It creates no `FB_ServiceManager` and duplicates no equipment command interface.


## Structures

### Keep in PLC after normalization

- `ST_Device`
- `ST_Alarm` — active bounded alarm state only
- `ST_Line`
- `ST_LineConfig` — static approved line/equipment bounds
- `ST_Runtime` — authoritative retentive lifetime counters
- `ST_MaintenanceCounter` — per-device runtime service threshold
- `ST_SystemStatus`
- `ST_Diagnostics` — authoritative bounded current diagnostic snapshot
- `ST_IO` — authoritative non-retentive bounded process image
- `ST_ModbusMap`
- `ST_CommunicationChannel` — bounded per-channel state and counters
- `ST_TimeService` — monotonic tick/second sequence plus observational UTC
- `ST_JobExecution`
- `ST_RecipeExecution`

### Move to Desktop or split

- `ST_User` — Desktop
- `ST_OperationData` — split current PLC snapshot from Desktop history
- Desktop Maintenance domain — plans, work orders, users, dates, history, cost, and analytics

## Function Admission Rule

A PLC Function is retained only when it is:

- deterministic
- stateless
- bounded in execution time
- directly required for realtime control, validation, scaling, state transitions, Modbus, or equipment calculations

OEE, commercial cost, business analytics, report metrics, historical failure analysis, and similar calculations move to Desktop.


## Resolved Conflicts

### FB_DeviceManager

- Authoritative PLC document: `02_Software_Design/PLC/01_Function_Blocks/FB_DeviceManager.md`
- Authoritative structure: `02_Software_Design/PLC/02_Structures/ST_Device.md`
- Archived legacy concept: `Archive/Legacy/PLC/Function_Blocks/98_FB_DeviceManager_AssetRegistry.md`
- Resolution: PLC owns deterministic runtime state for one physical device. Desktop/Edge owns platform asset registry, provisioning, firmware inventory, and long-term lifecycle records.


### FB_SystemManager

- Authoritative PLC document: `02_Software_Design/PLC/01_Function_Blocks/FB_SystemManager.md`
- Archived expanded legacy concept: `Archive/Legacy/PLC/Function_Blocks/90_FB_SystemManager_PlatformOrchestrator.md`
- Archived minimal draft: `Archive/Legacy/System_Engineering/56_FB_System_Manager.md`
- Resolution: PLC owns global lifecycle, mode arbitration, readiness, safety priority, and realtime status. Desktop/Edge owns database, users, history, reports, cloud, and distributed platform orchestration.
- System contract: `E_SystemState.md`, `ST_SystemStatus.md`, and `IF_System.md` are authoritative; the former `IF_SystemStatus.md` is archived.


## Authoritative System Contract

- State enum: `02_Software_Design/PLC/02_Structures/E_SystemState.md`
- Realtime snapshot: `02_Software_Design/PLC/02_Structures/ST_SystemStatus.md`
- Command and status interface: `02_Software_Design/PLC/04_Interfaces/IF_System.md`
- Archived duplicate: `Archive/Legacy/PLC/Interfaces/IF_SystemStatus.md`


### FB_LineManager

- Authoritative PLC document: `02_Software_Design/PLC/01_Function_Blocks/FB_LineManager.md`
- Archived sources: `Archive/Legacy/PLC/Function_Blocks/57_FB_LineManager.md`, `Archive/Legacy/System_Engineering/14_Line_Manager_Specification.md`, and `Archive/Legacy/System_Engineering/74_FB_LineManager_State_Machine.md`
- Resolution: PLC owns one immutable active-job execution snapshot and equipment coordination. Desktop owns job queues, scheduling, history, statistics, and Smart Farm updates.
- Line contract: `E_LineState.md`, `ST_Line.md`, and `IF_Line.md` are authoritative.


## Authoritative Line Contract

- State enum: `02_Software_Design/PLC/02_Structures/E_LineState.md`
- Realtime snapshot: `02_Software_Design/PLC/02_Structures/ST_Line.md`
- Static bounds: `02_Software_Design/PLC/02_Structures/ST_LineConfig.md`
- Command, feedback, equipment-request, and status interface: `02_Software_Design/PLC/04_Interfaces/IF_Line.md`
- Execution transfer: `ST_JobExecution.md`, `ST_RecipeExecution.md`, and `IF_ExecutionTransfer.md` are authoritative.
- Realtime units are centi-kilograms, permille, and centi-Hz; current jobs select one Dosing unit (`16#01` or `16#02`).
- Verification: `02_Software_Design/PLC/05_Test/TEST_Line.md`.


## Authoritative Execution Transfer Boundary

- Desktop Job Order master: `03_Desktop/Domain/JobOrder.md`
- Desktop Recipe master: `03_Desktop/Domain/Recipe.md`
- PLC job snapshot: `02_Software_Design/PLC/02_Structures/ST_JobExecution.md`
- PLC recipe snapshot: `02_Software_Design/PLC/02_Structures/ST_RecipeExecution.md`
- Atomic transfer handshake: `02_Software_Design/PLC/04_Interfaces/IF_ExecutionTransfer.md`


### FB_AlarmManager

- Authoritative manager: `02_Software_Design/PLC/01_Function_Blocks/FB_AlarmManager.md`
- Active record: `02_Software_Design/PLC/02_Structures/ST_Alarm.md`
- Enums: `E_AlarmSeverity.md`, `E_AlarmSource.md`, `E_AlarmState.md`
- Interface: `02_Software_Design/PLC/04_Interfaces/IF_Alarm.md`
- Catalog: `02_Software_Design/PLC/06_Documentation/Alarm_Catalog.md`
- Desktop owns persistent history, users, timestamps, localized text, recommended actions, analytics, and notifications.


## Authoritative Communication Map

- Topology: `02_Software_Design/PLC/00_Architecture/COMMUNICATION_PROTOCOL.md`
- Flat buffer: `02_Software_Design/PLC/02_Structures/ST_ModbusMap.md`
- Register allocation: `02_Software_Design/PLC/06_Documentation/Modbus_Register_Map.md`
- Channel health interface: `02_Software_Design/PLC/04_Interfaces/IF_Communication.md`
- Interoperability test: `02_Software_Design/PLC/05_Test/TEST_ModbusTCPMap.md`


## Authoritative Runtime and Maintenance Boundary

- Decisions: `AD-002_Time_Responsibility.md`, `AD-003_Runtime_Responsibility.md`
- Lifetime runtime: `ST_Runtime.md`, `IF_Runtime.md`, `FB_RuntimeCounter.md`
- Device service threshold: `ST_MaintenanceCounter.md`, `IF_MaintenanceCounter.md`, `FB_MaintenanceCounter.md`
- Desktop maintenance domain: `03_Desktop/Domain/Maintenance.md`
- Legacy platform manager: `Archive/Legacy/PLC/Function_Blocks/84_FB_MaintenanceManager.md`


## Completed Desktop Manager Migration

The following former PLC Function Block specifications were removed from the PLC tree and preserved as non-authoritative Desktop design inputs under `03_Desktop/Legacy_Design`:

- persistence, reporting, backup, users, and licensing
- biomass, cage, growth, FCR, mortality, and harvest
- inventory, purchasing, warehouse, suppliers, and cost
- quality and analytics

Authoritative Desktop scope is indexed by `03_Desktop/Domain/DOMAIN_INDEX.md`. The historical `FB_` prefix in legacy files does not grant PLC ownership.


## Completed Integration and Edge Migration

The former Update, AI, Remote, Digital Twin, Integration, Cloud, Edge, and Firmware manager specifications were removed from the PLC tree and preserved under `04_Integration/Legacy_Design` as non-authoritative inputs.

- Integration/Edge authority: `04_Integration/INTEGRATION_INDEX.md`
- PLC boundary: `04_Integration/PLC_EDGE_BOUNDARY.md`
- PLC safe activation handshake: `02_Software_Design/PLC/04_Interfaces/IF_UpdateActivation.md`
- `FB_NetworkManager` remains queued for normalization as bounded PLC communication supervision only.


## Authoritative Diagnostics and IO Contract

- diagnostics manager: `02_Software_Design/PLC/01_Function_Blocks/88_FB_DiagnosticsManager.md`
- IO manager: `02_Software_Design/PLC/01_Function_Blocks/102_FB_IOManager.md`
- structures: `ST_Diagnostics.md` and `ST_IO.md`
- interfaces: `IF_Diagnostics.md` and `IF_IO.md`
- tests: `TEST_Diagnostics.md` and `TEST_IO.md`
- explicit Modbus diagnostics allocation: offsets 2200–2217

Expanded platform-diagnostics, predictive, report, dynamic-discovery, and history responsibilities are excluded from PLC. Original drafts are preserved under `Archive/Legacy/PLC`.


## Authoritative Core Equipment Contract

### Selector

- manager: `58_FB_Selector.md`
- state: `E_SelectorState.md`
- interface: `IF_Selector.md`
- test: `TEST_Selector.md`

### Blower

- manager: `59_FB_Blower.md`
- state: `E_BlowerState.md`
- interface: `IF_Blower.md`
- test: `TEST_Blower.md`

### Dosing

- manager: `60_FB_Dosing.md`
- state: `E_DosingState.md`
- interface: `IF_Dosing.md`
- test: `TEST_Dosing.md`

All three use latched accepted commands, idempotent sequences, bounded integer units, explicit timeouts, safe output removal, and IO Manager-owned physical outputs. Superseded PLC and System Engineering drafts are archived.


## Authoritative Communication and Time Contract

- manager: `FB_CommunicationManager.md`
- time service: `FB_TimeService.md`
- channel structure: `ST_CommunicationChannel.md`
- time structure: `ST_TimeService.md`
- interfaces: `IF_Communication.md` and `IF_Time.md`
- topology: `COMMUNICATION_PROTOCOL.md`
- tests: `TEST_Communication.md` and `TEST_Time.md`
- Modbus publication: 16 channel summaries at offsets 2218–2393

The former NetworkManager and platform TimeManager are archived. PLC does not own routing, switches, VPN, MQTT, OPC UA, cloud networking, NTP, timezone, daylight saving, or calendar scheduling.


## Authoritative Recovery, Health, and Safety Coordination

- managers: `FB_RecoveryManager.md`, `FB_HealthMonitor.md`, `FB_SafetyCoordinator.md`
- structures: `E_RecoveryState.md`, `E_SafetyCoordinationState.md`, `ST_RecoveryStatus.md`, `ST_HealthStatus.md`, `ST_SafetyStatus.md`
- interfaces: `IF_Recovery.md`, `IF_Health.md`, `IF_Safety.md`
- tests: `TEST_Recovery.md`, `TEST_Health.md`, `TEST_Safety.md`

Recovery never automatically energizes equipment after power return or safety trip. SafetyCoordinator observes approved safety hardware and removes standard-control permissions; it is not a safety-rated function or substitute for electrical safety validation.


## PLC Implementation Baseline

- source root: `02_Software_Design/PLC/07_Implementation/`
- core types: `Types/AquaFeed_CoreTypes.st`
- fixed project constants: `Globals/GVL_AquaFeed.st`
- cyclic entry point: `Programs/PRG_AquaFeedMain.st`

Only reviewed implementations are called by the main program. `FB_SystemManager`, `FB_TimeService`, the `FB_IOManager` safety core, the linear/cyclic automatic `FB_Selector` core, the deterministic `FB_Blower` core, the pulse-based `FB_Dosing` core, and the deterministic single-job `FB_LineManager` core are implemented under `07_Implementation/Function_Blocks`; physical channel configuration, Selector service jog, vendor compilation, and cyclic integration follow.
