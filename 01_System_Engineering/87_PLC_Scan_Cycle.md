# 87_PLC_Scan_Cycle.md

# NVM AquaFeed Platform

## PLC Scan Cycle

Document ID : AQ-SCN-087

--------------------------------------------------

Every PLC scan shall execute in the following order.

--------------------------------------------------

Read Inputs

↓

Update Communication

↓

Update Service Commands

↓

Update Parameters

↓

Execute System Manager

↓

Execute Alarm Manager

↓

Execute Health Monitor

↓

Execute Scheduler

↓

Execute Line Managers

↓

Execute Selector FB

↓

Execute Blower FB

↓

Execute Dosing FB

↓

Execute Statistics

↓

Write Outputs

--------------------------------------------------

Execution order shall never change without engineering approval.

--------------------------------------------------

End Of Document