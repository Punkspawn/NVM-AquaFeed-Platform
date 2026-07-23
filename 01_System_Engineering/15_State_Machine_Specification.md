# 15_State_Machine_Specification.md

# NVM AquaFeed Platform

## State Machine Specification

Document ID : AQ-STM-015

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

The AquaCore software is completely event-driven.

Every machine and every feeding line shall operate using a deterministic finite state machine.

No module shall execute undefined transitions.

Every transition shall have a known entry condition and exit condition.

--------------------------------------------------
2. Design Rules
--------------------------------------------------

One active state only.

No hidden states.

No jump transitions.

No recursive execution.

Every state shall have

Entry Action

Execution Action

Exit Condition

Timeout

Alarm Strategy

--------------------------------------------------
3. Global Line States
--------------------------------------------------

OFF

INITIALIZE

READY

WAIT_MISSION

PREPARE

MOVE_SELECTOR

WAIT_SELECTOR

START_BLOWER

WAIT_BLOWER

PRE_RUN

START_DOSING

FEEDING

STOP_DOSING

POST_RUN

MISSION_COMPLETE

PAUSED

SERVICE

RECOVERY

ALARM

--------------------------------------------------
4. OFF
--------------------------------------------------

Purpose

Machine without permission.

Outputs

OFF

Exit Condition

System Initialization

--------------------------------------------------
5. INITIALIZE
--------------------------------------------------

Actions

Load Parameters

Load Configuration

Initialize Variables

Read IO

Reset Temporary Variables

Verify Communication

Verify Hardware

Exit

Initialization Completed

--------------------------------------------------
6. READY
--------------------------------------------------

System ready.

Waiting operator command.

Allowed Commands

Start Mission

Manual Mode

Service Mode

--------------------------------------------------
7. WAIT_MISSION
--------------------------------------------------

Waiting queue.

If Queue Empty

Remain Waiting.

If Queue Available

Go PREPARE.

--------------------------------------------------
8. PREPARE
--------------------------------------------------

Validate

Mission

Feed

Silo

Selector

Blower

Dosing

Communication

Interlocks

Exit

Everything Valid

--------------------------------------------------
9. MOVE_SELECTOR
--------------------------------------------------

Command

Target Eye

Start Movement

Exit

Busy = TRUE

--------------------------------------------------
10. WAIT_SELECTOR
--------------------------------------------------

Monitor

Busy

Ready

Alarm

Timeout

Exit

Selector Ready

--------------------------------------------------
11. START_BLOWER
--------------------------------------------------

Command

RUN

Target Frequency

Exit

Drive Running

--------------------------------------------------
12. WAIT_BLOWER
--------------------------------------------------

Monitor

Drive Ready

Frequency

Communication

Fault

Exit

Ready

--------------------------------------------------
13. PRE_RUN
--------------------------------------------------

Timer

Configurable

Purpose

Air Stabilization

Exit

Timer Finished

--------------------------------------------------
14. START_DOSING
--------------------------------------------------

Reset Counters

Start Drive

Start Feed Calculation

Exit

Pulse Received

--------------------------------------------------
15. FEEDING
--------------------------------------------------

Loop

Read Pulse

Calculate Feed

Update Progress

Monitor Alarm

Monitor Pause

Monitor Stop

Exit

Target Reached

--------------------------------------------------
16. STOP_DOSING
--------------------------------------------------

Command

Motor Stop

Verify Stop

Exit

Stopped

--------------------------------------------------
17. POST_RUN
--------------------------------------------------

Run blower.

No dosing.

Purpose

Empty pipe.

Exit

Timer Finished

--------------------------------------------------
18. MISSION_COMPLETE
--------------------------------------------------

Actions

History

Statistics

Smart Farm

Maintenance Counters

Queue Update

Next Mission

--------------------------------------------------
19. PAUSED
--------------------------------------------------

Causes

Operator

Alarm

Emergency

Communication

Power Loss Recovery

Allowed Actions

Resume

Cancel

Service

--------------------------------------------------
20. SERVICE
--------------------------------------------------

Mission suspended.

Engineering control active.

Mission queue locked.

--------------------------------------------------
21. RECOVERY
--------------------------------------------------

Power restored.

PLC restarted.

Restore

Mission

Counters

Parameters

Statistics

Ask operator

Resume

or

Cancel

--------------------------------------------------
22. ALARM
--------------------------------------------------

Stop related machine.

Store alarm.

Update history.

Wait acknowledgement.

--------------------------------------------------
23. Transition Rules
--------------------------------------------------

Transitions only occur

After Exit Condition.

Never from timer only.

Never from scan count.

Always event driven.

--------------------------------------------------
24. State Timeout
--------------------------------------------------

Every active state

may have

Timeout.

Timeout generates

Alarm

and

Transition.

--------------------------------------------------
25. State Logging
--------------------------------------------------

Store

Current State

Previous State

Entry Time

Exit Time

Duration

Transition Reason

--------------------------------------------------
26. Future Expansion
--------------------------------------------------

Future states may be added

without redesign.

Reserved IDs

100...199

--------------------------------------------------
27. Acceptance Criteria
--------------------------------------------------

Every mission shall follow

exactly one valid path.

Every transition shall be logged.

Unexpected transitions shall generate diagnostics.

--------------------------------------------------

End Of Document