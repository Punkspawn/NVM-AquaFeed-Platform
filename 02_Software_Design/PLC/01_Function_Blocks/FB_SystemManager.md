# FB_SystemManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Global PLC lifecycle, operating mode, and realtime system state |
| Version | 1.0 |
| Governing boundary | [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md) |

---

## Purpose

`FB_SystemManager` is the highest-level realtime coordinator inside the PLC application.

It evaluates global safety and readiness conditions, arbitrates the requested operating mode, controls the PLC lifecycle state, and publishes one consistent `ST_SystemStatus` snapshot every scan.

It does not directly control selector, blower, dosing, or other physical equipment. Equipment Function Blocks and `FB_LineManager` own their sequences.

---

## Responsibilities

`FB_SystemManager` shall:

- initialize bounded PLC runtime state
- evaluate emergency, safety, fault, communication, and line-readiness inputs
- arbitrate Automatic, Manual, Service, and Simulation mode requests
- control the global PLC lifecycle state
- coordinate enable permission for line managers
- publish one consistent `ST_SystemStatus`
- preserve a healthy active feeding operation during Desktop communication loss
- require removed fault conditions before accepting reset
- provide deterministic status to HMI, Desktop, diagnostics, and Modbus publication

## Architectural Exclusions

`FB_SystemManager` shall not:

- directly execute equipment motion or feeding sequences
- authenticate users or manage sessions
- own database, reports, historical records, inventory, cost, or analytics
- orchestrate cloud, farms, fleets, or distributed business services
- treat Desktop communication as a safety condition
- replace hardwired emergency or safety circuits
- persist unbounded event history
- dynamically discover modules at runtime

The archived legacy documents remain reference material only:

- [AQ-FB-056](../../../../Archive/Legacy/System_Engineering/56_FB_System_Manager.md)
- [AQ-FB-090](../../../../Archive/Legacy/PLC/Function_Blocks/90_FB_SystemManager_PlatformOrchestrator.md)

---

## Lifecycle States

The authoritative lifecycle uses one primary state:

```iecst
TYPE E_SystemState :
(
    SYSTEM_OFF,
    SYSTEM_INITIALIZING,
    SYSTEM_READY,
    SYSTEM_RUNNING,
    SYSTEM_PAUSED,
    SYSTEM_STOPPING,
    SYSTEM_FAULT,
    SYSTEM_EMERGENCY
);
END_TYPE
```

### State priority

```text
Emergency
    ↓
Safety or blocking fault
    ↓
Stopping
    ↓
Running / Paused
    ↓
Ready
    ↓
Initializing
    ↓
Off
```

Emergency and active safety conditions always override production commands.

---

## Interface

### Inputs

```iecst
VAR_INPUT
    xEnable                 : BOOL;
    xStart                  : BOOL;
    xStop                   : BOOL;
    xPause                  : BOOL;
    xReset                  : BOOL;

    xAutoRequest            : BOOL;
    xManualRequest          : BOOL;
    xServiceRequest         : BOOL;
    xSimulationRequest      : BOOL;

    xEmergencyStop          : BOOL;
    xSafetyOK               : BOOL;
    xBlockingFault          : BOOL;
    xAllRequiredLinesReady  : BOOL;
    xAnyLineRunning         : BOOL;
    xAllLinesStopped        : BOOL;
    xDesktopCommunicationOK : BOOL;
END_VAR
```

### In-Out data

```iecst
VAR_IN_OUT
    stSystemStatus          : ST_SystemStatus;
END_VAR
```

### Outputs

```iecst
VAR_OUTPUT
    xSystemReady            : BOOL;
    xLineEnable             : BOOL;
    xModeConflict           : BOOL;
    xResetAccepted          : BOOL;
END_VAR
```

---

## Mode Arbitration

Exactly one requested mode may be active.

| Valid request | Result |
|---|---|
| Automatic only | Automatic mode |
| Manual only | Manual mode |
| Service only | Service mode |
| Simulation only | Simulation mode |
| No request | No active operating mode |
| Two or more requests | Mode conflict; all modes rejected |

Automatic line execution is enabled only in Automatic mode while the system is Ready, Running, or Paused as allowed by the line contract.

Service Mode shall prevent automatic feeding.

