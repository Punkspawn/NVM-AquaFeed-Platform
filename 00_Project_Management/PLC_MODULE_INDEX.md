# PLC Module Index

## Status

Authoritative scope index

## Initial PLC Core

| Module | Status | Primary responsibility |
|---|---|---|
| `FB_SystemManager` | MERGE REQUIRED | Startup, shutdown, global mode, global realtime status |
| `FB_LineManager` | MERGE REQUIRED | One feeding line and active mission sequence |
| `FB_Selector` | KEEP / NORMALIZE | Selector positioning and local diagnostics |
| `FB_Blower` | KEEP / NORMALIZE | Blower/VFD sequence and local diagnostics |
| `FB_Dosing` | KEEP / NORMALIZE | Dosing sequence, calibration, feed delivery |
| `FB_DeviceManager` | KEEP NEW VERSION | One physical device runtime state; owns one `ST_Device` |
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
