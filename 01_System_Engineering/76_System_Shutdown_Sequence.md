# 76_System_Shutdown_Sequence.md

# NVM AquaFeed Platform

## System Shutdown Sequence

Document ID : AQ-SYS-076

Version : 1.0

--------------------------------------------------
Purpose
--------------------------------------------------

Define the controlled shutdown procedure.

Unexpected shutdown shall never corrupt runtime data.

--------------------------------------------------

Shutdown Sequence

Operator Stop

↓

Reject New Missions

↓

Finish Active Mission

↓

Execute Blower PostRun

↓

Save Mission Queue

↓

Save Runtime Counters

↓

Save Statistics

↓

Save Parameters

↓

Shutdown Complete

--------------------------------------------------

Emergency Shutdown

↓

Immediately stop outputs

↓

Store recovery information

↓

Wait power loss

--------------------------------------------------

End Of Document