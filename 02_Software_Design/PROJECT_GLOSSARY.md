# Project Glossary

---

# Purpose

This document defines the terminology used throughout the AquaFeed PLC Platform.

The objective is to ensure that all engineers, programmers, service personnel and customers use consistent terminology.

---

# General Terms

## AquaFeed Platform

The complete PLC automation platform responsible for controlling the fish feeding barge.

---

## PLC

Programmable Logic Controller responsible for executing all control logic.

---

## HMI

Human Machine Interface used by operators to control and monitor the system.

---

## Feeding Line

A complete production line capable of delivering feed independently.

A feeding line consists of:

- Selector
- Blower
- Dosing Unit

---

## Recipe

A predefined feeding configuration containing all parameters required to execute a feeding operation.

Typical parameters include:

- Feed amount
- Feeding duration
- Blower speed
- Dosing speed

---

## Job

A scheduled or manually created feeding task executed by the PLC.

---

## Runtime

The accumulated operating time of equipment.

Used for:

- Statistics
- Maintenance
- Reports

---

## Alarm

A notification generated when abnormal operating conditions occur.

Alarms may require operator acknowledgement and reset.

---

## Warning

A non-critical notification indicating that operator attention is recommended.

Production may continue.

---

## Fault

A condition preventing normal equipment operation.

Faults typically stop the affected subsystem.

---

## Critical Alarm

A safety-related condition requiring immediate system shutdown.

Examples:

- Emergency Stop
- Safety Relay Fault
- PLC Failure

---

# Equipment

## Selector

Mechanism responsible for directing feed to the selected feeding line.

---

## Blower

Equipment providing airflow for transporting feed.

---

## Dosing Unit

Equipment controlling the amount of feed delivered.

---

# Software Modules

## System Manager

Supervises the complete PLC application.

---

## Line Manager

Coordinates one feeding line.

---

## Feeding Control Manager

Controls the feeding sequence.

---

## Recipe Manager

Stores and validates recipes.

---

## Job Manager

Schedules and supervises feeding jobs.

---

## Alarm Manager

Processes alarms and maintains alarm history.

---

## Runtime Manager

Calculates equipment operating hours.

---

## Maintenance Manager

Tracks maintenance intervals.

---

## Report Manager

Produces operational statistics.

---

## User Manager

Controls authentication and permissions.

---

## Modbus Master

Handles communication with external devices.

---

# Communication Terms

## Modbus TCP

Ethernet-based Modbus communication protocol.

---

## Modbus RTU

Serial Modbus communication protocol.

---

## Register

Memory location exchanged through Modbus.

---

## Holding Register

Writable Modbus register.

---

## Coil

Single-bit writable Modbus output.

---

## Discrete Input

Single-bit read-only Modbus input.

---

## Input Register

Read-only analog Modbus register.

---

# PLC Concepts

## Scan Cycle

One complete execution cycle of the PLC program.

---

## State Machine

A deterministic control model where operation is divided into defined states.

---

## Function Block (FB)

Reusable software component implementing a single responsibility.

---

## Function (FUN)

Reusable logic without internal memory.

---

## Structure (ST)

Custom data type grouping related variables.

---

## Interface

Standardized communication contract between software modules.

---

# Maintenance Terms

## Preventive Maintenance

Scheduled maintenance intended to prevent failures.

---

## Predictive Maintenance

Maintenance based on equipment condition and runtime data.

---

## Corrective Maintenance

Maintenance performed after a failure.

---

## Commissioning

Process of verifying and validating a newly installed system before production.

---

## FAT

Factory Acceptance Test.

Performed before shipment.

---

## SAT

Site Acceptance Test.

Performed after installation.

---

# Safety Terms

## Emergency Stop

Highest-priority safety command immediately stopping hazardous motion.

---

## Safe State

The condition in which all hazardous outputs are de-energized.

---

## Interlock

A condition preventing unsafe machine operation.

---

## Reset

Operator action required after certain faults before production may resume.

---

# Version Management

## Release

An approved software version intended for deployment.

---

## Hotfix

Emergency software correction for production systems.

---

## Rollback

Restoration of a previously approved software version.

---

## Change Request

A documented request to modify software functionality.

---

# Revision

Version 1.0