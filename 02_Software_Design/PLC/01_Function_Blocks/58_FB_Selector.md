--------------------------------------------------
001. Document Header
--------------------------------------------------

Document Name

FB_Selector

Document ID

AQ-FB-058

Version

2.0

Status

Software Design

Runtime

AquaCore

--------------------------------------------------
Related Documents
--------------------------------------------------

14_Line_Manager_Specification

15_State_Machine_Specification

24_Feeding_Algorithm

57_FB_LineManager

78_Interlock_Manager

97_Selector_Calibration_Table

--------------------------------------------------
1. Purpose
--------------------------------------------------

FB_Selector is responsible for positioning the feed selector to the requested outlet.

The Function Block performs only selector control.

Mission management belongs to FB_LineManager.

--------------------------------------------------
2. Responsibilities
--------------------------------------------------

Move selector.

Determine movement direction.

Read analog position.

Determine current eye.

Verify target position.

Execute calibration.

Detect timeout.

Generate diagnostics.

Generate alarms.

Provide engineering information.

--------------------------------------------------
3. Scope
--------------------------------------------------

The Function Block shall support

Current System

12 Eyes

Future

16 Eyes

24 Eyes

32 Eyes

without software redesign.

--------------------------------------------------
4. Hardware Description
--------------------------------------------------

Selector Motor

AC Gear Motor

----------------------------

Position Feedback

Analog Sensor

----------------------------

Safety Sensors

Left Limit

Right Limit

----------------------------

Communication

Hardwired IO

Future

Modbus Encoder

--------------------------------------------------
5. Operating Modes
--------------------------------------------------

Automatic

Mission Control

----------------------------

Manual

Operator Control

----------------------------

Service

Engineering Control

----------------------------

Calibration

Position Learning

--------------------------------------------------
6. Inputs
--------------------------------------------------

Enable

AutoMode

ManualMode

ServiceMode

CalibrationMode

TargetEye

CurrentAnalog

LeftLimit

RightLimit

EmergencyStop

CommunicationHealthy

--------------------------------------------------
7. Outputs
--------------------------------------------------

MotorLeft

MotorRight

Ready

Busy

Alarm

CurrentEye

CurrentState

HealthScore

--------------------------------------------------
8. Internal Variables
--------------------------------------------------

TargetAnalog

CurrentAnalogFiltered

CurrentDifference

Direction

MoveCounter

TimeoutCounter

CalibrationCounter

LastMovementTime

CurrentEyeCalculated

--------------------------------------------------
9. Engineering Parameters
--------------------------------------------------

PositionTolerance

SettleTime

MoveTimeout

DebounceTime

CalibrationTolerance

MaximumTravelTime

MinimumMovement

--------------------------------------------------
10. Selector States
--------------------------------------------------

OFF

INITIALIZE

READY

CALCULATE

MOVE_LEFT

MOVE_RIGHT

VERIFY

SETTLE

COMPLETE

MANUAL

SERVICE

CALIBRATION

TIMEOUT

ALARM

--------------------------------------------------
11. Execution Philosophy
--------------------------------------------------

The selector never knows

Mission

Fish

Feed

Cage

Lot

It only knows

Target Position

Current Position

Move

Stop

Ready

Alarm

--------------------------------------------------
12. Design Rules
--------------------------------------------------

Only one movement allowed.

Motor directions mutually exclusive.

Position verified before Ready.

Every movement logged.

Every timeout logged.

Every calibration logged.

--------------------------------------------------

--------------------------------------------------
13. Startup Sequence
--------------------------------------------------

Enable

↓

Load Parameters

↓

Load Calibration

↓

Read Analog

↓

Determine Current Eye

↓

READY

--------------------------------------------------
14. Shutdown Sequence
--------------------------------------------------

Stop Motor

↓

Reset Outputs

↓

Store Statistics

↓

Store Runtime

↓

OFF

--------------------------------------------------
15. Automatic Movement
--------------------------------------------------

Receive Target Eye

↓

Read Calibration Table

↓

Determine Target Analog

↓

Determine Direction

↓

Move

↓

Verify Position

↓

Ready

--------------------------------------------------
16. Direction Decision
--------------------------------------------------

Current

<

Target

↓

MOVE_RIGHT

----------------------------

Current

>

Target

↓

MOVE_LEFT

--------------------------------------------------

Equal

↓

READY

--------------------------------------------------
17. Position Verification
--------------------------------------------------

Compare

Current Analog

↓

Target Analog

↓

Difference

↓

Tolerance

--------------------------------------------------

Difference

<=

Tolerance

