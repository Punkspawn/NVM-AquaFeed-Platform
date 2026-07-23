# 26_Recovery_System.md

# NVM AquaFeed Platform

## Recovery System

Document ID : AQ-REC-026

Version : 1.0

--------------------------------------------------
Purpose

Recover safely after unexpected shutdown.

--------------------------------------------------

Unexpected Events

Power Failure

PLC Restart

Drive Restart

Communication Failure

--------------------------------------------------

Stored Information

Current Mission

Delivered Feed

Remaining Feed

Selector Position

Current Cage

Current Silo

Feed Type

--------------------------------------------------

Recovery Sequence

PLC Start

↓

Read Retentive Memory

↓

Restore Mission

↓

Operator Confirmation

↓

Resume

or

Cancel

--------------------------------------------------

Mission shall never disappear after restart.

--------------------------------------------------

End Of Document