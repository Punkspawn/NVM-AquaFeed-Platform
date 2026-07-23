# System Architecture

---

# Purpose

This document describes the overall architecture of the AquaFeed PLC Platform.

It defines how software modules interact, how responsibilities are separated, and how information flows through the system.

The architecture is designed to be modular, scalable and maintainable.

---

# Architectural Principles

The AquaFeed PLC Platform follows these principles:

- Modular Design
- Single Responsibility
- Layered Architecture
- Deterministic Execution
- State Machine Control
- Fail Safe Operation
- Reusable Components
- Standardized Interfaces

---

# High-Level Architecture

```text
                +----------------------+
                |        HMI           |
                +----------+-----------+
                           |
                    Modbus TCP/RTU
                           |
+------------------------------------------------------+
|                     PLC APPLICATION                  |
|------------------------------------------------------|
|                FB_SystemManager                      |
|------------------------------------------------------|
| FB_LineManager        FB_AlarmManager                |
| FB_RuntimeManager     FB_ReportManager               |
| FB_RecipeManager      FB_UserManager                 |
| FB_JobManager         FB_ModbusMaster               |
| FB_MaintenanceManager FB_Diagnostics               |
+------------------------------------------------------+
        |              |               |
        |              |               |
+---------------+ +---------------+ +---------------+
| Line 1        | | Line 2        | | Line N        |
+---------------+ +---------------+ +---------------+
| Selector      | | Selector      | | Selector      |
| Blower        | | Blower        | | Blower        |
| Dosing        | | Dosing        | | Dosing        |
+---------------+ +---------------+ +---------------+
```

---

# Software Layers

The PLC software is divided into logical layers.

## Layer 1

Hardware Interface

Responsibilities:

- Read Inputs
- Write Outputs
- Read Analog Signals
- Communication Drivers

---

## Layer 2

Equipment Layer

Contains:

- Selector
- Blower
- Dosing

Responsibilities:

- Equipment control
- Local diagnostics
- State machines

---

## Layer 3

Process Layer

Contains:

- Line Manager
- Feeding Control

Responsibilities:

- Coordinate equipment
- Execute feeding sequences
- Handle process flow

---

## Layer 4

Management Layer

Contains:

- Recipe Manager
- Job Manager
- Runtime Manager
- Alarm Manager
- Maintenance Manager
- User Manager

Responsibilities:

- System management
- Production management
- Historical data

---

## Layer 5

Communication Layer

Contains:

- Modbus Master
- HMI Interface
- External Communication

Responsibilities:

- Data exchange
- Synchronization
- Diagnostics

---

# Core Managers

## FB_SystemManager

Responsible for:

- Global initialization
- Operating mode
- Startup sequence
- Shutdown sequence
- Global status

---

## FB_LineManager

Responsible for:

- One feeding line
- Equipment coordination
- Job execution
- Runtime supervision

---

## FB_FeedingControlManager

Responsible for:

- Feeding logic
- Feeding sequence
- Feeding completion
- Feed statistics

---

## FB_AlarmManager

Responsible for:

- Alarm generation
- Alarm prioritization
- Alarm logging
- Alarm reset

---

## FB_RuntimeManager

Responsible for:

- Runtime accumulation
- Operating hours
- Statistics

---

## FB_RecipeManager

Responsible for:

- Recipe storage
- Recipe validation
- Recipe loading

---

## FB_JobManager

Responsible for:

- Job queue
- Job scheduling
- Job completion

---

## FB_ModbusMaster

Responsible for:

- Polling devices
- Register management
- Communication supervision

---

## FB_UserManager

Responsible for:

- Authentication
- Permissions
- Session management

---

## FB_ReportManager

Responsible for:

- Production reports
- Runtime reports
- Alarm reports

---

## FB_MaintenanceManager

Responsible for:

- Maintenance counters
- Service reminders
- Maintenance history

---

# Data Flow

Typical automatic operation:

```text
Operator

↓

Recipe Selection

↓

Job Creation

↓

System Manager

↓

Line Manager

↓

Selector

↓

Blower

↓

Dosing

↓

Runtime Update

↓

Report Manager

↓

Job Complete
```

---

# Fault Handling

Any module may report a fault.

Fault flow:

```text
Equipment

↓

Alarm Manager

↓

System Manager

↓

Safe State

↓

Operator Reset

↓

Initialization

↓

Ready
```

---

# Expandability

The architecture supports:

- Additional feeding lines
- Additional equipment types
- New communication drivers
- New HMI screens
- Additional reports
- Future cloud connectivity

No changes to the core architecture are required for standard expansion.

---

# Design Goals

The architecture emphasizes:

- Reliability
- Simplicity
- Scalability
- Deterministic behavior
- Serviceability
- Long-term maintainability

---

# Related Documents

- PROJECT_OVERVIEW.md
- SYSTEM_SPECIFICATION.md
- SYSTEM_REQUIREMENTS_SPECIFICATION.md
- PLC_Programming_Guideline.md
- State_Machine_Guide.md

---

# Revision

Version 1.0