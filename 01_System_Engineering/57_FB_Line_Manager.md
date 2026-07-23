# 57_FB_Line_Manager.md

# NVM AquaFeed Platform

## Function Block Design

--------------------------------------------------
Purpose
--------------------------------------------------

Controls one complete feeding line.

One instance per line.

Current Project

6 Instances

--------------------------------------------------
Inputs
--------------------------------------------------

Mission

Commands

Parameters

Selector Status

Blower Status

Dosing Status

--------------------------------------------------
Outputs
--------------------------------------------------

Mission State

Current Progress

Remaining Feed

Alarm

Ready

Busy

--------------------------------------------------
Execution

Every PLC Scan

--------------------------------------------------
Internal Modules

Mission Manager

Sequence Manager

Interlock Manager

Recovery Manager

History Manager

--------------------------------------------------