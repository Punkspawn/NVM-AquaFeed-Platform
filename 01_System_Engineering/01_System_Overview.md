# NVM AquaFeed Platform
## Engineering Specification

Document ID : AQ-SPC-001

Version : 0.1

Status : Draft

---

# 1. Project Vision

NVM AquaFeed Platform is a professional aquaculture automation platform developed by NVM Engineering.

The project consists of two major software components.

## AquaCore

Industrial PLC software responsible for real-time machine control.

## AquaFeed Manager

Windows based management software responsible for production management, Smart Farm features, reporting, configuration and remote service.

Future mobile applications will use the same backend.

---

# 2. Design Goals

The platform shall satisfy the following goals.

• Reliable 24/7 operation

• Easy operation

• Easy maintenance

• Modular architecture

• Hardware abstraction

• Future scalability

• Service friendly diagnostics

• Smart Farm integration

• AI ready

---

# 3. System Configuration

Current project configuration

Number of Feeding Lines

6

PLC

Single Delta DVP-SV3

Communication

PLC ↔ PC

Modbus TCP

PLC ↔ VFD

Modbus RTU

Programming Language

Structured Text

---

# 4. Feeding Line Architecture

Each feeding line contains

• One Selector

• One Blower

• Two Dosing Units

• Multiple Fish Cages

Each line operates independently.

A fault on one line shall never stop another line.

---

# 5. Main Equipment

## Selector

Purpose

Direct feed to the selected fish cage.

Features

Automatic Positioning

Manual Positioning

Service Positioning

Analog Position Feedback

Limit Sensors

Position Calibration

Timeout Detection

Health Monitoring

Ready Signal

---

## Blower

Purpose

Generate airflow for pneumatic feed transport.

Features

Delta VFD

Frequency Control

Minimum Speed Protection

Pre Run

Post Run

Runtime Counter

Maintenance Counter

Fault Monitoring

---

## Dosing Unit

Purpose

Transfer fish feed into airflow.

Features

Delta VFD

Gearbox Driven

Inductive Revolution Sensor

Kg Per Revolution Calibration

Automatic Feed Calculation

Feed Rate Control

Runtime Counter

Maintenance Counter

---

# 6. Feeding Process

The feeding sequence shall always follow the same order.

STEP 1

Move Selector

↓

STEP 2

Verify Position

↓

STEP 3

Wait Settle Time

↓

STEP 4

Start Blower

↓

STEP 5

Wait PreRun Time

↓

STEP 6

Feed Delay

↓

STEP 7

Start Dosing

↓

STEP 8

Feed Until Target Weight

↓

STEP 9

Stop Dosing

↓

STEP 10

Blower PostRun

↓

STEP 11

Mission Completed

The sequence shall never change unless modified by engineering.

---

# 7. Mission System

Each feeding operation is called a Mission.

A mission contains

Mission ID

Fish Cage

Selector Eye

Feed Type

Feed Amount

Feed Rate

Selected Silo

Selected Line

Operator

Start Time

Finish Time

Status

The system shall support queued missions.

Mission queue capacity shall be configurable.

---

# 8. Smart Farm

Every cage shall have its own digital record.

Each cage stores

Cage Name

Fish Lot

Species

Stock Date

Fish Count

Average Weight

Mortality

Feed Consumption

Biomass

FCR

Harvest Estimate

Historical Feed Records

Future versions shall support AI camera integration.

---

# 9. Service Philosophy

The PLC is always the master controller.

Windows software shall never be required for machine operation.

Loss of PC communication shall not stop production.

Service engineers shall have access to

IO Monitor

IO Force

Calibration

Diagnostics

Parameter Management

Communication Diagnostics

Flight Recorder

Maintenance Counters

Health Monitor

---

# 10. General Principles

The software shall follow the following principles.

Single PLC Architecture

Independent Feeding Lines

Function Block Oriented Design

Structured Text Programming

Central Alarm Management

Central Communication Manager

Parameter Driven Behaviour

Retentive Parameters

No Direct Register Access

Hardware Abstraction Layer

Scheduler Based Execution

State Machine Control

Scalable Design

Remote Service Ready

Future Mobile Integration

Future Cloud Integration

---

# 11. Future Modules

The architecture shall support future development.

Planned modules

Android Application

iOS Application

Cloud Synchronization

AI Fish Detection

Predictive Maintenance

ERP Integration

Fleet Management

Automatic Reporting

Remote Firmware Update

---

# 12. Product Philosophy

The operator knows the fish.

The software knows the machine.

The platform assists the operator but never replaces operational experience.

Machine safety is mandatory.

Operational flexibility is encouraged.

The software shall explain problems instead of only reporting errors.

The goal of AquaFeed Platform is to create the easiest fish feeding system to operate while maintaining industrial reliability.

---

END OF DOCUMENT