# 05_Communication_Architecture.md

# NVM AquaFeed Platform
## Communication Architecture Specification

Document ID : AQ-COM-005

Version : 0.1

Status : Draft

--------------------------------------------------

# 1. Purpose

This document defines every communication interface used by the AquaFeed Platform.

The communication architecture shall be modular, scalable and hardware independent.

Future hardware replacements shall require minimum software modifications.

--------------------------------------------------

# 2. Communication Layers

Level 4

Cloud Services (Future)

↓

Level 3

AquaFeed Manager

↓

Level 2

PLC

↓

Level 1

Drives

Sensors

Remote IO

--------------------------------------------------

# 3. PLC Communication

The PLC is the communication master.

All communication requests shall originate from the PLC.

Slave devices shall never initiate communication.

--------------------------------------------------

# 4. PC Communication

Protocol

Modbus TCP

Connection

Ethernet

Default Port

502

Functions

Read Holding Registers

Write Holding Registers

Read Coils

Write Multiple Registers

--------------------------------------------------

# 5. Drive Communication

Protocol

Modbus RTU

Physical Layer

RS485

Master

PLC

Slave

Delta VFD

--------------------------------------------------

# 6. RS485 Rules

Single master only.

Every drive shall have a unique address.

Maximum retry count shall be configurable.

Communication timeout shall be configurable.

Communication errors shall be counted.

--------------------------------------------------

# 7. Communication Manager

Every communication channel shall be controlled by Communication Manager.

Responsibilities

Open Communication

Close Communication

Retry Failed Messages

Timeout Detection

CRC Verification

Statistics

Device Status

--------------------------------------------------

# 8. Device Addressing

Each drive shall have a unique address.

Example

Blower 1 = 1

Dose 1 = 2

Dose 2 = 3

Blower 2 = 4

...

The address list shall be configurable.

--------------------------------------------------

# 9. Heartbeat

PLC shall generate heartbeat every second.

Windows application shall monitor heartbeat.

If heartbeat is lost

Connection Status = Offline

Machine shall continue operating.

--------------------------------------------------

# 10. Communication Diagnostics

Statistics shall include

Total Messages

Failed Messages

Retries

CRC Errors

Timeouts

Average Response Time

--------------------------------------------------

# 11. Future Expansion

Future communication modules

MQTT

REST API

OPC UA

Cloud Gateway

VPN Remote Service

--------------------------------------------------

END OF DOCUMENT