↓

SETTLE

--------------------------------------------------
18. Settle Verification
--------------------------------------------------

Motor OFF

↓

Start Settle Timer

↓

Verify Stable Analog

↓

READY

--------------------------------------------------
19. Movement Timeout
--------------------------------------------------

Movement Started

↓

Start Timeout Timer

↓

Position Not Reached

↓

TIMEOUT

--------------------------------------------------
20. Timeout Recovery
--------------------------------------------------

Stop Motor

↓

Generate Alarm

↓

Store Snapshot

↓

Wait Reset

--------------------------------------------------

--------------------------------------------------
21. Calibration Philosophy
--------------------------------------------------

Calibration belongs to engineering.

Operator cannot modify calibration.

--------------------------------------------------
22. Calibration Procedure
--------------------------------------------------

Engineering Mode

↓

Select Eye

↓

Jog Selector

↓

Align Center

↓

Read Analog

↓

Store Value

↓

Verify

↓

Next Eye

--------------------------------------------------
23. Calibration Validation
--------------------------------------------------

Verify

Ascending Positions

Minimum Distance

Maximum Distance

Tolerance

--------------------------------------------------

Invalid calibration rejected.

--------------------------------------------------
24. Calibration Storage
--------------------------------------------------

Store

Eye Number

Analog Position

Engineer

Date

Version

--------------------------------------------------

Retentive Memory

--------------------------------------------------
25. Calibration Backup
--------------------------------------------------

Export

Import

Restore

Verify

--------------------------------------------------

Checksum required.

--------------------------------------------------

--------------------------------------------------
26. Health Monitoring
--------------------------------------------------

Health Score calculated from

Movement Time

Timeout Count

Calibration Age

Motor Runtime

Alarm Count

--------------------------------------------------
27. Movement Statistics
--------------------------------------------------

Store

Total Moves

Left Moves

Right Moves

Average Move Time

Longest Move

Shortest Move

--------------------------------------------------
28. Runtime Monitoring
--------------------------------------------------

Current Eye

Target Eye

Current Analog

Target Analog

Difference

Current State

--------------------------------------------------
29. Diagnostic Variables
--------------------------------------------------

Direction

Move Timer

Settle Timer

Timeout Timer

Current Difference

Tolerance

Motor Command

--------------------------------------------------
30. Service Information
--------------------------------------------------

Display

Current Calibration

Current Position

Last Movement

Last Timeout

Health Score

Move Counter

--------------------------------------------------

--------------------------------------------------
31. State Machine Overview
--------------------------------------------------

The Selector Function Block shall operate
using a deterministic finite state machine.

Only one state may be active
during one PLC scan.

--------------------------------------------------
32. STATE_OFF
--------------------------------------------------

Purpose

Selector disabled.

Entry

Enable = FALSE

Actions

Motor OFF

Reset Outputs

Busy = FALSE

Ready = FALSE

Exit

Enable = TRUE

--------------------------------------------------
33. STATE_INITIALIZE
--------------------------------------------------

Purpose

Initialize selector.

Actions

Load Parameters

Load Calibration

Reset Timers

Reset Commands

Read Analog Position

Determine Current Eye

Exit

Initialization Complete

↓

READY

--------------------------------------------------
34. STATE_READY
--------------------------------------------------

Purpose

Wait for movement command.

Actions

Monitor Inputs

Monitor Analog

Monitor Health

Monitor Commands

Exit

Move Command Received

↓

CALCULATE

--------------------------------------------------
35. STATE_CALCULATE
--------------------------------------------------

Purpose

Calculate movement.

Actions

Read Target Eye

Read Calibration Table

Calculate Target Analog

Calculate Difference

Determine Direction

Exit

MOVE_LEFT

or

MOVE_RIGHT

--------------------------------------------------
36. STATE_MOVE_LEFT
--------------------------------------------------

Entry

Motor Left ON

Motor Right OFF

Start Move Timer

Actions

Read Analog

Update Difference

Monitor Timeout

Monitor Left Limit

Exit

Target Reached

↓

VERIFY

--------------------------------------------------
37. STATE_MOVE_RIGHT
--------------------------------------------------

Entry

Motor Right ON

Motor Left OFF

Start Move Timer

Actions

Read Analog

Update Difference

Monitor Timeout

Monitor Right Limit

Exit

Target Reached

↓

VERIFY

--------------------------------------------------
38. STATE_VERIFY
--------------------------------------------------

Purpose

Verify final position.

Checks

Difference

Tolerance

Stable Analog

No Timeout

No Alarm

Exit

