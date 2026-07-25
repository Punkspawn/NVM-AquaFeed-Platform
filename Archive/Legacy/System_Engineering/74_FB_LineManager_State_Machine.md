# Legacy LineManager State Machine Summary

> **Status:** Legacy / Superseded  
> **Former path:** `01_System_Engineering/74_FB_LineManager_State_Machine.md`  
> **Reason archived:** State summary consolidated into the authoritative PLC LineManager specification.  
> **Replacement:** `02_Software_Design/PLC/01_Function_Blocks/FB_LineManager.md`

---

# 74_FB_LineManager_State_Machine.md

# NVM AquaFeed Platform

## Line Manager State Machine

Document ID : AQ-FB-074

--------------------------------------------------

READY

↓

LOAD_MISSION

↓

VERIFY

↓

MOVE_SELECTOR

↓

WAIT_SELECTOR

↓

START_BLOWER

↓

WAIT_BLOWER

↓

PRE_RUN

↓

START_DOSING

↓

FEEDING

↓

STOP_DOSING

↓

POST_RUN

↓

MISSION_COMPLETE

↓

READY

--------------------------------------------------

Additional

PAUSED

SERVICE

RECOVERY

ALARM

--------------------------------------------------

End Of Document