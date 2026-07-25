# PLC Module Index

## Status

Authoritative scope index

## Initial PLC Core

| Module | Status | Primary responsibility |
|---|---|---|
| `FB_SystemManager` | AUTHORITATIVE | Global PLC lifecycle, operating mode, readiness, and realtime system state |
| `FB_LineManager` | AUTHORITATIVE | Deterministic execution of one active feeding job on one physical line |
| `FB_Selector` | KEEP / NORMALIZE | Selector positioning and local diagnostics |
| `FB_Blower` | KEEP / NORMALIZE | Blower/VFD sequence and local diagnostics |
| `FB_Dosing` | KEEP / NORMALIZE | Dosing sequence, calibration, feed delivery |
| `FB_DeviceManager` | AUTHORITATIVE | One physical device runtime state; owns one `ST_Device` |
| `FB_AlarmManager` | MERGE REQUIRED | Active alarms, priorities, acknowledgement/reset rules |
| `FB_RecoveryManager` | KEEP / NORMALIZE | Deterministic recovery sequences |
| `FB_CommunicationManager` | DESIGN REQUIRED | Modbus exchange and communication supervision |
| `FB_IOManager` | KEEP / NORMALIZE | IO acquisition, validation, and output application |
| `FB_SafetyManager` | REVIEW | Realtime safety coordination; must not replace hardwired safety |
| `FB_HealthMonitor` | REVIEW | Bounded realtime health status only |

## Equipment Blocks

The following remain PLC responsibilities when limited to physical equipment control:

- `FB_Selector`
- `FB_Blower`
- `FB_Dosing`
- water, aeration, and oxygen blocks only when corresponding physical equipment is in project scope
- motion and CIP blocks only when a concrete realtime machine requirement is approved

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

## Structures

### Keep in PLC after normalization

- `ST_Device`
- `ST_Alarm` — active bounded alarm state only
- `ST_Line`
- `ST_Runtime` — bounded counters only
- `ST_SystemStatus`
- `ST_Diagnostics`
- `ST_ModbusMap`
- realtime subset of `ST_JobOrder`
- realtime subset of `ST_Recipe`

### Move to Desktop or split

- `ST_User` — Desktop
- `ST_OperationData` — split current PLC snapshot from Desktop history
- `ST_Maintenance` — split PLC counters/status from Desktop history and plans

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
- Command, feedback, equipment-request, and status interface: `02_Software_Design/PLC/04_Interfaces/IF_Line.md`
- Pending boundary split: replace temporary `ST_JobOrder` and `ST_Recipe` inputs with bounded PLC execution structures.
