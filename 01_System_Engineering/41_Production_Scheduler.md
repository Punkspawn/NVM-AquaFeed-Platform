# 41_Production_Scheduler.md

# NVM AquaFeed Platform

## Production Scheduler

Document ID : AQ-PRD-041

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

Production Scheduler is responsible for organizing all feeding operations.

Its objective is to maximize production efficiency while minimizing operator workload.

Scheduler never controls hardware directly.

Hardware control belongs to AquaCore.

--------------------------------------------------
2. Philosophy
--------------------------------------------------

Operator knows the farm.

Software organizes the work.

Operator can override every automatic decision.

--------------------------------------------------
3. Scheduler Modes
--------------------------------------------------

Manual

Semi Automatic

Automatic Queue

--------------------------------------------------
4. Manual Mode
--------------------------------------------------

Operator creates one mission.

Operator starts mission.

Mission executes.

Queue ignored.

--------------------------------------------------
5. Queue Mode
--------------------------------------------------

Operator creates multiple missions.

Example

Mission 1

Line 1

Cage A01

250 kg

----------------------

Mission 2

Line 2

Cage B04

180 kg

----------------------

Mission 3

Line 5

Cage F02

320 kg

The scheduler executes them according to queue order.

--------------------------------------------------
6. Parallel Execution
--------------------------------------------------

Each line has an independent scheduler.

Example

Line 1

Running

----------------------

Line 2

Running

----------------------

Line 3

Waiting

----------------------

Line 4

Paused

----------------------

Line 5

Running

----------------------

Line 6

Idle

--------------------------------------------------
7. Queue Rules
--------------------------------------------------

Mission order may be changed.

Mission priority may be changed.

Mission may be duplicated.

Mission may be disabled.

Mission may be inserted.

Mission may be removed.

--------------------------------------------------
8. Queue Lock
--------------------------------------------------

Running mission

cannot be modified.

Waiting missions

may be modified.

--------------------------------------------------
9. Scheduler Recovery
--------------------------------------------------

After PLC restart

Scheduler restores

Waiting Missions

Paused Missions

Completed Missions

Current Queue Position

--------------------------------------------------
10. Future

Automatic Mission Optimization

Automatic Queue Sorting

Weather Based Queue

AI Optimization

--------------------------------------------------

End Of Document