Simulation Mode shall prevent physical outputs unless a separate approved IO simulation boundary explicitly permits them.

---

## Readiness Rule

The system is ready only when:

```text
Enabled
AND SafetyOK
AND NOT EmergencyStop
AND NOT BlockingFault
AND AllRequiredLinesReady
AND ExactlyOneValidMode
```

Desktop communication is deliberately excluded from this rule.

Loss of Desktop communication shall raise a communication status or alarm, but shall not stop a healthy feeding sequence already controlled by the PLC.

---

## State Transitions

| Current state | Condition | Next state |
|---|---|---|
| Off | Enable | Initializing |
| Initializing | Safety OK, no blocking fault, valid mode, lines ready | Ready |
| Ready | Start accepted in Automatic mode | Running |
| Running | Pause | Paused |
| Paused | Start and readiness restored | Running |
| Ready/Running/Paused | Stop | Stopping |
| Stopping | All lines stopped | Ready |
| Any | Blocking fault | Fault |
| Any | Emergency stop | Emergency |
| Fault | Fault removed and reset accepted | Initializing |
| Emergency | Emergency removed and reset accepted | Initializing |
| Any non-running state | Disable | Off |

Undefined transitions are rejected.

---

## Reset Rules

A reset request is accepted only when:

- emergency input is inactive
- safety chain is healthy
- blocking fault condition has been removed
- no line is still in an unsafe stopping state

Reset clears latched manager diagnostics; it does not bypass active equipment faults or safety circuits.

---

## Cyclic Execution Order

Every PLC scan:

1. read physical and communication inputs
2. execute safety and IO processing
3. execute equipment Function Blocks
4. execute Device Managers
5. execute Line Managers
6. evaluate System Manager inputs
7. execute `FB_SystemManager`
8. execute Alarm and Communication publication
9. apply physical outputs

`FB_SystemManager` coordinates permissions and state; it does not call unbounded background services.

---

## Status Publication Rules

Only `FB_SystemManager` may write the global lifecycle and mode fields in `ST_SystemStatus`.

Equipment summary fields shall be copied from bounded Line Manager snapshots. User identity, recipe master data, job master data, and historical information remain Desktop-owned; only current numeric references required for realtime execution may be published by the PLC.

`xDesktopCommunicationOK` updates communication status only. It shall not force Fault or Emergency.

---

## Invariants

```text
EmergencyStop -> SystemState = SYSTEM_EMERGENCY
BlockingFault -> NOT SystemReady
SystemRunning -> AutoMode
ServiceMode -> NOT SystemRunning
ModeConflict -> NOT SystemReady
LineEnable -> SafetyOK AND NOT EmergencyStop AND NOT BlockingFault
NOT (AutoMode AND ManualMode)
```

Simulation and Service modes shall also remain mutually exclusive with other operating modes.

---

## Minimum Tests

1. Disabled system remains Off.
2. Enabled healthy system reaches Ready.
3. Emergency input forces Emergency from every state.
4. Active blocking fault prevents Ready and Running.
5. Reset is rejected while emergency or fault remains active.
6. Simultaneous mode requests raise conflict and prevent Ready.
7. Automatic Start transitions Ready to Running.
8. Pause and resume follow defined transitions.
9. Stop waits for all lines to report stopped.
10. Desktop communication loss does not stop a healthy running cycle.
11. Service Mode prevents automatic production.
12. Undefined state transitions are rejected.
13. Only one primary lifecycle state is published.
14. Line enable is removed on emergency or blocking fault.

---

## Dependencies

- `ST_SystemStatus`
- `E_SystemState`
- `FB_LineManager`
- `FB_AlarmManager`
- `FB_RecoveryManager`
- `FB_CommunicationManager`
- `FB_IOManager`
- `FB_SafetyManager`

---

## Related Documents

- [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md)
- [PLC Module Index](../../../00_Project_Management/PLC_MODULE_INDEX.md)
- [ST_SystemStatus](../02_Structures/ST_SystemStatus.md)
- [IF_System](../04_Interfaces/IF_System.md)
- [IF_SystemStatus](../04_Interfaces/IF_SystemStatus.md)
- [FB_DeviceManager](FB_DeviceManager.md)

---

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Consolidated authoritative PLC System Manager specification. |