SETTLE

--------------------------------------------------
39. STATE_SETTLE
--------------------------------------------------

Purpose

Allow mechanics to stabilize.

Actions

Motor OFF

Start Settle Timer

Read Analog

Verify Stable Reading

Exit

Timer Complete

↓

COMPLETE

--------------------------------------------------
40. STATE_COMPLETE
--------------------------------------------------

Actions

Ready = TRUE

Busy = FALSE

Store Statistics

Store Runtime

Log Movement

Exit

READY

--------------------------------------------------
41. STATE_MANUAL
--------------------------------------------------

Purpose

Operator controls movement.

Allowed

Left

Right

Stop

No automatic positioning.

--------------------------------------------------
42. STATE_SERVICE
--------------------------------------------------

Purpose

Engineering diagnostics.

Allowed

Jog

Calibration

Analog Override

IO Test

Sensor Test

--------------------------------------------------
43. STATE_CALIBRATION
--------------------------------------------------

Purpose

Learn analog positions.

Actions

Manual Position

Store Analog

Verify Order

Verify Distance

Save Calibration

--------------------------------------------------
44. STATE_TIMEOUT
--------------------------------------------------

Purpose

Movement exceeded timeout.

Actions

Motor OFF

Busy = FALSE

Ready = FALSE

Generate Alarm

Store Snapshot

--------------------------------------------------
45. STATE_ALARM
--------------------------------------------------

Purpose

Protect hardware.

Actions

Motor OFF

Store Alarm

Store Diagnostics

Wait Reset

--------------------------------------------------
46. Transition Matrix
--------------------------------------------------

READY

↓

CALCULATE

Move Command

----------------------------

CALCULATE

↓

MOVE_LEFT

Current > Target

----------------------------

CALCULATE

↓

MOVE_RIGHT

Current < Target

----------------------------

MOVE

↓

VERIFY

Target Reached

----------------------------

VERIFY

↓

SETTLE

Tolerance OK

----------------------------

SETTLE

↓

COMPLETE

Timer Finished

----------------------------

COMPLETE

↓

READY

Movement Logged

--------------------------------------------------
47. Illegal Transitions
--------------------------------------------------

READY

↓

VERIFY

Not Allowed

----------------------------

OFF

↓

MOVE_LEFT

Not Allowed

----------------------------

TIMEOUT

↓

COMPLETE

Not Allowed

----------------------------

ALARM

↓

MOVE

Not Allowed

--------------------------------------------------
48. Movement Rules
--------------------------------------------------

Motor Left

and

Motor Right

shall never be TRUE simultaneously.

--------------------------------------------------

Direction change

requires complete stop.

--------------------------------------------------
49. Scan Behaviour
--------------------------------------------------

One state evaluation

per PLC scan.

One transition

maximum

per PLC scan.

--------------------------------------------------
50. Engineering Constraints
--------------------------------------------------

No direct calibration changes

during automatic mode.

No movement

during Emergency Stop.

No movement

during Critical Alarm.

--------------------------------------------------
51. Analog Filtering
--------------------------------------------------

Current Analog

↓

Moving Average Filter

↓

Filtered Analog

↓

Position Calculation

--------------------------------------------------

Filter coefficient configurable.

--------------------------------------------------
52. Position Tolerance
--------------------------------------------------

Tolerance

Default

±10 Counts

Minimum

±2 Counts

Maximum

Configurable

--------------------------------------------------
53. Position Stability
--------------------------------------------------

Stable Position

requires

Analog variation

within tolerance

during complete

Settle Time.

--------------------------------------------------
54. Eye Detection
--------------------------------------------------

Current Eye determined

from nearest

calibrated analog value.

--------------------------------------------------

Unknown position

↓

Eye = Undefined

--------------------------------------------------
55. Position Loss
--------------------------------------------------

If analog value

does not match

any calibrated eye

↓

Generate Warning

↓

Continue Monitoring

--------------------------------------------------

If deviation increases

↓

Alarm

--------------------------------------------------
56. Limit Switch Behaviour
--------------------------------------------------

Left Limit

↓

Movement Left Prohibited

--------------------------------------------------

Right Limit

↓

Movement Right Prohibited

--------------------------------------------------

Unexpected activation

↓

Alarm

--------------------------------------------------
57. Direction Verification
--------------------------------------------------

Expected Direction

↓

Compare Analog Trend

--------------------------------------------------

Wrong Direction

↓

Immediate Stop

↓

Alarm

--------------------------------------------------
58. Motion Completion
--------------------------------------------------

Movement completed only if

Target Reached

