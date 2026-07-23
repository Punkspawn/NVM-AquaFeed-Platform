# 13_Dosing_Specification.md

# NVM AquaFeed Platform

## Dosing Unit Specification

Document ID : AQ-DOS-013

Version : 1.0

Status : Draft

--------------------------------------------------
1. Purpose
--------------------------------------------------

The dosing unit transfers feed from the selected silo into the pneumatic transport line.

Feed quantity is calculated by counting gearbox revolutions.

No weighing cell is required.

The dosing system shall provide repeatable feed delivery after calibration.

--------------------------------------------------
2. Hardware
--------------------------------------------------

Motor

Three Phase AC Motor

Drive

Delta VFD

Default Power

1.5 kW

Gearbox

Reducer

Revolution Detection

Inductive Sensor

One Pulse

One Gearbox Revolution

Communication

Modbus RTU

--------------------------------------------------
3. Working Principle
--------------------------------------------------

Feed falls into the airlock.

↓

Airlock rotates.

↓

One full revolution moves a fixed feed volume.

↓

Inductive sensor generates one pulse.

↓

PLC calculates delivered feed.

--------------------------------------------------

Delivered Feed

=

Pulse Count

×

Kg Per Revolution

--------------------------------------------------
4. Calibration
--------------------------------------------------

Calibration shall be performed during commissioning.

Procedure

Set KgPerRevolution

↓

Feed known amount

↓

Compare actual weight

↓

Adjust parameter

↓

Repeat until acceptable accuracy

--------------------------------------------------

Calibration is machine specific.

--------------------------------------------------
5. Feed Calculation
--------------------------------------------------

Required Feed

=

Target Kg

Delivered Feed

=

Pulse Count

×

Kg Per Revolution

Remaining Feed

=

Target

-

Delivered

--------------------------------------------------
6. Accuracy
--------------------------------------------------

Exact feed quantity is not expected.

The system shall stop at the first completed revolution exceeding target.

Expected accuracy depends on

Gearbox Ratio

Feed Density

Feed Size

Calibration Quality

--------------------------------------------------
7. Kg Per Revolution
--------------------------------------------------

Parameter

REAL

Example

0.38 kg

Range

0.050

...

5.000 kg

Service Adjustable

YES

--------------------------------------------------
8. Feed Rate
--------------------------------------------------

Feed rate depends on

Motor Frequency

Airlock Volume

Feed Density

Gearbox Ratio

Operator may select

Slow

Medium

Fast

or

Specific kg/min

--------------------------------------------------
9. Automatic Sequence
--------------------------------------------------

Blower Ready

↓

Feed Delay Completed

↓

Start Dosing

↓

Count Pulses

↓

Calculate Feed

↓

Target Reached

↓

Stop Motor

--------------------------------------------------
10. Pulse Detection
--------------------------------------------------

One pulse

=

One complete gearbox revolution.

Pulse shall be debounced.

False pulses shall be ignored.

Missing pulses shall generate alarms.

--------------------------------------------------
11. Pulse Timeout
--------------------------------------------------

If motor is running

AND

No pulse detected

within configurable timeout

↓

Motor Stop

↓

Alarm

--------------------------------------------------
12. Pulse Filter
--------------------------------------------------

Minimum pulse width

Configurable

Maximum pulse frequency

Configurable

Noise rejection enabled

--------------------------------------------------
13. Feed Density
--------------------------------------------------

Each feed type stores

Bulk Density

(Hectoliter Weight)

Example

Feed 2 mm

0.58 kg/L

Feed 4 mm

0.61 kg/L

Feed 6 mm

0.63 kg/L

This value is used for calibration support and future analytics.

--------------------------------------------------
14. Feed Types
--------------------------------------------------

Each silo contains only one feed type.

Feed information

Manufacturer

Product

Diameter

Density

Lot Number

Production Date

Expiration Date

--------------------------------------------------
15. Silo Assignment
--------------------------------------------------

Every dosing unit belongs to one silo.

Mission selects silo automatically.

Manual override allowed in Service Mode.

--------------------------------------------------
16. Manual Mode
--------------------------------------------------

Operator may

Start

Stop

Jog

Adjust Frequency

View Pulse Counter

Manual mode shall ignore Mission Queue.

--------------------------------------------------
17. Service Mode
--------------------------------------------------

Functions

Run Motor

Read Pulse

Reset Counter

Adjust Calibration

Pulse Simulation

Backup Parameters

Restore Parameters

--------------------------------------------------
18. Runtime Statistics
--------------------------------------------------

Store

Runtime Hours

Pulse Count

Delivered Feed

Mission Count

Alarm Count

Start Count

Stop Count

Last Calibration

--------------------------------------------------
19. Alarm List
--------------------------------------------------

DOS001

Pulse Timeout

DOS002

Pulse Sensor Failure

DOS003

Calibration Missing

DOS004

Feed Calculation Error

DOS005

Communication Failure

DOS006

Motor Overload

DOS007

Unexpected Stop

DOS008

Drive Fault

DOS009

Configuration Error

DOS010

Emergency Stop

--------------------------------------------------
20. Maintenance
--------------------------------------------------

Maintenance shall include

Gearbox Inspection

Oil Inspection

Bearing Inspection

Sensor Inspection

Motor Inspection

Coupling Inspection

--------------------------------------------------
21. Maintenance Counters
--------------------------------------------------

Runtime Hours

Pulse Count

Feed Delivered

Start Count

Maintenance Due

Overdue Maintenance

--------------------------------------------------
22. Parameter List
--------------------------------------------------

Kg Per Revolution

Pulse Timeout

Minimum Pulse Width

Maximum Pulse Frequency

Motor Frequency

Acceleration Time

Deceleration Time

Maintenance Interval

--------------------------------------------------
23. Health Monitoring
--------------------------------------------------

Health Score considers

Sensor Reliability

Pulse Stability

Communication Errors

Runtime

Alarm Frequency

Maintenance Status

--------------------------------------------------
24. Future Improvements
--------------------------------------------------

Encoder Feedback

Automatic Calibration

Feed Flow Estimation

Motor Torque Monitoring

AI Calibration Assistant

Predictive Gearbox Maintenance

--------------------------------------------------
25. Acceptance Criteria
--------------------------------------------------

The dosing unit shall

Deliver calculated feed amount.

Stop after reaching target.

Detect missing pulses.

Reject invalid calibration.

Generate alarms within one second.

Continue operation after PLC restart using stored parameters.

--------------------------------------------------

End Of Document