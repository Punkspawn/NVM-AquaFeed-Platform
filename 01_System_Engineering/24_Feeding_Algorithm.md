# 24_Feeding_Algorithm.md

# NVM AquaFeed Platform

## Feeding Algorithm Specification

Document ID : AQ-ALG-024

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

This document defines the complete feeding algorithm.

The algorithm shall guarantee safe, repeatable and uninterrupted feed delivery.

The algorithm shall be deterministic.

No undefined behaviour is allowed.

--------------------------------------------------
2. Feeding States
--------------------------------------------------

Idle

↓

Mission Selected

↓

System Check

↓

Selector Positioning

↓

Selector Verification

↓

Blower Start

↓

PreRun

↓

Feed Delay

↓

Dosing

↓

Target Verification

↓

PostRun

↓

Mission Complete

--------------------------------------------------
3. Preconditions
--------------------------------------------------

Before feeding starts

System shall verify

PLC Healthy

Communication Healthy

No Emergency Stop

Mission Valid

Feed Assigned

Silo Assigned

Cage Assigned

Selector Healthy

Blower Healthy

Dosing Healthy

--------------------------------------------------
4. Selector Stage
--------------------------------------------------

Move selector.

Monitor analog value.

Compare with target.

When

Position OK

AND

Settle Time Finished

↓

Generate

Selector Ready

--------------------------------------------------
5. Blower Stage
--------------------------------------------------

Run blower.

Ramp to target frequency.

Verify

Actual Frequency

Communication

No Fault

Wait

PreRun Time

Generate

Blower Ready

--------------------------------------------------
6. Feed Delay
--------------------------------------------------

Additional delay after blower ready.

Purpose

Guarantee stable air velocity.

--------------------------------------------------
7. Feeding Stage
--------------------------------------------------

Start dosing.

Reset pulse counter.

Start feed calculation.

Every pulse

↓

Update delivered feed

↓

Update remaining feed

↓

Update progress

--------------------------------------------------
8. Feed Completion
--------------------------------------------------

If

Delivered Feed

>=

Target Feed

↓

Stop dosing.

--------------------------------------------------
9. Pipe Cleaning
--------------------------------------------------

Blower continues.

Timer

↓

PostRun

↓

Stop blower.

--------------------------------------------------
10. Mission Finish
--------------------------------------------------

Store history.

Update Smart Farm.

Update reports.

Update maintenance counters.

Load next mission.

--------------------------------------------------
11. Pause Behaviour
--------------------------------------------------

Pause immediately

Stops dosing.

Blower behaviour depends on parameter.

Resume starts from

Blower Verification.

--------------------------------------------------
12. Emergency Behaviour
--------------------------------------------------

Emergency Stop

↓

Immediately stop all outputs.

↓

Store mission.

↓

Mission becomes PAUSED.

--------------------------------------------------
13. Recovery
--------------------------------------------------

Power returns.

Restore mission.

Ask operator

Resume

or

Cancel

--------------------------------------------------
14. Future

Adaptive feeding.

Fish behaviour analysis.

AI optimization.

--------------------------------------------------

End Of Document