Tolerance OK

Settle OK

Motor OFF

--------------------------------------------------
59. Runtime Snapshot
--------------------------------------------------

Store

Current Eye

Target Eye

Analog

Difference

Direction

Current State

Move Timer

Health Score

--------------------------------------------------
60. End Of State Machine Section
--------------------------------------------------

The selector state machine
shall remain deterministic,
fully testable,
and independent
from mission logic.

--------------------------------------------------

--------------------------------------------------
61. Movement Algorithm
--------------------------------------------------

Purpose

Move selector from the current eye
to the requested eye
using the shortest deterministic sequence.

--------------------------------------------------
62. Movement Request
--------------------------------------------------

Receive

Target Eye

↓

Validate Eye Number

↓

Read Calibration

↓

Calculate Target Position

↓

Start Movement

--------------------------------------------------

Invalid Eye

↓

Reject Command

--------------------------------------------------
63. Eye Validation
--------------------------------------------------

Verify

Eye Exists

Eye Enabled

Calibration Exists

--------------------------------------------------

Failure

↓

Alarm

↓

Reject Movement

--------------------------------------------------
64. Analog Position Calculation
--------------------------------------------------

Read

Filtered Analog Position

↓

Calculate Difference

↓

Determine Movement Direction

↓

Monitor Continuously

--------------------------------------------------

Calculation executed

every PLC scan.

--------------------------------------------------
65. Position Error
--------------------------------------------------

Position Error

=

Target Analog

-

Current Analog

--------------------------------------------------

Absolute Error

used for tolerance check.

--------------------------------------------------
66. Direction Logic
--------------------------------------------------

Error > 0

↓

Move Right

----------------------------

Error < 0

↓

Move Left

----------------------------

Error = 0

↓

Verify Position

--------------------------------------------------
67. Motion Supervision
--------------------------------------------------

Continuously monitor

Current Position

Target Position

Direction

Timeout

Limit Sensors

Motor Status

--------------------------------------------------
68. Analog Trend Verification
--------------------------------------------------

While Moving Left

Analog value

shall continuously decrease.

--------------------------------------------------

While Moving Right

Analog value

shall continuously increase.

--------------------------------------------------

Unexpected trend

↓

Alarm

--------------------------------------------------
69. Dead Zone Detection
--------------------------------------------------

If analog value

does not change

for configurable time

while motor is running

↓

Movement Failure

↓

Alarm

--------------------------------------------------
70. Overshoot Detection
--------------------------------------------------

Target Position Passed

↓

Stop Motor

↓

Reverse prohibited

↓

Generate Warning

↓

Require New Command

--------------------------------------------------
71. Mechanical Oscillation
--------------------------------------------------

Oscillation detected

↓

Start Settle Timer

↓

Continue Monitoring

--------------------------------------------------

Repeated oscillation

↓

Maintenance Warning

--------------------------------------------------
72. Analog Noise Detection
--------------------------------------------------

Monitor

Analog Stability

--------------------------------------------------

Noise above threshold

↓

Ignore Position Update

↓

Generate Diagnostic Warning

--------------------------------------------------
73. Position Acceptance
--------------------------------------------------

Movement accepted only if

Difference

≤ Tolerance

AND

Stable Analog

AND

No Alarm

--------------------------------------------------
74. Position Repeatability
--------------------------------------------------

After every movement

store

Final Analog Position

--------------------------------------------------

Compare

Current Position

Previous Position

--------------------------------------------------

Large deviation

↓

Maintenance Warning

--------------------------------------------------
75. Mechanical Wear Detection
--------------------------------------------------

Average movement time

shall be monitored.

--------------------------------------------------

Increasing movement time

↓

Health Score Reduction

↓

Maintenance Recommendation

--------------------------------------------------
76. Belt Stretch Detection
--------------------------------------------------

Monitor

Average Travel Time

--------------------------------------------------

Travel time increasing

continuously

↓

Possible Belt Stretch

↓

Maintenance Required

--------------------------------------------------

Reference

Mechanical inspection required.

--------------------------------------------------
77. Gearbox Health
--------------------------------------------------

Monitor

Movement Time

Motor Runtime

Movement Count

--------------------------------------------------

Abnormal behaviour

↓

Maintenance Warning

--------------------------------------------------
78. Bearing Health Indicator
--------------------------------------------------

Indirect Monitoring

Repeated Timeout

Movement Delay

Current Increase (Future)

--------------------------------------------------

Health Score reduced.

--------------------------------------------------
79. Motor Health Indicator
--------------------------------------------------

Monitor

Running Time

