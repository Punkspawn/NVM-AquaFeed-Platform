# NVM AquaFeed Platform
# COMMUNICATION PROTOCOL

---

# Purpose

This document defines the communication architecture between the PLC, HMI and AquaFeed Manager.

The protocol shall remain stable throughout the project.

All communication must comply with this specification.

---

# Communication Topology

Desktop Application
        │
        │ Modbus TCP
        │
Ethernet Switch
        │
        │
Delta PLC
        │
        ├── HMI
        ├── VFD Drives
        ├── Remote IO
        └── Sensors

---

# Communication Principles

PLC is the master controller of the machine.

Desktop software never controls machine logic directly.

Desktop only

- Reads
- Writes commands
- Receives status

PLC always makes the final decision.

---

# Communication Cycle

Desktop

↓

Write Commands

↓

PLC Executes

↓

PLC Updates Status

↓

Desktop Reads Status

---

# Communication Areas

Communication memory is divided into independent areas.

1000 - System

2000 - Commands

3000 - Status

4000 - Recipes

5000 - Runtime

6000 - Alarms

7000 - Diagnostics

8000 - Maintenance

9000 - Reserved

The address ranges should never overlap.

---

# System Area

Contains

System Ready

System Mode

Current User

Current Line

Heartbeat

Software Version

PLC Version

---

# Command Area

Desktop writes commands.

Examples

Start

Stop

Pause

Reset

Emergency Reset

Recipe Load

Recipe Save

Maintenance Reset

Service Command

After execution, PLC clears one-shot commands.

---

# Status Area

PLC writes machine status.

Examples

Running

Idle

Stopped

Alarm

Manual Mode

Automatic Mode

Feeding

Selector Moving

Blower Running

---

# Recipe Area

Contains

Recipe ID

Feed Amount

Feeding Time

Delay

Line Number

Batch Number

Validation Result

---

# Runtime Area

Contains

Current Runtime

Total Runtime

Cycle Counter

Daily Counter

Feed Counter

Production Counter

---

# Alarm Area

Each alarm contains

Alarm ID

Severity

Timestamp

Source

State

Acknowledged

Cleared

Desktop stores alarm history permanently.

PLC stores only active alarms.

---

# Diagnostic Area

Contains

Communication Status

PLC Scan Time

CPU Load

Memory Usage

Module Status

IO Errors

Drive Status

Sensor Status

---

# Maintenance Area

Contains

Operating Hours

Motor Hours

Blower Hours

Maintenance Counter

Next Service

Reset Counter

---

# Heartbeat

Desktop increments heartbeat every second.

PLC monitors heartbeat.

If heartbeat timeout exceeds configured limit

Communication Lost Alarm

is generated.

---

# Communication Timeout

Loss of communication

shall never stop the machine automatically.

Only remote supervision is affected.

Machine safety always remains under PLC control.

---

# Read / Write Policy

Desktop may write

Commands

Configuration

Recipes

Acknowledgements

Desktop may never write

Machine State

Alarm State

Safety Status

Internal PLC Variables

---

# Validation

PLC validates every received value.

Reject

Invalid Recipe

Invalid Line

Invalid Speed

Invalid Parameter

Generate an alarm when necessary.

---

# Time Synchronization

Desktop is the master clock.

PLC synchronizes its internal clock from Desktop.

Synchronization occurs

- Startup
- Manual Sync
- Daily Scheduled Sync

---

# Error Recovery

If communication returns

Reconnect

Validate

Synchronize

Continue

No restart should be required.

---

# Future Expansion

Communication protocol must allow future support for

OPC UA

MQTT

REST API

Cloud Gateway

without breaking existing Modbus architecture.

---

# Final Rule

Machine control always belongs to the PLC.

The Desktop supervises.

The HMI operates.

Communication only exchanges information.

Control authority never leaves the PLC.