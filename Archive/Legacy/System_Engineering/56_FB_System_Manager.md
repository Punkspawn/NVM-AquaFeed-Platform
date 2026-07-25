# Legacy System Manager Draft

> **Status:** Legacy / Superseded  
> **Former path:** `01_System_Engineering/56_FB_System_Manager.md`  
> **Former identity:** `FB_SystemManager` / `AQ-FB-056`  
> **Reason archived:** Useful minimal draft consolidated into the authoritative PLC System Manager specification.  
> **Implementation rule:** Use the active `FB_SystemManager.md` document for implementation.

---

# 56_FB_System_Manager.md

# NVM AquaFeed Platform

## FB_SystemManager Design Specification

Document ID : AQ-FB-056

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

FB_SystemManager is the highest level software module inside AquaCore.

It coordinates the entire PLC application.

It does NOT control machines directly.

--------------------------------------------------
2. Responsibilities
--------------------------------------------------

• Initialize system

• Load configuration

• Verify hardware

• Execute scheduler

• Execute communication

• Execute Line Managers

• Execute diagnostics

• Execute health monitor

--------------------------------------------------
3. Inputs
--------------------------------------------------

Power On

Emergency Stop

PLC Status

Communication Status

Service Mode

--------------------------------------------------
4. Outputs
--------------------------------------------------

System Ready

System Alarm

System Warning

Scheduler Enable

--------------------------------------------------
5. Controlled Modules
--------------------------------------------------

FB_Communication

FB_HealthMonitor

FB_AlarmManager

FB_LineManager[1..6]

FB_Service

--------------------------------------------------
6. Startup Sequence
--------------------------------------------------

Power On

↓

Read Retentive Data

↓

Read Parameters

↓

Hardware Check

↓

Communication Check

↓

Initialize FBs

↓

READY

--------------------------------------------------
7. Shutdown Sequence
--------------------------------------------------

Save Runtime

↓

Save Counters

↓

Save Queue

↓

Save Statistics

--------------------------------------------------

End Of Document