Movement Count

Direction Changes

Timeout Count

--------------------------------------------------

Statistics retained permanently.

--------------------------------------------------
80. Sensor Health
--------------------------------------------------

Monitor

Analog Sensor

Left Limit

Right Limit

--------------------------------------------------

Unexpected combinations

↓

Diagnostic Alarm

--------------------------------------------------
81. Calibration Drift
--------------------------------------------------

Compare

Current Stop Position

↓

Historical Stop Position

--------------------------------------------------

Deviation above threshold

↓

Calibration Warning

--------------------------------------------------
82. Recalibration Recommendation
--------------------------------------------------

Generate recommendation when

Calibration Age

>

Configured Interval

OR

Position Repeatability

below limit

--------------------------------------------------
83. Service Statistics
--------------------------------------------------

Store

Calibration Count

Service Count

Timeout Count

Alarm Count

Manual Moves

Automatic Moves

--------------------------------------------------
84. Lifetime Statistics
--------------------------------------------------

Store

Total Distance

Estimated Travel

Move Count

Motor Runtime

Successful Moves

Failed Moves

--------------------------------------------------

Values stored

Retentively.

--------------------------------------------------
85. Maintenance Prediction
--------------------------------------------------

Health Score

↓

Trend Analysis

↓

Remaining Service Estimate

--------------------------------------------------

Displayed

to engineering.

--------------------------------------------------
86. Position History
--------------------------------------------------

Store last

1000

movements.

Each record

Timestamp

Source

Target Eye

Current Eye

Travel Time

Result

--------------------------------------------------
87. Event History
--------------------------------------------------

Movement Started

Movement Completed

Movement Timeout

Calibration

Manual Move

Service Move

Alarm

Reset

--------------------------------------------------

All events timestamped.

--------------------------------------------------
88. Selector Health Score
--------------------------------------------------

Movement Accuracy

25%

Movement Time

20%

Timeout Count

20%

Calibration Quality

20%

Sensor Health

15%

--------------------------------------------------

Overall

0...100%

--------------------------------------------------
89. Engineering Recommendations
--------------------------------------------------

Low Health Score

↓

Display

Recommended Action

Examples

Check Belt

Inspect Gearbox

Replace Sensor

Recalibrate

--------------------------------------------------
90. End Of Motion Supervision
--------------------------------------------------

The selector shall continuously
evaluate its own condition
and provide engineering information
before failures occur.

--------------------------------------------------

--------------------------------------------------
91. Command Source Management
--------------------------------------------------

Every movement command shall have
exactly one owner.

Possible Sources

FB_LineManager

Operator

Service Mode

Recovery Manager

Calibration Wizard

--------------------------------------------------

Priority

Emergency Stop

↓

Service

↓

Recovery

↓

LineManager

↓

Operator

--------------------------------------------------

Lower priority commands
shall be rejected.

--------------------------------------------------
92. Command Validation
--------------------------------------------------

Before movement begins

Verify

Enable

Ready

No Alarm

Communication Healthy

Calibration Valid

Target Eye Valid

--------------------------------------------------

Failure

↓

Reject Command

↓

Generate Event

--------------------------------------------------
93. Busy Behaviour
--------------------------------------------------

While Busy

Reject

New Move Commands

Calibration

Manual Commands

--------------------------------------------------

Allowed

Emergency Stop

Critical Alarm

--------------------------------------------------
94. Command Queue
--------------------------------------------------

Maximum Pending Commands

1

--------------------------------------------------

New command received
while Busy

↓

Reject

--------------------------------------------------

Queueing handled by

FB_LineManager

--------------------------------------------------
95. Emergency Stop Behaviour
--------------------------------------------------

Emergency Stop Active

↓

Motor OFF

↓

Busy FALSE

↓

Ready FALSE

↓

Alarm TRUE

↓

Store Snapshot

↓

Wait Reset

--------------------------------------------------
96. Emergency Recovery
--------------------------------------------------

After Reset

↓

Read Analog Position

↓

Determine Current Eye

↓

Verify Calibration

↓

READY

--------------------------------------------------

No automatic movement allowed.

--------------------------------------------------
97. Analog Failure Detection
--------------------------------------------------

Detect

Open Circuit

Short Circuit

Out Of Range

Frozen Value

--------------------------------------------------

Failure

↓

Alarm

↓

Motor OFF

--------------------------------------------------
98. Frozen Analog Detection
--------------------------------------------------

Motor Running

AND

Analog unchanged

for configurable time

↓

Sensor Failure

↓

Alarm

