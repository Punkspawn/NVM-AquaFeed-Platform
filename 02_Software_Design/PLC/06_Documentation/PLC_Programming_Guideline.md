# PLC Programming Guideline

---

# Purpose

This document defines the programming rules and engineering practices used throughout the AquaFeed PLC software.

The objective is to ensure that all PLC code remains readable, maintainable, deterministic and easy to expand throughout the system lifecycle.

---

# General Principles

- Write deterministic PLC logic.
- Every scan shall produce predictable results.
- Avoid hidden side effects.
- Keep execution order explicit.
- Use modular programming.
- Prefer reusable Function Blocks over duplicated logic.
- Every Function Block shall have one clearly defined responsibility.

---

# PLC Scan Philosophy

The PLC program shall execute in the following order:

1. Read Inputs
2. Validate Inputs
3. Execute Safety Logic
4. Execute State Machines
5. Execute Equipment Logic
6. Execute Process Logic
7. Update Runtime Data
8. Generate Alarms
9. Update Communication
10. Write Outputs

This execution order shall remain consistent throughout the project.

---

# Program Structure

Application code shall be divided into independent modules.

Example:

- System Management
- Line Management
- Feeding Control
- Equipment Control
- Communication
- Alarm Handling
- Runtime Statistics
- Maintenance
- Reporting

Each module shall expose only its public interface.

---

# Function Block Design

Each Function Block shall contain:

- Purpose
- Inputs
- Outputs
- Internal Variables
- Initialization
- Main Logic
- State Machine
- Error Handling

Function Blocks shall not directly manipulate unrelated modules.

---

# State Machine Rules

Every equipment Function Block shall operate using a deterministic state machine.

Typical states:

- Disabled
- Idle
- Ready
- Starting
- Running
- Paused
- Stopping
- Completed
- Fault

State transitions shall always be explicit.

---

# Variable Usage

Variables shall remain:

- Clearly named
- Strongly typed
- Properly initialized
- Used for one purpose only

Temporary variables shall never store permanent system data.

---

# Retentive Variables

Only critical production information shall be retained.

Examples:

- Runtime
- Maintenance Hours
- Recipe Database
- User Database
- Production Counters

Temporary process values shall never be retentive.

---

# Error Handling

Every Function Block shall detect:

- Invalid Inputs
- Communication Faults
- Equipment Faults
- Timeout Conditions
- Configuration Errors

Every detected fault shall produce an AlarmCode.

---

# Safety Rules

Safety logic always has the highest priority.

No production command may override:

- Emergency Stop
- Hardware Fault
- Critical Communication Failure
- Safety Interlock

---

# Communication

Communication shall never directly control machine outputs.

Communication shall:

- Read status
- Write commands
- Validate received data
- Reject invalid values

---

# Code Readability

Every section shall contain meaningful comments.

Avoid:

- Magic numbers
- Nested logic
- Duplicate code
- Unused variables
- Unreachable code

---

# Documentation

Every software modification shall update:

- Function Block documentation
- Interface documentation
- Test documentation
- Change Log
- Version History

---

# Revision

Version 1.0