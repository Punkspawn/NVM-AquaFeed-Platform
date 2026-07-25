# 70_FB_Selector_Pseudocode.md

# NVM AquaFeed Platform

## Pseudocode

Document ID : AQ-FB-070

--------------------------------------------------

IF Enable = FALSE

↓

OFF

--------------------------------------------------

IF MoveCommand

↓

Calculate Target

↓

Calculate Direction

--------------------------------------------------

IF Current < Target

↓

MOVE_RIGHT

--------------------------------------------------

IF Current > Target

↓

MOVE_LEFT

--------------------------------------------------

IF Difference <= Tolerance

↓

STOP MOTOR

↓

SETTLE

--------------------------------------------------

IF Settle Finished

↓

READY

--------------------------------------------------

IF Timeout

↓

ALARM

--------------------------------------------------

End Of Document