--------------------------------------------------
99. Analog Range Verification
--------------------------------------------------

Minimum Analog

Configurable

Maximum Analog

Configurable

--------------------------------------------------

Outside Range

↓

Alarm

--------------------------------------------------
100. Calibration Integrity
--------------------------------------------------

Verify

Eye Order

Unique Positions

Minimum Distance

Maximum Distance

Checksum

Version

--------------------------------------------------

Failure

↓

Calibration Invalid

--------------------------------------------------
101. Eye Mapping
--------------------------------------------------

Each Eye contains

Eye Number

Analog Position

Enabled

Reserved

Description

--------------------------------------------------

Descriptions editable
from engineering software.

--------------------------------------------------
102. Eye Enable System
--------------------------------------------------

Each Eye

Enabled

or

Disabled

--------------------------------------------------

Disabled Eyes

cannot receive
movement commands.

--------------------------------------------------
103. Reserved Eyes
--------------------------------------------------

Future selector models

may contain

unused eyes.

--------------------------------------------------

Reserved eyes

shall remain hidden
from operators.

--------------------------------------------------
104. Calibration Version
--------------------------------------------------

Every calibration set

contains

Major Version

Minor Version

Date

Engineer

Checksum

--------------------------------------------------

Older versions archived.

--------------------------------------------------
105. Calibration Restore
--------------------------------------------------

Restore

Previous Version

↓

Validate

↓

Activate

--------------------------------------------------

Invalid restore rejected.

--------------------------------------------------
106. Calibration Comparison
--------------------------------------------------

Compare

Current

↓

Previous

↓

Factory Default

--------------------------------------------------

Generate

Difference Report

--------------------------------------------------
107. Position Repeatability Test
--------------------------------------------------

Move

Eye 1

↓

Eye 6

↓

Eye 1

↓

Eye 6

Repeat

10 Times

--------------------------------------------------

Store

Average Error

Maximum Error

Minimum Error

--------------------------------------------------
108. Automatic Verification
--------------------------------------------------

After every calibration

Run

Automatic Verification

--------------------------------------------------

Every Eye

verified automatically.

--------------------------------------------------
109. Calibration Certificate
--------------------------------------------------

Generate

Engineer

Date

Machine

Calibration Values

Verification Result

Software Version

--------------------------------------------------

Certificate export supported.

--------------------------------------------------
110. Calibration Lock
--------------------------------------------------

Calibration data

cannot be edited

during

Automatic Mode

Mission Running

Recovery Mode

--------------------------------------------------

Engineering authentication required.

--------------------------------------------------
111. Motion Counter
--------------------------------------------------

Increment

every completed movement.

--------------------------------------------------

Retentive Counter.

--------------------------------------------------
112. Direction Counter
--------------------------------------------------

Store

Left Moves

Right Moves

Manual Moves

Automatic Moves

Service Moves

--------------------------------------------------

Permanent statistics.

--------------------------------------------------
113. Runtime Counter
--------------------------------------------------

Motor Runtime

Total Runtime

Idle Time

Service Time

--------------------------------------------------

Retentive.

--------------------------------------------------
114. Travel Distance Estimation
--------------------------------------------------

Estimate

Total Travel Distance

using

Eye Positions

Movement History

--------------------------------------------------

Used for maintenance.

--------------------------------------------------
115. Position Accuracy Trend
--------------------------------------------------

Monitor

Average Position Error

Weekly

Monthly

Lifetime

--------------------------------------------------

Trend displayed
to engineering.

--------------------------------------------------
116. Alarm Frequency
--------------------------------------------------

Monitor

Timeout Rate

Sensor Errors

Calibration Errors

Direction Errors

--------------------------------------------------

Displayed

per 1000 moves.

--------------------------------------------------
117. Mean Time Between Failures
--------------------------------------------------

Calculate

MTBF

using

Movement Count

Alarm Count

--------------------------------------------------

Displayed
to engineering.

--------------------------------------------------
118. Mean Time To Repair
--------------------------------------------------

Store

Alarm Time

Repair Time

Service Finish

--------------------------------------------------

Calculate

MTTR

--------------------------------------------------
119. Engineering Dashboard
--------------------------------------------------

Display

Health Score

Movement Count

Calibration Age

Timeout Trend

Alarm Trend

MTBF

MTTR

--------------------------------------------------

Real-time update.

--------------------------------------------------
120. End Of Reliability Section
--------------------------------------------------

FB_Selector shall continuously
monitor its operational quality,
predict future failures,
and simplify engineering maintenance.

--------------------------------------------------

