# 67_FB_Selector_State_Machine.md

# NVM AquaFeed Platform

## FB_Selector State Machine

Document ID : AQ-FB-067

Version : 1.0

--------------------------------------------------
Purpose
--------------------------------------------------

Defines every operating state of the Selector Function Block.

Only one state may be active at any time.

--------------------------------------------------

State 0

OFF

Description

Selector disabled.

Entry

System Stop

Exit

System Enable

--------------------------------------------------

State 10

INITIALIZE

Actions

Read Parameters

Read Calibration

Read Current Analog

Reset Timers

Verify Inputs

--------------------------------------------------

State 20

READY

Waiting for command.

Allowed Commands

Move

Manual

Service

--------------------------------------------------

State 30

CALCULATE

Determine

Target Analog

Direction

Tolerance

--------------------------------------------------

State 40

MOVE_LEFT

Motor Left ON

Motor Right OFF

--------------------------------------------------

State 50

MOVE_RIGHT

Motor Right ON

Motor Left OFF

--------------------------------------------------

State 60

POSITION_VERIFY

Compare

Current Position

Target Position

--------------------------------------------------

State 70

SETTLE

Motor OFF

Wait

Settle Timer

--------------------------------------------------

State 80

COMPLETE

Ready = TRUE

Busy = FALSE

--------------------------------------------------

State 90

TIMEOUT

Motor OFF

Alarm

SEL001

--------------------------------------------------

State 100

MANUAL

Operator controls movement.

--------------------------------------------------

State 110

SERVICE

Engineering mode.

--------------------------------------------------

State 120

ALARM

Machine locked.

--------------------------------------------------

End Of Document