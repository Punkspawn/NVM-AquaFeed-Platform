# 86_PLC_Memory_Architecture.md

# NVM AquaFeed Platform

## PLC Memory Architecture

Document ID : AQ-MEM-086

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

Define the PLC memory organization.

Memory layout shall be scalable.

All addresses shall be documented.

--------------------------------------------------
2. Memory Sections
--------------------------------------------------

System

Communication

Parameters

Runtime

Statistics

Recovery

Service

Mission

Smart Farm Interface

--------------------------------------------------
3. Retentive Memory
--------------------------------------------------

The following data shall survive power loss.

Parameters

Calibration

Mission Queue

Statistics

Maintenance Counters

Recovery Information

Communication Settings

--------------------------------------------------
4. Non-Retentive Memory
--------------------------------------------------

Temporary Variables

Timers

Current Commands

Intermediate Calculations

--------------------------------------------------
5. Memory Rules
--------------------------------------------------

No duplicated values.

No unused variables.

Every register documented.

Every register has owner.

--------------------------------------------------

End Of Document