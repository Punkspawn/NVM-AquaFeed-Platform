# FB_LineManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Deterministic execution of one active feeding job on one physical line |
| Instance rule | One instance per feeding line |
| Version | 1.0 |
| Governing boundary | [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md) |

---

## Purpose

`FB_LineManager` coordinates one complete feeding line.

Each instance owns the realtime sequence for one accepted active job and coordinates its assigned Selector, Blower, and one or two Dosing equipment blocks.

It never writes physical outputs directly. Equipment-specific Function Blocks own physical commands, feedback validation, interlocks, and local faults.

---

## Responsibilities

`FB_LineManager` shall:

- accept one immutable active-job snapshot
- validate realtime execution parameters and equipment readiness
- reserve its assigned line equipment for the active job
- position and verify the Selector
- start and verify the Blower
- enforce blower pre-run before dosing
- start and monitor the selected Dosing unit or units
- track bounded delivered quantity, remaining quantity, elapsed time, and progress
- stop dosing before stopping airflow
- enforce blower post-run
- publish one deterministic line state
- pause, stop, cancel, recover, or fault using defined transitions
- preserve safe active execution during Desktop communication loss
- expose completion and fault events for Desktop persistence

## Architectural Exclusions

`FB_LineManager` shall not:

- select jobs from a database or business queue
- create or edit recipes
- own cage, fish-lot, biomass, FCR, inventory, cost, or Smart Farm data
- store historical missions, operator actions, reports, or long-term statistics
- authenticate users
- directly control physical IO
- dynamically allocate equipment
- use blocking loops, `WAIT`, or unbounded processing

Desktop owns job-order master data, scheduling, history, reporting, and Smart Farm updates. The PLC receives one validated execution snapshot.

---

## Controlled Equipment

One line normally coordinates:

- one Selector
- one Blower
- one or two Dosing units
- the approved silo/feed source reference
- the target selector position/cage reference

Equipment assignments are configuration, not runtime discovery.

---

## Active Job Snapshot

Before execution, the Desktop or approved scheduling boundary transfers one bounded snapshot containing at least:

- Job ID
- Line ID
- Recipe ID
- Target selector position
- Selected dosing unit(s)
- Feed target in kilograms
- Dosing setpoint
- Blower setpoint
- Blower pre-run time
- Blower post-run time
- permitted retry/recovery policy

The snapshot is immutable from acceptance until Complete, Cancelled, or Faulted. Updated Desktop master data shall not change an active PLC execution.

---

## Lifecycle States

The authoritative sequence uses one primary state:

```text
OFF
INITIALIZING
READY
LOAD_JOB
VALIDATE
MOVE_SELECTOR
WAIT_SELECTOR
START_BLOWER
WAIT_BLOWER
PRE_RUN
START_DOSING
FEEDING
STOP_DOSING
POST_RUN
COMPLETE
PAUSED
STOPPING
RECOVERY
FAULT
EMERGENCY
SERVICE
```

The authoritative `E_LineState`, `ST_Line`, and `IF_Line` documents encode these states and boundaries.

---

## Normal Feeding Sequence

```text
Ready
  ↓
Load immutable job snapshot
  ↓
Validate job, line, safety, and equipment
  ↓
Move Selector
  ↓
Verify target position and settle
  ↓
Start Blower
  ↓
Verify Blower ready
  ↓
Pre-run airflow timer
  ↓
Start selected Dosing unit(s)
  ↓
Feed until target quantity
  ↓
Stop Dosing
  ↓
Post-run airflow timer
  ↓
Stop Blower
  ↓
Complete
  ↓
Ready
```

The sequence shall not skip Selector verification, Blower verification, or pre-run before dosing.

---

## Realtime Validation

A job may start only when:

- global line permission is active
- emergency input is inactive
- safety input is healthy
- no blocking line fault exists
- job snapshot is valid and assigned to this line
- feed target and required setpoints are within configured bounds
- target selector position is valid
- assigned Selector is enabled, available, and fault-free
- assigned Blower is enabled, available, and fault-free
- required Dosing unit(s) are enabled, available, and fault-free
- no other job is active on this line

Business validation such as fish-lot existence, commercial stock, operator permissions, and scheduling priority occurs in Desktop before transfer.

---

## Command and Feedback Boundary

### Inputs from System Manager

- global line enable
- requested mode
- start, pause, stop, cancel, and reset commands
- emergency, safety, and blocking-fault summary

### Inputs from equipment blocks

- ready, running, stopped, position, quantity/pulse feedback
- local fault and communication status
- operational interlock status

### Outputs to equipment blocks

- Selector target and move request
- Blower run request and setpoint
- Dosing run request and setpoint
- reset request only after acceptance rules pass

### Published outputs

- current line state
- ready, busy, running, paused, completed, faulted
- active Job ID and Recipe ID references
- delivered and remaining feed
- progress and bounded elapsed/remaining time
- current selector target and equipment summary
- active alarm/fault identifier

---

## Pause and Resume

