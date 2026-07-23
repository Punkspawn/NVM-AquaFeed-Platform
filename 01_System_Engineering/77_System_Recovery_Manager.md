# 77_System_Recovery_Manager.md

# NVM AquaFeed Platform

## Recovery Manager

Document ID : AQ-REC-077

Version : 1.0

--------------------------------------------------
Purpose
--------------------------------------------------

Recover safely after unexpected power loss.

--------------------------------------------------

Stored Data

Current Mission

Current Line

Current Cage

Current Feed

Delivered Feed

Remaining Feed

Mission State

Current Selector Eye

Current Blower Status

Current Dosing Status

--------------------------------------------------

Recovery Sequence

PLC Boot

↓

Load Recovery Data

↓

Validate Mission

↓

Validate Hardware

↓

Ask Operator

Resume

Cancel

--------------------------------------------------

Recovery shall never automatically resume feeding.

Operator confirmation required.

--------------------------------------------------

End Of Document