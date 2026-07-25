# Legacy Line Manager System Specification

> **Status:** Legacy / Superseded  
> **Former path:** `01_System_Engineering/14_Line_Manager_Specification.md`  
> **Reason archived:** Useful machine sequence consolidated into the authoritative PLC LineManager; history and Smart Farm responsibilities moved to Desktop.  
> **Replacement:** `02_Software_Design/PLC/01_Function_Blocks/FB_LineManager.md`

---

# 14_Line_Manager_Specification.md

# NVM AquaFeed Platform

## Line Manager Specification

Document ID : AQ-LINE-014

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

The Line Manager is the master controller of one feeding line.

It coordinates all machines belonging to the line.

The Line Manager never controls hardware directly.

Hardware control is delegated to individual equipment modules.

--------------------------------------------------
2. Responsibilities
--------------------------------------------------

The Line Manager shall

Select Mission

Validate Parameters

Reserve Equipment

Move Selector

Wait Selector Ready

Start Blower

Wait Blower Ready

Start Dosing

Monitor Feeding

Stop Dosing

Execute Blower PostRun

Finish Mission

Update Statistics

Update Smart Farm

Store History

--------------------------------------------------
3. Controlled Equipment
--------------------------------------------------

One Selector

One Blower

One or Two Dosing Units

Assigned Silo

Assigned Cage

--------------------------------------------------
4. State Machine
--------------------------------------------------

OFF

↓

INITIALIZE

↓

READY

↓

WAIT_MISSION

↓

PREPARE

↓

MOVE_SELECTOR

↓

WAIT_SELECTOR

↓

START_BLOWER

↓

WAIT_BLOWER

↓

PRE_RUN

↓

START_DOSING

↓

FEEDING

↓

STOP_DOSING

↓

POST_RUN

↓

MISSION_COMPLETE

↓

READY

--------------------------------------------------
Additional States
--------------------------------------------------

PAUSED

MANUAL

SERVICE

RECOVERY

ALARM

--------------------------------------------------
5. Mission Validation
--------------------------------------------------

Before starting a mission

The Line Manager shall verify

Mission Exists

Mission Enabled

Target Cage Exists

Target Eye Exists

Target Silo Exists

Feed Exists

Calibration Exists

Selector Healthy

Blower Healthy

Dosing Healthy

Communication Healthy

--------------------------------------------------
6. Mission Reservation
--------------------------------------------------

The selected mission shall be locked.

No other process may modify

Target Kg

Feed Type

Target Cage

Target Silo

during execution.

--------------------------------------------------
7. Selector Sequence
--------------------------------------------------

Command

Move To Eye

↓

Wait Ready

↓

Verify Target

↓

Continue

--------------------------------------------------
8. Blower Sequence
--------------------------------------------------

Command

Run

↓

Acceleration

↓

Target Frequency

↓

PreRun Timer

↓

Ready

--------------------------------------------------
9. Dosing Sequence
--------------------------------------------------

Command

Start

↓

Pulse Counter Reset

↓

Feed Calculation

↓

Target Reached

↓

Stop

--------------------------------------------------
10. Feed Monitoring
--------------------------------------------------

During feeding

Update

Delivered Feed

Remaining Feed

Progress

Estimated Finish

Feed Rate

Pulse Counter

--------------------------------------------------
11. Pause Logic
--------------------------------------------------

Mission may pause because of

Operator

Alarm

Communication Failure

Emergency Stop

Machine Fault

When paused

Dosing stops immediately.

Blower follows configured strategy.

Mission data remains stored.

--------------------------------------------------
12. Resume Logic
--------------------------------------------------

Resume shall restart

Selector Verification

↓

Blower

↓

PreRun

↓

Dosing

The system shall never restart directly into dosing.

--------------------------------------------------
13. Cancel Logic
--------------------------------------------------

Cancel performs

Stop Dosing

↓

PostRun

↓

Mission Cancelled

↓

History Update

--------------------------------------------------
14. Emergency Stop
--------------------------------------------------

Emergency Stop

Immediately stops

Selector

Blower

Dosing

Mission becomes

PAUSED

Operator confirmation required.

--------------------------------------------------
15. Mission Completion
--------------------------------------------------

Mission finishes after

Target Feed Delivered

↓

Dosing Stop

↓

PostRun

↓

Mission Complete

↓

History Stored

↓

Smart Farm Updated

↓

Next Mission

--------------------------------------------------
16. Queue Management
--------------------------------------------------

Queue shall support

Insert

Delete

Edit

Duplicate

Reorder

Priority

Queue Capacity

Configurable

--------------------------------------------------
17. Interlocks
--------------------------------------------------

Mission cannot start if

Selector Not Ready

Blower Fault

Drive Offline

No Feed Assigned

Calibration Missing

Communication Lost

Emergency Stop Active

--------------------------------------------------
18. Runtime Statistics
--------------------------------------------------

Store

Mission Count

Completed Missions

Cancelled Missions

Paused Missions

Average Mission Time

Average Feed Rate

Average Blower Frequency

--------------------------------------------------
19. Event Logging
--------------------------------------------------

Every mission stores

Mission Start

Mission Pause

Mission Resume

Mission Cancel

Mission Complete

Alarm Events

Operator Actions

--------------------------------------------------
20. Smart Farm Update
--------------------------------------------------

After every completed mission

Update

Feed History

Daily Feed

Lot Feed

Cage Feed

FCR Calculation

Biomass

Growth Data

--------------------------------------------------
21. Parameters
--------------------------------------------------

Queue Capacity

Default Feed Delay

Resume Delay

Maximum Pause Time

Automatic Retry

Mission Timeout

--------------------------------------------------
22. Future Features
--------------------------------------------------

Mission Scheduling

Automatic Feeding Calendar

Weather Compensation

AI Optimization

Cloud Queue

Fleet Synchronization

--------------------------------------------------
23. Acceptance Criteria
--------------------------------------------------

The Line Manager shall

Control one complete feeding line.

Coordinate all equipment.

Recover after power loss.

Continue queued missions.

Protect machine sequence.

Never skip safety conditions.

--------------------------------------------------

End Of Document