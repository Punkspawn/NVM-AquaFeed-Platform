# System Specification

---

# Document Purpose

This document defines the complete functional specification of the AquaFeed PLC Platform.

It serves as the primary engineering reference describing what the system shall do, independent of software implementation details.

---

# System Description

The AquaFeed Platform is an automated fish feeding system designed to distribute feed accurately and safely to multiple production lines installed on a feeding barge.

The PLC coordinates all equipment while monitoring system status, alarms, communication, maintenance data and production statistics.

---

# Main Functional Requirements

The system shall:

- Control multiple feeding lines.
- Support automatic and manual operation.
- Execute predefined feeding recipes.
- Schedule feeding jobs.
- Monitor equipment status.
- Generate alarms.
- Record runtime statistics.
- Track maintenance intervals.
- Communicate with external devices through Modbus.
- Maintain production history.

---

# Main Components

## PLC

Responsible for:

- Process control
- Safety supervision
- Communication
- Runtime calculations
- Alarm processing

---

## HMI

Responsible for:

- Operator interface
- Recipe editing
- Alarm display
- Runtime monitoring
- Maintenance information
- User login

---

## Feeding Line

Each feeding line consists of:

- Selector
- Blower
- Dosing Unit

Each line operates independently.

---

# Operating Modes

## Manual Mode

Operator directly controls equipment.

Characteristics:

- Individual equipment control
- Maintenance use
- Commissioning support
- Diagnostics

---

## Automatic Mode

PLC executes the complete feeding sequence automatically.

Sequence includes:

- Recipe loading
- Equipment preparation
- Feeding
- Completion
- Statistics update

---

## Maintenance Mode

Production commands are disabled.

Only maintenance functions are permitted.

---

# Functional Modules

The PLC software contains:

- System Manager
- Line Manager
- Feeding Control Manager
- Recipe Manager
- Job Manager
- Alarm Manager
- Runtime Manager
- Maintenance Manager
- Report Manager
- User Manager
- Modbus Master

---

# Safety Functions

The software shall:

- Monitor Emergency Stop
- Detect communication failures
- Detect equipment faults
- Stop hazardous movement
- Prevent unsafe restart

Safety logic always has priority.

---

# Alarm Management

The system shall:

- Detect abnormal conditions
- Classify alarm severity
- Record alarm history
- Require acknowledgement where necessary
- Support manual and automatic reset

---

# Runtime Monitoring

The software records:

- Equipment runtime
- Feeding duration
- Feed quantity
- Production statistics
- Maintenance counters

---

# Communication

Supported protocols:

- Modbus TCP
- Modbus RTU

Communication is supervised continuously.

Communication failures shall generate alarms.

---

# User Management

Supported roles:

- Administrator
- Supervisor
- Operator
- Service

Permissions depend on user role.

---

# Reporting

The system stores:

- Feeding history
- Alarm history
- Runtime history
- Maintenance history
- Production statistics

---

# Expandability

The architecture supports:

- Additional feeding lines
- New equipment
- New communication protocols
- Additional HMI pages
- Future software modules

No architectural redesign shall be required for normal system expansion.

---

# Non-Functional Requirements

The system shall be:

- Reliable
- Deterministic
- Modular
- Maintainable
- Scalable
- Testable
- Fault tolerant

---

# Acceptance Criteria

The system is accepted when:

- All functional tests pass.
- Safety verification passes.
- Communication is stable.
- Performance meets specifications.
- Documentation is complete.
- FAT and SAT are approved.

---

# Related Documents

- PROJECT_OVERVIEW.md
- PLC_Programming_Guideline.md
- Commissioning_Guide.md
- Software_Release_Process.md

---

# Revision

Version 1.0