--------------------------------------------------
121. Service Mode Philosophy
--------------------------------------------------

Purpose

Provide unrestricted engineering access
for diagnostics, commissioning,
maintenance and troubleshooting.

Service Mode shall never be available
to normal operators.

--------------------------------------------------
122. Service Authorization
--------------------------------------------------

Access Levels

Level 1

Operator

No Access

----------------------------

Level 2

Supervisor

Read Only

----------------------------

Level 3

Service

Limited Write

----------------------------

Level 4

Engineering

Full Access

--------------------------------------------------

Every login shall be recorded.

--------------------------------------------------
123. Service Login
--------------------------------------------------

Required

Username

Password

Access Level

Timestamp

--------------------------------------------------

Optional

Two Factor Authentication

(Future)

--------------------------------------------------
124. IO Test Mode
--------------------------------------------------

Available Outputs

Motor Left

Motor Right

Indicator Lamps

Future Outputs

--------------------------------------------------

Available Inputs

Left Limit

Right Limit

Analog Position

Emergency Stop

--------------------------------------------------

Every IO change logged.

--------------------------------------------------
125. Jog Mode
--------------------------------------------------

Engineering may command

Move Left

Move Right

Stop

--------------------------------------------------

Jog Speed

Configurable

--------------------------------------------------

Jog Timer

Mandatory

--------------------------------------------------
126. Continuous Move
--------------------------------------------------

Allowed only in

Engineering Mode.

--------------------------------------------------

Movement interrupted by

Emergency Stop

Limit Switch

Critical Alarm

--------------------------------------------------
127. Analog Live Monitor
--------------------------------------------------

Display

Raw Analog

Filtered Analog

Current Eye

Target Eye

Difference

Noise Level

--------------------------------------------------

Refresh

Every PLC Scan

--------------------------------------------------
128. Analog Trend Graph
--------------------------------------------------

Store

Last

30 Seconds

of analog data.

--------------------------------------------------

Graph available

inside engineering software.

--------------------------------------------------
129. Calibration Assistant
--------------------------------------------------

Step 1

Select Eye

↓

Step 2

Move Selector

↓

Step 3

Fine Position

↓

Step 4

Store Analog

↓

Step 5

Verification

--------------------------------------------------

Wizard driven.

--------------------------------------------------
130. Eye Verification
--------------------------------------------------

After saving

Eye Position

↓

Move Away

↓

Return

↓

Verify

Repeatability

--------------------------------------------------

Failure

↓

Calibration Rejected

--------------------------------------------------
131. Calibration Difference Report
--------------------------------------------------

Compare

Factory

↓

Previous

↓

Current

--------------------------------------------------

Display

Difference

Percentage

Engineering Notes

--------------------------------------------------
132. Sensor Diagnostics
--------------------------------------------------

Monitor

Sensor Voltage

Noise

Signal Stability

Signal Loss

Update Rate

--------------------------------------------------

Generate

Sensor Health

--------------------------------------------------
133. Motor Diagnostics
--------------------------------------------------

Monitor

Movement Count

Movement Time

Timeouts

Direction Changes

Estimated Runtime

--------------------------------------------------

Displayed

to engineering.

--------------------------------------------------
134. Limit Switch Diagnostics
--------------------------------------------------

Display

Current State

Activation Count

Unexpected Activations

Last Activation Time

--------------------------------------------------

Stored permanently.

--------------------------------------------------
135. Calibration Simulation
--------------------------------------------------

Engineering may simulate

Eye Positions

without moving hardware.

--------------------------------------------------

Simulation Mode

clearly indicated.

--------------------------------------------------
136. Simulation Lock
--------------------------------------------------

Simulation prohibited

during

Automatic Mode

Mission Running

--------------------------------------------------

Engineering Mode only.

--------------------------------------------------
137. Movement Replay
--------------------------------------------------

Replay

Last

100

Movements

--------------------------------------------------

Display

Timestamp

Target Eye

Travel Time

Final Position

Result

--------------------------------------------------
138. Timeout Diagnostics
--------------------------------------------------

Display

Movement Distance

Movement Time

Timeout Limit

Remaining Time

--------------------------------------------------

Useful during commissioning.

--------------------------------------------------
139. Service Snapshot
--------------------------------------------------

Store

Current State

Current Eye

Target Eye

Analog

Motor Command

Timer Values

Health Score

--------------------------------------------------

Snapshot export supported.

--------------------------------------------------
140. End Of Service Section
--------------------------------------------------

Service Mode shall provide
complete engineering visibility
without compromising
production safety.

--------------------------------------------------

