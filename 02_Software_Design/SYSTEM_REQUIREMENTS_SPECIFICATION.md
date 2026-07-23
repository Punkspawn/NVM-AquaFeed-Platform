# Software Requirements Specification (SRS)

---

# Document Purpose

This document defines the functional and non-functional requirements of the AquaFeed PLC Platform.

It serves as the contractual engineering specification between the customer, project engineer and software developer.

---

# Scope

The AquaFeed PLC Platform shall control an automated fish feeding system installed on one or more feeding barges.

The software shall provide:

- Automatic feeding
- Manual equipment control
- Recipe management
- Job scheduling
- Alarm management
- Runtime monitoring
- Maintenance management
- User management
- Modbus communication
- Diagnostics
- Reporting support

---

# System Users

The system supports the following user roles.

| Role | Responsibilities |
|------|------------------|
| Administrator | Full configuration and maintenance |
| Supervisor | Production management |
| Operator | Daily operation |
| Service Engineer | Diagnostics and maintenance |

---

# Functional Requirements

## FR-001 System Startup

The PLC shall initialize all software modules during startup.

Acceptance Criteria

- All modules initialized successfully.
- No critical alarms.
- System enters Ready state.

---

## FR-002 Manual Operation

The operator shall be able to manually control equipment.

Applies to

- Selector
- Blower
- Dosing Unit

Safety interlocks shall remain active.

---

## FR-003 Automatic Feeding

The PLC shall execute a complete feeding sequence automatically.

Sequence

- Load recipe
- Prepare equipment
- Start blower
- Position selector
- Start dosing
- Monitor feeding
- Complete job
- Store statistics

---

## FR-004 Recipe Management

The system shall support recipe storage.

Each recipe shall include:

- Feed amount
- Feeding duration
- Blower parameters
- Dosing parameters

Recipes shall be editable by authorized users only.

---

## FR-005 Job Management

The software shall support scheduled feeding jobs.

Each job shall include:

- Recipe
- Target line
- Planned start time
- Status
- Completion information

---

## FR-006 Alarm Management

The software shall:

- Detect faults
- Generate alarms
- Record alarm history
- Require acknowledgement when necessary
- Support alarm reset

---

## FR-007 Runtime Monitoring

The PLC shall record:

- Equipment runtime
- Feeding duration
- Feed quantity
- Job statistics
- Maintenance counters

---

## FR-008 Communication

The PLC shall communicate using:

- Modbus TCP
- Modbus RTU

Communication failures shall generate alarms.

---

## FR-009 User Management

The system shall provide:

- User authentication
- Role-based permissions
- Password management
- Session control

---

## FR-010 Maintenance Management

The PLC shall monitor maintenance intervals.

Maintenance reminders shall be generated automatically.

---

## FR-011 Diagnostics

The software shall provide diagnostic information including:

- Active state
- Active alarms
- Communication status
- Runtime information
- Equipment status

---

# Non-Functional Requirements

## Reliability

The software shall operate continuously without unexpected interruptions.

---

## Maintainability

The software architecture shall remain modular.

Function Blocks shall be independently maintainable.

---

## Scalability

The architecture shall allow additional production lines without redesign.

---

## Safety

Emergency Stop shall override every production command.

---

## Performance

The PLC scan time shall remain within the approved project limits.

---

## Availability

The system shall recover safely following a power interruption.

Retentive data shall be preserved.

---

## Traceability

Every software release shall be traceable to:

- Requirements
- Function Blocks
- Tests
- Documentation
- Version History

---

# Constraints

The project shall use:

- IEC 61131-3 programming principles
- Modular Function Block architecture
- State Machine control philosophy
- Modbus communication
- Structured documentation

---

# Acceptance Criteria

The software shall be accepted when:

- All requirements are implemented.
- All mandatory tests pass.
- FAT completed.
- SAT completed.
- Documentation approved.
- Customer acceptance obtained.

---

# Requirement Traceability

Every requirement shall be traceable to:

- Function Block
- Interface
- Test Document
- Software Version
- Change Log

---

# Revision

Version 1.0