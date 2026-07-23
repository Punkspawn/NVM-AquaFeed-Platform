# State Machine Guide

---

# Purpose

This document defines the standard state machine architecture used throughout the AquaFeed PLC software.

Every equipment controller and system manager shall implement the same state model to ensure deterministic behavior, simplified debugging and consistent operation.

---

# Objectives

The state machine architecture shall:

- Ensure deterministic execution
- Prevent undefined behavior
- Simplify troubleshooting
- Standardize equipment behavior
- Improve software maintainability
- Support safe fault recovery

---

# Standard State Model

Every equipment Function Block shall implement the following states where applicable:

```text
Disabled
      │
      ▼
Initialize
      │
      ▼
Idle
      │
      ▼
Ready
      │
      ▼
Starting
      │
      ▼
Running
      │
      ▼
Stopping
      │
      ▼
Completed
```

Fault conditions may occur from any operational state.

```text
Any State
    │
    ▼
 Fault
    │
 Reset
    ▼
 Initialize
```

---

# State Definitions

## Disabled

Purpose

- Equipment unavailable
- Maintenance mode
- Hardware not configured

Allowed Transitions

- Initialize

---

## Initialize

Purpose

- Initialize variables
- Reset timers
- Reset outputs
- Verify communication
- Verify configuration

Exit Conditions

- Initialization complete

Next State

- Idle

---

## Idle

Purpose

- Waiting for enable command
- Outputs OFF
- Ready to perform prechecks

Exit Conditions

- Enable command received

Next State

- Ready

---

## Ready

Purpose

- Equipment available
- Preconditions verified
- Waiting for Start command

Checks

- No active alarms
- Communication healthy
- Safety OK
- Equipment healthy

Next State

- Starting

---

## Starting

Purpose

Execute startup sequence.

Typical actions

- Enable drive
- Start timers
- Verify feedback
- Wait for Ready feedback

Successful Completion

- Running

Failure

- Fault

---

## Running

Purpose

Normal operation.

Typical actions

- Execute control algorithm
- Monitor sensors
- Update runtime
- Check alarms
- Exchange communication

Possible Transitions

- Paused
- Stopping
- Fault

---

## Paused

Purpose

Temporary interruption without cancelling the current process.

Typical actions

- Hold outputs in defined state
- Preserve production context
- Pause runtime accumulation

Possible Transitions

- Running
- Stopping
- Fault

---

## Stopping

Purpose

Controlled shutdown.

Typical actions

- Disable outputs
- Stop motors
- Stop timers
- Save production data

Next State

- Completed

---

## Completed

Purpose

Successful completion of the current operation.

Typical actions

- Store statistics
- Update reports
- Notify Job Manager

Next State

- Ready

---

## Fault

Purpose

Safe handling of abnormal conditions.

Typical actions

- Stop all hazardous motion
- Disable outputs
- Generate alarm
- Record diagnostics
- Preserve critical runtime data

Exit Conditions

- Fault removed
- Operator Reset
- Safety verification successful

Next State

- Initialize

---

# State Transition Rules

Every transition shall satisfy the following:

- Explicit transition condition
- Valid destination state
- Exit actions completed
- Entry actions executed
- No skipped mandatory states

Transitions shall never occur implicitly.

---

# Fault Priority

Fault processing always overrides production logic.

Priority order:

1. Emergency Stop
2. Safety Fault
3. Drive Fault
4. Communication Fault
5. Equipment Fault
6. Process Fault
7. Operator Command

---

# Entry and Exit Actions

Each state shall define:

Entry Actions

- Executed once when entering the state

Exit Actions

- Executed once before leaving the state

Continuous Actions

- Executed every PLC scan while the state is active

---

# State Diagram Requirements

Every equipment documentation shall include:

- State list
- Transition conditions
- Fault transitions
- Recovery transitions
- Reset behavior

---

# Implementation Guidelines

Recommended implementation:

```text
CASE currentState OF

    Disabled:

    Initialize:

    Idle:

    Ready:

    Starting:

    Running:

    Paused:

    Stopping:

    Completed:

    Fault:

END_CASE;
```

Each state shall only execute its own logic.

---

# Best Practices

- Never change more than one state per PLC scan.
- Validate all transition conditions before changing state.
- Use enumerations for state definitions.
- Log state transitions when diagnostic mode is enabled.
- Do not perform output changes outside the active state logic.
- Ensure every fault transition leads to a defined Safe State.

---

# Related Documents

- PLC_Programming_Guideline.md
- Coding_Standard.md
- Alarm_Catalog.md
- TEST_SystemIntegration.md
- TEST_Safety.md

---

# Revision

Version 1.0