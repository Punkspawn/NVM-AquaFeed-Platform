# 46_Feeding_Strategy_Engine.md

# NVM AquaFeed Platform

## Feeding Strategy Engine

Document ID : AQ-FSE-046

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

The Feeding Strategy Engine determines how a feeding mission shall be executed.

Unlike the Mission Manager, which executes commands, the Feeding Strategy Engine decides the feeding strategy.

--------------------------------------------------
2. Philosophy
--------------------------------------------------

The operator decides

WHAT

to feed.

The software decides

HOW

to feed.

The operator may override any automatic decision.

--------------------------------------------------
3. Strategy Types
--------------------------------------------------

Continuous Feeding

Batch Feeding

Slow Start

Progressive Feeding

Custom Strategy

--------------------------------------------------
4. Continuous Feeding
--------------------------------------------------

Blower starts.

↓

PreRun

↓

Dosing starts.

↓

Feed until target.

↓

PostRun.

--------------------------------------------------
5. Batch Feeding
--------------------------------------------------

Feed

50 kg

↓

Wait

10 seconds

↓

Feed

50 kg

↓

Repeat

--------------------------------------------------
6. Progressive Feeding
--------------------------------------------------

Start

30 Hz

↓

35 Hz

↓

40 Hz

↓

45 Hz

↓

Target Completed

Purpose

Reduce feed shock.

--------------------------------------------------
7. Strategy Parameters
--------------------------------------------------

Feed Rate

Pause Interval

Pause Duration

Ramp Time

Maximum Frequency

Minimum Frequency

--------------------------------------------------
8. Future

Fish Activity Feedback

Automatic Strategy Selection

--------------------------------------------------

End Of Document