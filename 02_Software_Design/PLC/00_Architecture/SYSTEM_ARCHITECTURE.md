# NVM AquaFeed Platform
# SYSTEM ARCHITECTURE

---

# Purpose

This document defines the overall software architecture of the NVM AquaFeed Platform.

It describes the responsibilities of each software layer and how they communicate.

---

# System Layers

The platform consists of five main layers.

1. PLC Layer

2. Communication Layer

3. Desktop Application

4. Database

5. Reporting & Diagnostics

---

# PLC Layer

Responsibilities

- Machine Control
- IO Processing
- Safety
- Motor Control
- Blower Control
- Selector Control
- Dosing Control
- Feeding Control
- Alarm Management
- Runtime Monitoring

The PLC is responsible for deterministic real-time control.

Business logic must remain outside the PLC whenever possible.

---

# Communication Layer

Communication between PLC and Desktop uses

- Modbus TCP

Future communication methods may be added later.

Responsibilities

- Register Read
- Register Write
- Connection Management
- Heartbeat
- Error Detection

---

# Desktop Layer

Application Name

AquaFeed Manager

Responsibilities

- Dashboard
- Recipe Management
- Job Orders
- Operator Interface
- Runtime Monitoring
- Reports
- Diagnostics
- Maintenance
- User Management

The desktop application contains operational and business logic.

---

# Database Layer

Stores

- Recipes
- Feeding History
- Alarm History
- Runtime Statistics
- Users
- Configuration
- Maintenance Records

The database is the permanent storage layer.

The PLC is not considered permanent storage.

---

# Reporting Layer

Responsible for

- Feeding Reports
- Alarm Reports
- Runtime Reports
- Maintenance Reports
- Statistics

Reports are generated from database records.

---

# Responsibility Distribution

PLC

Responsible for

- Machine
- Safety
- Motion
- Real-Time Control

Desktop

Responsible for

- User Interface
- Configuration
- Reports
- History
- Planning

Database

Responsible for

- Long-term Storage

---

# Existing PLC Function Blocks

Existing Function Blocks (57–110) are part of the software architecture.

They are considered stable.

Future development must reuse these modules whenever possible.

---

# Future Expansion

Future modules may include

- Cloud Integration
- AI Support
- Remote Monitoring

These are optional extensions and are not part of the core platform.

---

# Architecture Principles

The architecture follows these principles.

- Modular
- Maintainable
- Reusable
- Scalable
- Deterministic
- Production Ready

The primary objective is a stable industrial automation platform.