On Pause:

1. stop Dosing immediately
2. keep or stop Blower according to the approved safe pause policy
3. preserve the immutable job snapshot and delivered quantity
4. enter Paused only after the required equipment feedback is confirmed

Resume shall never restart directly into Dosing.

Resume path:

```text
Paused
  ↓
Revalidate safety, job, and equipment
  ↓
Reverify Selector position
  ↓
Start and verify Blower
  ↓
Apply pre-run
  ↓
Resume Dosing from remaining target
```

---

## Stop and Cancel

Controlled Stop or Cancel:

1. stop Dosing
2. confirm Dosing stopped
3. apply required Blower post-run
4. stop Blower
5. confirm line equipment safe
6. publish stopped/cancelled execution result

Desktop persists the result and updates history. PLC retains only the bounded current/last-result handshake required by the communication contract.

---

## Fault and Emergency

Priority:

```text
Emergency
  ↓
Safety or blocking fault
  ↓
Controlled stop/cancel
  ↓
Pause
  ↓
Normal sequence
```

Emergency action is defined by approved machine safety engineering. The PLC state reflects the safety result but does not replace hardwired safety.

A fault reset is accepted only after the physical condition is removed and all affected equipment is safe.

---

## Recovery

Recovery is permitted only when:

- emergency is inactive
- safety is healthy
- the blocking fault is removed
- equipment states are known
- the immutable active-job snapshot is still valid
- delivered quantity is trustworthy
- recovery policy explicitly permits continuation

If quantity or equipment state cannot be trusted, the job shall be safely cancelled instead of guessed.

Recovery always re-enters through Selector and Blower verification. It never resumes directly into Dosing.

---

## Desktop Communication Loss

Desktop communication is diagnostic, not a direct safety interlock.

If communication is lost during a healthy active job:

- PLC continues the deterministic sequence
- no new job is accepted
- current status and completion event remain available for later synchronization
- safety and equipment faults still act normally

---

## Execution Rules

- execute once per PLC scan
- one primary state per instance
- no blocking loops
- no `WAIT` instructions
- IEC timers are state-owned and non-blocking
- validate feedback before every forward transition
- commands are removed when their state no longer owns them
- completion is a one-scan event plus a latched result handshake if required by Modbus
- one line fault shall not stop another healthy line unless a shared safety/resource condition requires it

---

## Invariants

```text
DosingRunning -> BlowerRunning
DosingRunning -> SelectorAtTarget
Running -> ActiveJobValid
Complete -> DeliveredFeed >= accepted target tolerance
Fault -> NOT Ready
Emergency -> Dosing command removed
DesktopCommunicationLost -> no new job accepted
One line instance -> one active job maximum
```

---

## Minimum Tests

1. Disabled line remains Off.
2. Healthy enabled line reaches Ready.
3. Invalid job snapshot is rejected.
4. Selector must reach and confirm target before Blower start.
5. Dosing cannot start before Blower ready and pre-run complete.
6. Target quantity stops Dosing before post-run.
7. Pause stops Dosing and preserves progress.
8. Resume repeats Selector and Blower verification.
9. Cancel performs safe Dosing stop and Blower post-run.
10. Emergency forces the approved emergency state from every sequence state.
11. Active blocking fault prevents start and forward transition.
12. Reset is rejected while the fault remains.
13. Desktop loss during healthy feeding does not stop the job.
14. Desktop loss prevents acceptance of a new job.
15. One line fault does not stop another independent healthy line.
16. Unknown delivered quantity prevents automatic recovery.
17. No illegal state transition is accepted.
18. Completion event is emitted exactly once.

---

## Dependencies

- `ST_Line`
- `ST_JobExecution`
- `ST_RecipeExecution`
- `IF_ExecutionTransfer`
- `FB_Selector`
- `FB_Blower`
- `FB_Dosing`
- `FB_DeviceManager`
- `FB_AlarmManager`
- `FB_RecoveryManager`
- `FB_SystemManager`

---

## Legacy Sources

The following sources were consolidated into this specification:

- [AQ-FB-057](../../../../Archive/Legacy/PLC/Function_Blocks/57_FB_LineManager.md)
- [AQ-LINE-014](../../../../Archive/Legacy/System_Engineering/14_Line_Manager_Specification.md)
- [AQ-FB-074](../../../../Archive/Legacy/System_Engineering/74_FB_LineManager_State_Machine.md)

---

## Related Documents

- [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md)
- [PLC Module Index](../../../00_Project_Management/PLC_MODULE_INDEX.md)
- [FB_SystemManager](FB_SystemManager.md)
- [FB_DeviceManager](FB_DeviceManager.md)
- [ST_Line](../02_Structures/ST_Line.md)
- [IF_Line](../04_Interfaces/IF_Line.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [ST_JobExecution](../02_Structures/ST_JobExecution.md)
- [ST_RecipeExecution](../02_Structures/ST_RecipeExecution.md)

---

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Consolidated authoritative one-line realtime execution specification. |
