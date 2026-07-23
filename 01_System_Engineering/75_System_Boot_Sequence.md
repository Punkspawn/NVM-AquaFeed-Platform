# 75_System_Boot_Sequence.md

# NVM AquaFeed Platform

## System Boot Sequence

Document ID : AQ-SYS-075

--------------------------------------------------

Power ON

↓

PLC Boot

↓

Load Retentive Parameters

↓

Load Calibration

↓

Read Configuration

↓

Communication Initialization

↓

Drive Detection

↓

Health Check

↓

Initialize FBs

↓

System READY

--------------------------------------------------

If Any Error

↓

ALARM

↓

Wait Service

--------------------------------------------------

End Of Document