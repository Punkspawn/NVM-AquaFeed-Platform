# NVM AquaFeed Platform

# Selector Specification

Document ID : AQ-SEL-011

Version : 1.0

Status : Draft

--------------------------------------------------

# 1 Purpose

The selector is responsible for directing feed to the correct fish cage.

The selector is a positioning system.

It receives feed from the blower line and directs it to one selected outlet.

Only one outlet can be active at a time.

--------------------------------------------------

# 2 Hardware

Motor

AC Induction Motor

Power

0.18 kW

Gearbox

Reducer

Output Speed

Approximately 16 RPM

Direction

Left

Right

Feedback

Analog Position Sensor

Limit Sensors

Left Limit

Right Limit

Communication

Digital IO

Analog Input

--------------------------------------------------

# 3 Functional Description

The selector has one task.

Move to requested outlet.

After reaching target position

Generate

Ready Signal

The selector never starts the blower.

The selector never starts dosing.

Those decisions belong to Line Manager.

--------------------------------------------------

# 4 Operating Modes

Automatic

Operator selects cage.

System determines target eye.

Selector moves automatically.

--------------------------------------------------

Manual

Operator presses

LEFT

or

RIGHT

button.

Movement continues while button is pressed.

--------------------------------------------------

Service

Engineer can

Move selector

Read analog value

Run calibration

Force outputs

Read diagnostics

Ignore mission system

--------------------------------------------------

# 5 State Machine

OFF

↓

INITIALIZING

↓

READY

↓

MOVE_LEFT

↓

MOVE_RIGHT

↓

POSITION_CHECK

↓

SETTLE_TIME

↓

READY

Additional states

MANUAL

SERVICE

TIMEOUT

ALARM

--------------------------------------------------

# 6 Movement Algorithm

Receive target eye.

↓

Read calibration table.

↓

Find target analog value.

↓

Determine direction.

↓

Start motor.

↓

Read analog position.

↓

Compare with tolerance.

↓

Stop motor.

↓

Wait settle time.

↓

Generate READY.

--------------------------------------------------

# 7 Position Verification

The selector position is determined by analog feedback.

The measured value shall remain inside tolerance during the entire settle time.

Only then

READY = TRUE
--------------------------------------------------
8. Calibration
--------------------------------------------------

The selector requires calibration before first operation.

Calibration shall be performed by a service engineer.

Only Service Mode allows calibration.

Calibration values shall be stored in PLC Retentive Memory.

Calibration shall survive power loss.

--------------------------------------------------

Calibration Procedure

Step 1

Move selector manually to Eye 1.

↓

Press "Save Position".

↓

Current analog value is stored.

↓

Move selector to Eye 2.

↓

Store value.

↓

...

↓

Repeat until all eyes are calibrated.

--------------------------------------------------

Example

Eye 1 = 312

Eye 2 = 648

Eye 3 = 978

Eye 4 = 1321

Eye 5 = 1654

Eye 6 = 1987

Eye 7 = 2318

Eye 8 = 2647

Eye 9 = 2975

Eye10 = 3308

Eye11 = 3640

Eye12 = 3972

--------------------------------------------------

The analog values above are examples only.

Real calibration values are determined on-site.

--------------------------------------------------
9. Position Algorithm
--------------------------------------------------

Every scan

Read Analog Input

↓

Compare with Target Value

↓

Absolute Difference

↓

Difference <= Tolerance ?

YES

↓

Position Reached

↓

Wait Settle Time

↓

READY

NO

↓

Continue Movement

--------------------------------------------------

10. Position Tolerance

Tolerance shall be configurable.

Default

±15 Analog Units

Minimum

±5

Maximum

±100

Tolerance may be adjusted during commissioning.

--------------------------------------------------

11. Settle Time

After reaching target position

Motor shall remain stopped.

System waits configurable settle time.

Purpose

Allow gearbox vibration to stop.

Allow analog signal stabilization.

Default

300 ms

Range

100...2000 ms

--------------------------------------------------

12. Reverse Direction

Some installations may require opposite motor direction.

Parameter

Reverse Direction

OFF

Motor Left = Left

Motor Right = Right

ON

Motor Left = Right

Motor Right = Left

No wiring changes shall be required.

--------------------------------------------------

13. Move Timeout

Movement timer starts immediately after motor start.

If target position is not reached

↓

Timeout Alarm

↓

Motor Stop

↓

READY = FALSE

↓

Alarm Generated

Default

20 seconds

Configurable

5...120 seconds

--------------------------------------------------

14. Analog Signal Validation

The analog signal shall always remain inside valid limits.

If

Analog < AI_Min

OR

Analog > AI_Max

↓

Analog Fault

↓

Movement prohibited

↓

Alarm generated

Default

AI_Min = 100

AI_Max = 4000

--------------------------------------------------

15. Selector Ready Logic

Selector Ready shall become TRUE only when

Motor Stopped

AND

No Alarm

AND

Position Valid

AND

Settle Time Finished

AND

Analog Signal Valid

--------------------------------------------------

16. Selector Busy Logic

Busy becomes TRUE

Immediately after movement starts.

Busy becomes FALSE

Only after READY becomes TRUE.

--------------------------------------------------

17. Alarm List

SEL001

Move Timeout

SEL002

Analog Signal Lost

SEL003

Calibration Missing

SEL004

Position Out Of Range

SEL005

Invalid Eye Number

SEL006

Left Limit Activated

SEL007

Right Limit Activated

SEL008

Movement Aborted

SEL009

Emergency Stop

SEL010

Configuration Error

--------------------------------------------------

18. Statistics

The selector shall store

Total Movements

Total Runtime

Total Alarms

Total Timeouts

Successful Positionings

Average Position Time

Longest Position Time

Last Calibration Date

Last Service Date

--------------------------------------------------

19. Maintenance

Maintenance counters

Movement Counter

Runtime Hours

Maintenance Interval

Lubrication Reminder

Inspection Reminder

Calibration Reminder

--------------------------------------------------

20. Service Functions

Move Left

Move Right

Read Analog

Force Outputs

Read Inputs

Run Calibration

Reset Statistics

Reset Alarms

Backup Parameters

Restore Parameters

--------------------------------------------------

21. Parameter List

Move Timeout

Tolerance

Settle Time

Reverse Direction

AI Minimum

AI Maximum

Eye Count

Calibration Values

--------------------------------------------------

22. Future Improvements

Encoder Feedback

Absolute Encoder

Automatic Calibration

Motor Current Monitoring

Predictive Maintenance

--------------------------------------------------

End Of Document