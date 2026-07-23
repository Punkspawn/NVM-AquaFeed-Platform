# 80_System_Event_Bus.md

# NVM AquaFeed Platform

## Event Bus

Document ID : AQ-EVT-080

Version : 1.0

--------------------------------------------------
Purpose
--------------------------------------------------

Standardize communication between Function Blocks.

--------------------------------------------------

Example Events

Mission Started

Mission Finished

Selector Ready

Blower Ready

Feed Started

Feed Finished

Alarm Raised

Alarm Cleared

Maintenance Due

--------------------------------------------------

Every event contains

Timestamp

Source

Event ID

Severity

Description

--------------------------------------------------

Events shall never directly control outputs.

--------------------------------------------------

End Of Document