--------------------------------------------------
141. Alarm Management
--------------------------------------------------

Purpose

Detect

Classify

Record

Present

Recover

all selector alarms.

--------------------------------------------------
142. Alarm Categories
--------------------------------------------------

Information

Warning

Alarm

Critical

--------------------------------------------------

Severity configurable.

--------------------------------------------------
143. Alarm Structure
--------------------------------------------------

Every Alarm contains

Alarm ID

Severity

Timestamp

Current State

Current Eye

Target Eye

Operator

Mission ID

Description

Recovery Suggestion

--------------------------------------------------
144. SEL001
--------------------------------------------------

Movement Timeout

--------------------------------------------------

Cause

Target not reached.

--------------------------------------------------

Action

Motor Stop

Alarm

Snapshot

--------------------------------------------------
145. SEL002
--------------------------------------------------

Analog Sensor Failure

--------------------------------------------------

Cause

Invalid analog value.

--------------------------------------------------

Recovery

Sensor inspection.

--------------------------------------------------
146. SEL003
--------------------------------------------------

Calibration Missing

--------------------------------------------------

Cause

No calibration table.

--------------------------------------------------

Recovery

Engineering calibration.

--------------------------------------------------
147. SEL004
--------------------------------------------------

Calibration Invalid

--------------------------------------------------

Cause

Checksum failed.

--------------------------------------------------

Recovery

Restore backup.

--------------------------------------------------
148. SEL005
--------------------------------------------------

Unexpected Direction

--------------------------------------------------

Cause

Analog trend incorrect.

--------------------------------------------------

Recovery

Mechanical inspection.

--------------------------------------------------
149. SEL006
--------------------------------------------------

Unexpected Limit Switch

--------------------------------------------------

Cause

Invalid limit activation.

--------------------------------------------------

Recovery

Inspect selector.

--------------------------------------------------
150. Alarm Reset
--------------------------------------------------

Reset allowed only if

Alarm Cause Removed

↓

Engineering Verification

↓

Operator Reset

--------------------------------------------------

Automatic reset prohibited.

--------------------------------------------------

--------------------------------------------------
151. Alarm Acknowledgement
--------------------------------------------------

Purpose

Allow the operator to acknowledge
an alarm without clearing it.

--------------------------------------------------

Alarm Active

↓

Operator Acknowledge

↓

Alarm remains active

↓

Cause removed

↓

Reset Allowed

--------------------------------------------------

Acknowledgement shall be logged.

--------------------------------------------------
152. Alarm History
--------------------------------------------------

Store

Alarm ID

Timestamp

Current State

Current Eye

Target Eye

Mission ID

Operator

Recovery Action

Duration

--------------------------------------------------

Minimum History

10,000 Records

--------------------------------------------------
153. Alarm Statistics
--------------------------------------------------

Store

Timeout Count

Sensor Failures

Calibration Errors

Limit Errors

Direction Errors

Emergency Stops

--------------------------------------------------

Statistics retained permanently.

--------------------------------------------------
154. Alarm Escalation
--------------------------------------------------

Repeated Alarm

↓

Increase Severity

↓

Maintenance Warning

↓

Engineering Notification

--------------------------------------------------

Escalation limits configurable.

--------------------------------------------------
155. Alarm Suppression
--------------------------------------------------

Only Engineering Mode

may temporarily suppress

selected

Warning

or

Information

events.

--------------------------------------------------

Critical alarms

cannot be suppressed.

--------------------------------------------------
156. Alarm Correlation
--------------------------------------------------

Related alarms shall be grouped.

Example

Analog Failure

↓

Position Failure

↓

Timeout

--------------------------------------------------

Display Root Cause.

--------------------------------------------------
157. Diagnostic Recommendations
--------------------------------------------------

Each alarm shall provide

Possible Cause

Inspection Steps

Recommended Action

Estimated Repair Time

--------------------------------------------------

Displayed on engineering screen.

--------------------------------------------------
158. Alarm Snapshot
--------------------------------------------------

Snapshot contains

Current State

Current Eye

Target Eye

Analog Value

Filtered Analog

Motor Command

Timers

Health Score

Alarm Code

--------------------------------------------------

Snapshot retained permanently.

--------------------------------------------------
159. Alarm Export
--------------------------------------------------

Export

CSV

PDF

JSON

--------------------------------------------------

Export shall include

Alarm History

Statistics

Snapshots

--------------------------------------------------
160. End Of Alarm Management
--------------------------------------------------

Alarm system shall support

Diagnosis

Maintenance

Continuous Improvement

--------------------------------------------------

End Of Section