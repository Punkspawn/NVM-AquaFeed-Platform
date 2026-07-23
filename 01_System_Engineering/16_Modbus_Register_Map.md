# 16_Modbus_Register_Map.md

# NVM AquaFeed Platform

## Modbus Register Specification

Document ID : AQ-MOD-016

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

Defines the complete Modbus memory map between

PLC

Windows Software

Future Mobile Gateway

--------------------------------------------------
2. Rules
--------------------------------------------------

Holding Registers

Configuration

Input Registers

Read Only Values

Coils

Commands

Discrete Inputs

Status

--------------------------------------------------
3. Register Allocation
--------------------------------------------------

00001-00999

System

01000-01999

Line 1

02000-02999

Line 2

03000-03999

Line 3

04000-04999

Line 4

05000-05999

Line 5

06000-06999

Line 6

07000-07999

Service

08000-09999

Reserved

--------------------------------------------------
4. Line Register Layout
--------------------------------------------------

Mission ID

Current State

Current Cage

Current Eye

Current Feed

Remaining Feed

Progress %

Blower Frequency

Blower Current

Selector Position

Dosing Pulse

Alarm Code

Health Score

--------------------------------------------------
5. Commands
--------------------------------------------------

Start Mission

Stop Mission

Pause Mission

Resume Mission

Reset Alarm

Manual Mode

Service Mode

--------------------------------------------------
6. Future Expansion
--------------------------------------------------

Cloud Gateway

REST API

MQTT

Edge Gateway

--------------------------------------------------

End Of Document