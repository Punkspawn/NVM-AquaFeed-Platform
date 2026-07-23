# Project Structure

---

# Purpose

This document describes the directory organization of the AquaFeed PLC Platform.

The objective is to provide a consistent engineering structure that is easy to maintain, expand and understand.

Every project artifact shall reside in its designated directory.

---

# Root Structure

```text
AquaFeed Platform
│
├── 01_Project_Management
├── 02_Software_Design
├── 03_HMI
├── 04_Electrical
├── 05_Documents
├── 06_Test
├── 07_Commissioning
├── 08_Service
├── 09_Releases
└── README.md
```

---

# PLC Software Structure

```text
02_Software_Design
│
├── PLC
│   ├──00_Architecture
│   ├──01_Function_Blocks
│   ├──02_Structures
│   ├──03_Functions
│   ├──04_Interfaces
│   ├──05_Test
│   └──06_Documentation
│
├── PROJECT_OVERVIEW.md
├── SYSTEM_SPECIFICATION.md
├── SYSTEM_REQUIREMENTS_SPECIFICATION.md
├── SYSTEM_ARCHITECTURE.md
├── PROJECT_GLOSSARY.md
└── PROJECT_STRUCTURE.md
```

---

# PLC Folder Description

## 00_Architecture

Contains:

- System Architecture
- Execution Flow
- Data Flow
- Communication Architecture
- State Machine Architecture

---

## 01_Function_Blocks

Contains complete documentation for every Function Block.

Each document includes:

- Purpose
- Inputs
- Outputs
- Internal Variables
- State Machine
- Execution Logic
- Dependencies

---

## 02_Structures

Contains every project data structure.

Examples:

- ST_Line
- ST_Recipe
- ST_Alarm
- ST_Runtime
- ST_User

---

## 03_Functions

Contains reusable software functions.

Functions contain no persistent internal memory.

---

## 04_Interfaces

Defines communication contracts between modules.

Each interface documents:

- Inputs
- Outputs
- Usage
- Rules
- Dependencies

---

## 05_Test

Contains all software verification documents.

Includes:

- Unit Tests
- Integration Tests
- FAT
- SAT
- Performance Tests
- Regression Tests
- Validation Reports

---

## 06_Documentation

Contains engineering documentation.

Examples:

- Programming Guidelines
- Coding Standards
- Naming Convention
- Alarm Catalog
- Modbus Register Map
- Commissioning Guide
- Maintenance Guide
- Deployment Guide

---

# Engineering Workflow

Development follows the sequence below.

```text
Requirements

↓

Architecture

↓

Function Blocks

↓

Structures

↓

Functions

↓

Interfaces

↓

Implementation

↓

Testing

↓

Documentation

↓

Release

↓

Deployment

↓

Maintenance
```

---

# Dependency Rules

Modules shall depend only on lower-level abstractions.

Preferred dependency direction:

```text
System Manager

↓

Line Manager

↓

Equipment FBs

↓

Functions

↓

Structures
```

Circular dependencies are prohibited.

---

# Documentation Rules

Every engineering document shall include:

- Purpose
- Scope
- Description
- Revision
- Related Documents

Documents shall be updated before software release.

---

# File Naming Rules

Use:

- PascalCase for document names.
- English language only.
- Underscore (`_`) as separator.
- Meaningful descriptive names.

Examples:

- System_Architecture.md
- Alarm_Catalog.md
- Commissioning_Guide.md
- Version_History.md

Avoid:

- file1.md
- newdoc.md
- temp.md

---

# Revision Management

Every document shall:

- Maintain revision history.
- Reference related documents.
- Be reviewed before release.
- Remain synchronized with software changes.

---

# Expandability

The directory structure supports future additions including:

- New Function Blocks
- Additional communication protocols
- Multiple PLC platforms
- Additional HMIs
- Cloud services
- Remote diagnostics

No restructuring should be required for standard project growth.

---

# Revision

Version 1.0