--------------------------------------------------
001. Document Header
--------------------------------------------------

Document Name

FB_Blower

Document ID

AQ-FB-059

Version

2.0

Status

Software Design

Runtime

AquaCore

--------------------------------------------------
Related Documents
--------------------------------------------------

57_FB_LineManager

58_FB_Selector

60_FB_Dosing

78_Interlock_Manager

81_Parameter_Validation

85_Software_Architecture_Rules

--------------------------------------------------
1. Purpose
--------------------------------------------------

FB_Blower is responsible for controlling
the pneumatic feed transport system.

It shall control only the blower.

Mission logic belongs to FB_LineManager.

--------------------------------------------------
2. Responsibilities
--------------------------------------------------

Start Blower

Stop Blower

Frequency Control

Acceleration

Deceleration

Ready Detection

Health Monitoring

Diagnostics

Statistics

Alarm Generation

--------------------------------------------------
3. Scope
--------------------------------------------------

Current Project

One blower per feeding line.

Future

Multiple blowers

Redundant blowers

Shared blower systems

supported without redesign.

--------------------------------------------------
4. Hardware
--------------------------------------------------

Motor

Three Phase AC Motor

----------------------------

Drive

Delta MS300

(Modbus RTU)

----------------------------

Communication

RS485

----------------------------

Feedback

Drive Status

Frequency

Current

Fault

Temperature (Future)

--------------------------------------------------
5. Operating Modes
--------------------------------------------------

Automatic

Mission Controlled

----------------------------

Manual

Operator Controlled

----------------------------

Service

Engineering Controlled

----------------------------

Simulation

Software Only

--------------------------------------------------
6. Inputs
--------------------------------------------------

Enable

Run Command

Stop Command

Target Frequency

Drive Ready

Drive Running

Drive Fault

Actual Frequency

Motor Current

Communication Healthy

Emergency Stop

--------------------------------------------------
7. Outputs
--------------------------------------------------

Drive Run

Frequency Reference

Ready

Busy

Alarm

Current State

Health Score

--------------------------------------------------
8. Internal Variables
--------------------------------------------------

TargetFrequency

ActualFrequency

FrequencyError

AccelerationTimer

DecelerationTimer

RuntimeCounter

StartCounter

FaultCounter

CommunicationCounter

--------------------------------------------------
9. Parameters
--------------------------------------------------

Minimum Frequency

Maximum Frequency

Acceleration Time

Deceleration Time

Ready Tolerance

Frequency Tolerance

Communication Timeout

Maximum Current

--------------------------------------------------
10. States
--------------------------------------------------

OFF

INITIALIZE

READY

START

ACCELERATION

VERIFY

RUNNING

DECELERATION

STOP

MANUAL

SERVICE

SIMULATION

FAULT

--------------------------------------------------
11. Design Philosophy
--------------------------------------------------

The blower is responsible only
for generating stable airflow.

It does not know

Mission

Feed

Fish

Cage

Lot

--------------------------------------------------
12. Engineering Rules
--------------------------------------------------

Only one Run command.

Only one Stop command.

Frequency always validated.

Every fault logged.

Every startup recorded.

Every shutdown recorded.

--------------------------------------------------
13. Startup Sequence
--------------------------------------------------

Enable

↓

Read Parameters

↓

Verify Communication

↓

Verify Drive

↓

Verify Frequency

↓

READY

--------------------------------------------------
14. Shutdown Sequence
--------------------------------------------------

Ramp Down

↓

Stop Drive

↓

Store Statistics

↓

OFF

--------------------------------------------------
15. Start Sequence
--------------------------------------------------

Receive Run

↓

Verify Ready

↓

Enable Drive

↓

Acceleration

↓

Target Frequency

↓

Verify

↓

RUNNING

--------------------------------------------------
16. Stop Sequence
--------------------------------------------------

Receive Stop

↓

Deceleration

↓

Minimum Frequency

↓

Drive Stop

↓

READY

--------------------------------------------------
17. Acceleration
--------------------------------------------------

Increase frequency

according to

configured ramp.

--------------------------------------------------

No frequency jumps allowed.

--------------------------------------------------
18. Deceleration
--------------------------------------------------

Decrease frequency

according to

configured ramp.

--------------------------------------------------

Controlled stop only.

--------------------------------------------------
19. Ready Verification
--------------------------------------------------

Verify

Drive Ready

Running

Frequency Stable

Communication Healthy

No Fault

--------------------------------------------------

Only then

Ready = TRUE

--------------------------------------------------
20. Running Verification
--------------------------------------------------

Continuously monitor

Actual Frequency

Current

Fault

Communication

--------------------------------------------------

Deviation

↓

Diagnostic Warning

--------------------------------------------------
21. State Machine Overview
--------------------------------------------------

The Blower Function Block shall operate
using a deterministic state machine.

Only one state may be active
during one PLC scan.

--------------------------------------------------
22. STATE_OFF
--------------------------------------------------

Purpose

Blower disabled.

Entry

Enable = FALSE

Actions

Drive Run = FALSE

Frequency = 0

Busy = FALSE

Ready = FALSE

Exit

Enable = TRUE

↓

INITIALIZE

--------------------------------------------------
23. STATE_INITIALIZE
--------------------------------------------------

Purpose

Initialize blower.

Actions

Load Parameters

Verify Communication

Verify Drive

Reset Timers

Reset Counters

Read Drive Status

Exit

Initialization Complete

↓

READY

--------------------------------------------------
24. STATE_READY
--------------------------------------------------

Purpose

Waiting for Run Command.

Actions

Monitor Drive

Monitor Communication

Monitor Frequency

Monitor Current

Exit

Run Command

↓

START

--------------------------------------------------
25. STATE_START
--------------------------------------------------

Purpose

Start Drive.

Actions

Enable Drive

Start Acceleration Timer

Monitor Running Signal

Exit

Drive Running

↓

ACCELERATION

--------------------------------------------------
26. STATE_ACCELERATION
--------------------------------------------------

Purpose

Reach Target Frequency.

Actions

Ramp Frequency

Read Actual Frequency

Monitor Current

Monitor Fault

Exit

Frequency Stable

↓

VERIFY

--------------------------------------------------
27. STATE_VERIFY
--------------------------------------------------

Purpose

Verify blower stability.

Checks

Frequency

Current

Communication

Fault Status

--------------------------------------------------

Exit

Verification Passed

↓

RUNNING

--------------------------------------------------
28. STATE_RUNNING
--------------------------------------------------

Purpose

Maintain stable airflow.

Actions

Maintain Target Frequency

Monitor Drive

Update Statistics

Update Runtime

Update Health Score

--------------------------------------------------

Exit

Stop Command

↓

DECELERATION

--------------------------------------------------
29. STATE_DECELERATION
--------------------------------------------------

Purpose

Controlled shutdown.

Actions

Ramp Down

Monitor Frequency

--------------------------------------------------

Exit

Frequency Zero

↓

STOP

--------------------------------------------------
30. STATE_STOP
--------------------------------------------------

Actions

Disable Drive

Reset Outputs

Store Runtime

Store Statistics

--------------------------------------------------

Exit

READY

--------------------------------------------------
31. STATE_MANUAL
--------------------------------------------------

Purpose

Manual blower operation.

Allowed

Run

Stop

Frequency Change

--------------------------------------------------

Mission Scheduler ignored.

--------------------------------------------------
32. STATE_SERVICE
--------------------------------------------------

Purpose

Engineering diagnostics.

Allowed

Manual Run

Frequency Test

Communication Test

Current Monitoring

--------------------------------------------------

Every action logged.

--------------------------------------------------
33. STATE_SIMULATION
--------------------------------------------------

Purpose

Software testing
without physical hardware.

--------------------------------------------------

Simulated

Ready

Frequency

Current

Running

--------------------------------------------------

Simulation clearly indicated.

--------------------------------------------------
34. STATE_FAULT
--------------------------------------------------

Purpose

Protect equipment.

Actions

Disable Drive

Generate Alarm

Store Snapshot

Update Statistics

--------------------------------------------------

Exit

Engineering Reset

--------------------------------------------------
35. State Transition Rules
--------------------------------------------------

READY

↓

START

Run Command

----------------------------

START

↓

ACCELERATION

Running Feedback

----------------------------

ACCELERATION

↓

VERIFY

Target Frequency

----------------------------

VERIFY

↓

RUNNING

Verification Passed

----------------------------

RUNNING

↓

DECELERATION

Stop Command

----------------------------

DECELERATION

↓

STOP

Frequency Zero

----------------------------

STOP

↓

READY

Shutdown Complete

--------------------------------------------------
36. Illegal Transitions
--------------------------------------------------

OFF

↓

RUNNING

Not Allowed

----------------------------

READY

↓

VERIFY

Not Allowed

----------------------------

FAULT

↓

RUNNING

Not Allowed

--------------------------------------------------

Undefined transitions prohibited.

--------------------------------------------------
37. Frequency Validation
--------------------------------------------------

Verify

Minimum Frequency

Maximum Frequency

Configured Limits

--------------------------------------------------

Invalid Frequency

↓

Reject Command

--------------------------------------------------
38. Frequency Stability
--------------------------------------------------

Stable Frequency

requires

Actual Frequency

within tolerance

during verification period.

--------------------------------------------------
39. Current Monitoring
--------------------------------------------------

Monitor

Motor Current

Average Current

Peak Current

--------------------------------------------------

Current above limit

↓

Warning

↓

Critical Alarm

--------------------------------------------------
40. End Of State Machine
--------------------------------------------------

The blower state machine
shall remain deterministic,
predictable,
and fully recoverable.

--------------------------------------------------
41. Frequency Control Algorithm
--------------------------------------------------

Purpose

Maintain stable airflow
during feed transport.

--------------------------------------------------
42. Frequency Reference
--------------------------------------------------

Reference received from

FB_LineManager

--------------------------------------------------

Verify

Minimum Limit

Maximum Limit

Ramp Rules

--------------------------------------------------
43. Frequency Ramp
--------------------------------------------------

Increase

using configured

Acceleration Time.

--------------------------------------------------

Decrease

using configured

Deceleration Time.

--------------------------------------------------

Instant frequency changes
are prohibited.

--------------------------------------------------
44. Frequency Error
--------------------------------------------------

Frequency Error

=

Target Frequency

-

Actual Frequency

--------------------------------------------------

Error monitored

every PLC scan.

--------------------------------------------------
45. Frequency Tolerance
--------------------------------------------------

Default

±0.5 Hz

--------------------------------------------------

Tolerance configurable.

--------------------------------------------------
46. Frequency Recovery
--------------------------------------------------

Temporary deviation

↓

Continue Monitoring

--------------------------------------------------

Persistent deviation

↓

Diagnostic Warning

--------------------------------------------------

Critical deviation

↓

Alarm

--------------------------------------------------
47. Current Supervision
--------------------------------------------------

Monitor

Instant Current

Average Current

Peak Current

--------------------------------------------------

Current trend stored.

--------------------------------------------------
48. Overload Detection
--------------------------------------------------

Current

>

Configured Limit

↓

Warning

--------------------------------------------------

Persistent overload

↓

Critical Alarm

↓

Stop Drive

--------------------------------------------------
49. Communication Supervision
--------------------------------------------------

Monitor

Modbus Communication

Drive Status

Heartbeat

Timeout

--------------------------------------------------

Communication Loss

↓

Pause Mission

↓

Alarm

--------------------------------------------------
50. Drive Fault Handling
--------------------------------------------------

Drive Fault

↓

Store Fault Code

↓

Generate Alarm

↓

Disable Run Command

↓

Wait Reset

--------------------------------------------------
51. Restart Policy
--------------------------------------------------

Automatic Restart

Allowed only for

Temporary Communication Timeout

--------------------------------------------------

Automatic Restart

Prohibited for

Drive Fault

Overcurrent

Emergency Stop

--------------------------------------------------
52. Runtime Monitoring
--------------------------------------------------

Update

Every PLC Scan

Frequency

Current

Runtime

Energy Estimate

Health Score

--------------------------------------------------
53. Runtime Statistics
--------------------------------------------------

Store

Start Count

Stop Count

Runtime

Alarm Count

Warning Count

Average Frequency

Average Current

--------------------------------------------------
54. Lifetime Statistics
--------------------------------------------------

Retentive

Lifetime Runtime

Lifetime Starts

Lifetime Faults

Lifetime Energy Estimate

--------------------------------------------------
55. Health Score
--------------------------------------------------

Frequency Stability

30%

Communication

20%

Current

20%

Fault History

20%

Runtime Trend

10%

--------------------------------------------------

Overall

0...100%

--------------------------------------------------
56. Mechanical Protection
--------------------------------------------------

Unexpected Stop

↓

Generate Alarm

↓

Store Snapshot

↓

Require Inspection

--------------------------------------------------
57. Cooling Considerations
--------------------------------------------------

Future Support

Motor Temperature

Drive Temperature

Bearing Temperature

--------------------------------------------------

Reserved for expansion.

--------------------------------------------------
58. Engineering Diagnostics
--------------------------------------------------

Display

Target Frequency

Actual Frequency

Frequency Error

Current

Runtime

Drive State

Health Score

--------------------------------------------------
59. Snapshot Contents
--------------------------------------------------

Store

State

Frequency

Current

Fault Code

Runtime

Communication Status

Health Score

--------------------------------------------------
60. End Of Frequency Control
--------------------------------------------------

The blower shall maintain
stable airflow
through continuous monitoring,
validation
and controlled regulation.

--------------------------------------------------
61. Alarm Management
--------------------------------------------------

Purpose

Detect

Classify

Protect

Record

Recover

all blower related faults.

--------------------------------------------------
62. Alarm Severity
--------------------------------------------------

Information

↓

Warning

↓

Alarm

↓

Critical

--------------------------------------------------

Severity configurable.

--------------------------------------------------
63. BLW001
--------------------------------------------------

Communication Timeout

--------------------------------------------------

Cause

Drive not responding.

--------------------------------------------------

Reaction

Pause Mission

Store Snapshot

Generate Alarm

--------------------------------------------------
64. BLW002
--------------------------------------------------

Drive Fault

--------------------------------------------------

Cause

VFD reports fault.

--------------------------------------------------

Reaction

Stop Blower

Pause Mission

Store Fault Code

--------------------------------------------------
65. BLW003
--------------------------------------------------

Frequency Not Reached

--------------------------------------------------

Cause

Actual Frequency

does not reach

Target Frequency

within timeout.

--------------------------------------------------

Reaction

Pause Mission

--------------------------------------------------
66. BLW004
--------------------------------------------------

Over Current

--------------------------------------------------

Cause

Motor Current

>

Configured Limit

--------------------------------------------------

Reaction

Immediate Stop

Critical Alarm

--------------------------------------------------
67. BLW005
--------------------------------------------------

Unexpected Stop

--------------------------------------------------

Cause

Drive stopped

without command.

--------------------------------------------------

Reaction

Mission Pause

Diagnostic Snapshot

--------------------------------------------------
68. BLW006
--------------------------------------------------

Invalid Frequency Feedback

--------------------------------------------------

Cause

Frequency

outside

engineering limits.

--------------------------------------------------

Reaction

Alarm

--------------------------------------------------
69. BLW007
--------------------------------------------------

Configuration Error

--------------------------------------------------

Cause

Invalid engineering parameter.

--------------------------------------------------

Reaction

Prevent Startup

--------------------------------------------------
70. Alarm Reset Policy
--------------------------------------------------

Reset allowed only when

Fault Removed

Communication Healthy

Drive Ready

Operator Reset

--------------------------------------------------

Automatic reset prohibited.

--------------------------------------------------
71. Alarm History
--------------------------------------------------

Store

Alarm Code

Timestamp

Mission ID

Current State

Frequency

Current

Operator

Recovery Action

--------------------------------------------------

Minimum

10,000

records.

--------------------------------------------------
72. Alarm Statistics
--------------------------------------------------

Store

Communication Faults

Drive Faults

Current Faults

Frequency Faults

Configuration Errors

--------------------------------------------------

Retentive.

--------------------------------------------------
73. Alarm Escalation
--------------------------------------------------

Repeated Alarm

↓

Increase Severity

↓

Maintenance Warning

↓

Engineering Notification

--------------------------------------------------
74. Diagnostic Recommendations
--------------------------------------------------

Every alarm provides

Possible Cause

Inspection Procedure

Repair Recommendation

Estimated Repair Time

--------------------------------------------------
75. Snapshot
--------------------------------------------------

Store

State

Target Frequency

Actual Frequency

Current

Fault Code

Runtime

Communication

Health Score

--------------------------------------------------
76. Alarm Export
--------------------------------------------------

Supported Formats

CSV

PDF

JSON

ZIP

--------------------------------------------------

Engineering only.

--------------------------------------------------
77. Alarm Correlation
--------------------------------------------------

Related alarms grouped.

Example

Communication Timeout

↓

Drive Fault

↓

Unexpected Stop

--------------------------------------------------

Root Cause displayed.

--------------------------------------------------
78. Operator Guidance
--------------------------------------------------

Every alarm includes

Operator Action

Wait

Reset

Call Service

Stop Production

--------------------------------------------------
79. Engineering Guidance
--------------------------------------------------

Engineering screen displays

Fault History

Snapshots

Drive Status

Communication Quality

Current Trend

--------------------------------------------------
80. End Of Alarm Section
--------------------------------------------------

Every blower alarm

shall be

detectable

recoverable

traceable.

--------------------------------------------------
81. Communication Design
--------------------------------------------------

Purpose

Provide deterministic communication
between PLC
and Delta MS300.

--------------------------------------------------
82. Communication Protocol
--------------------------------------------------

Primary

Modbus RTU

RS485

--------------------------------------------------

Future

Ethernet

MQTT

--------------------------------------------------
83. Communication Cycle
--------------------------------------------------

Every PLC Scan

↓

Send Command

↓

Receive Status

↓

Validate Data

↓

Update Runtime

--------------------------------------------------
84. Communication Watchdog
--------------------------------------------------

Heartbeat

Default

1000 ms

--------------------------------------------------

Timeout

↓

Communication Alarm

--------------------------------------------------
85. Communication Retry
--------------------------------------------------

Retry Count

Configurable

Default

3

--------------------------------------------------

Retry only for

Communication Timeout.

--------------------------------------------------
86. Data Validation
--------------------------------------------------

Verify

Frequency

Current

Drive Status

Fault Code

--------------------------------------------------

Invalid Data

↓

Reject

↓

Generate Warning

--------------------------------------------------
87. Drive Status Mapping
--------------------------------------------------

Drive Ready

Drive Running

Drive Fault

Drive Warning

Communication OK

--------------------------------------------------

Mapped

to internal structures.

--------------------------------------------------
88. Command Structure
--------------------------------------------------

Run

Stop

Reset Fault

Frequency Reference

--------------------------------------------------

Commands buffered.

--------------------------------------------------
89. Feedback Structure
--------------------------------------------------

Actual Frequency

Output Current

Fault Code

Running

Ready

Warning

--------------------------------------------------
90. End Of Communication Section
--------------------------------------------------

Communication shall remain

deterministic

validated

recoverable.

--------------------------------------------------
91. Service Mode
--------------------------------------------------

Purpose

Provide engineering tools
for commissioning
and maintenance.

--------------------------------------------------
92. Service Functions
--------------------------------------------------

Manual Run

Manual Stop

Frequency Override

Communication Test

Drive Reset

--------------------------------------------------
93. Frequency Override
--------------------------------------------------

Engineering enters

Target Frequency

↓

Validation

↓

Output to Drive

--------------------------------------------------

Mission Scheduler disabled.

--------------------------------------------------
94. Drive Diagnostics
--------------------------------------------------

Display

Ready

Running

Current

Frequency

Fault Code

Communication

--------------------------------------------------

Refresh

Every PLC Scan.

--------------------------------------------------
95. Communication Monitor
--------------------------------------------------

Display

Request Time

Response Time

Retries

Timeouts

Packet Counter

--------------------------------------------------
96. Runtime Graph
--------------------------------------------------

Display

Frequency

Current

Health Score

Runtime

--------------------------------------------------

Future

Trend Graph

--------------------------------------------------
97. Snapshot Viewer
--------------------------------------------------

Display

Current State

Frequency

Current

Fault

Communication

Runtime

--------------------------------------------------
98. Simulation Mode
--------------------------------------------------

Simulate

Running

Ready

Frequency

Current

Fault

--------------------------------------------------

Hardware disconnected.

--------------------------------------------------
99. Service Report
--------------------------------------------------

Generate

Current Parameters

Drive Status

Statistics

Alarm History

Health Report

--------------------------------------------------

Export supported.

--------------------------------------------------
100. End Of Service Section
--------------------------------------------------

Engineering shall have
complete visibility
without affecting
production safety.

--------------------------------------------------
101. Runtime Monitoring
--------------------------------------------------

Purpose

Continuously monitor blower performance
during operation.

Monitoring shall execute
every PLC scan.

--------------------------------------------------
102. Runtime Variables
--------------------------------------------------

Current State

Target Frequency

Actual Frequency

Frequency Error

Motor Current

Drive Status

Runtime

Start Counter

Stop Counter

Health Score

--------------------------------------------------
103. Runtime Buffer
--------------------------------------------------

Store

Current Frequency

Current

Current State

Alarm Status

Communication Status

Timestamp

--------------------------------------------------

Buffer updated

every PLC scan.

--------------------------------------------------
104. Frequency Trend
--------------------------------------------------

Calculate

Instant Frequency

Average Frequency

Minimum Frequency

Maximum Frequency

--------------------------------------------------

Trend retained

per mission.

--------------------------------------------------
105. Current Trend
--------------------------------------------------

Calculate

Instant Current

Average Current

Maximum Current

--------------------------------------------------

Trend stored

for diagnostics.

--------------------------------------------------
106. Runtime Trend
--------------------------------------------------

Monitor

Continuous Runtime

Idle Time

Mission Runtime

Service Runtime

--------------------------------------------------

Statistics retained.

--------------------------------------------------
107. Performance Index
--------------------------------------------------

Performance calculated using

Frequency Stability

Current Stability

Communication Quality

Alarm Count

Runtime Efficiency

--------------------------------------------------

Performance Score

0...100%

--------------------------------------------------
108. Health Calculation
--------------------------------------------------

Health Score recalculated

every second.

--------------------------------------------------

Inputs

Current

Frequency

Runtime

Communication

Fault History

--------------------------------------------------
109. Predictive Maintenance
--------------------------------------------------

Generate Recommendation

if

Health Score decreases

continuously.

--------------------------------------------------

Possible Reasons

Motor Wear

Bearing Wear

Drive Problems

Communication Issues

--------------------------------------------------
110. Runtime Snapshot
--------------------------------------------------

Snapshot includes

Current Frequency

Motor Current

Runtime

Health Score

Current Alarm

Communication

Timestamp

--------------------------------------------------

Snapshots retained.

--------------------------------------------------
111. Mission Statistics
--------------------------------------------------

Store

Mission Runtime

Average Frequency

Average Current

Energy Estimate

Alarm Count

--------------------------------------------------

Mission statistics

exportable.

--------------------------------------------------
112. Daily Statistics
--------------------------------------------------

Store

Daily Runtime

Daily Starts

Daily Stops

Daily Energy Estimate

Daily Alarm Count

--------------------------------------------------

Reset

every day.

--------------------------------------------------
113. Weekly Statistics
--------------------------------------------------

Store

Weekly Runtime

Weekly Energy

Weekly Faults

Weekly Availability

--------------------------------------------------

Retained permanently.

--------------------------------------------------
114. Monthly Statistics
--------------------------------------------------

Store

Monthly Runtime

Monthly Starts

Monthly Stops

Monthly Faults

Maintenance Hours

--------------------------------------------------

Available

for reports.

--------------------------------------------------
115. Lifetime Statistics
--------------------------------------------------

Store

Lifetime Runtime

Lifetime Energy

Lifetime Starts

Lifetime Stops

Lifetime Faults

--------------------------------------------------

Retentive.

--------------------------------------------------
116. Availability
--------------------------------------------------

Availability

=

Operating Time

/

Available Time

--------------------------------------------------

Displayed

as percentage.

--------------------------------------------------
117. Reliability
--------------------------------------------------

Calculate

MTBF

Mean Time Between Failures

--------------------------------------------------

Displayed

to engineering.

--------------------------------------------------
118. Maintainability
--------------------------------------------------

Calculate

MTTR

Mean Time To Repair

--------------------------------------------------

Updated

after every repair.

--------------------------------------------------
119. Engineering Dashboard
--------------------------------------------------

Display

Frequency

Current

Runtime

Health Score

Availability

MTBF

MTTR

--------------------------------------------------

Real-time refresh.

--------------------------------------------------
120. End Of Runtime Monitoring
--------------------------------------------------

Runtime monitoring
shall continuously evaluate
blower performance
throughout its lifetime.

--------------------------------------------------
121. Acceptance Tests
--------------------------------------------------

Purpose

Verify complete blower functionality.

--------------------------------------------------
122. BLW-T001
--------------------------------------------------

Startup Test

Expected

READY

No Alarm

Communication OK

--------------------------------------------------
123. BLW-T002
--------------------------------------------------

Start Command

Expected

Drive Starts

Target Frequency Reached

--------------------------------------------------
124. BLW-T003
--------------------------------------------------

Stop Command

Expected

Controlled Deceleration

Drive Stops

--------------------------------------------------
125. BLW-T004
--------------------------------------------------

Frequency Change

Expected

Smooth Ramp

No Oscillation

--------------------------------------------------
126. BLW-T005
--------------------------------------------------

Communication Loss

Expected

BLW001

Mission Pause

--------------------------------------------------
127. BLW-T006
--------------------------------------------------

Drive Fault

Expected

BLW002

Mission Pause

--------------------------------------------------
128. BLW-T007
--------------------------------------------------

Over Current

Expected

Immediate Stop

Critical Alarm

--------------------------------------------------
129. BLW-T008
--------------------------------------------------

Unexpected Stop

Expected

Alarm

Snapshot Stored

--------------------------------------------------
130. BLW-T009
--------------------------------------------------

Manual Mode

Expected

Engineering Control

--------------------------------------------------
131. BLW-T010
--------------------------------------------------

Service Mode

Expected

Frequency Override

Communication Test

--------------------------------------------------
132. BLW-T011
--------------------------------------------------

Power Failure

Expected

Recovery Ready

--------------------------------------------------
133. BLW-T012
--------------------------------------------------

Stress Test

1000 Start/Stop Cycles

Expected

No Communication Error

No Software Fault

--------------------------------------------------
134. BLW-T013
--------------------------------------------------

Long Duration Test

24 Hours Continuous

Expected

Stable Frequency

Stable Current

No Restart

--------------------------------------------------
135. Acceptance Criteria
--------------------------------------------------

Mandatory Tests

100%

Passed

--------------------------------------------------

No Critical Fault

No Undefined Behaviour

--------------------------------------------------
136. Test Documentation
--------------------------------------------------

Store

Engineer

Date

Software Version

Drive Firmware

Result

Notes

--------------------------------------------------
137. FAT Approval
--------------------------------------------------

Engineering

Quality

Commissioning

--------------------------------------------------

Approval required.

--------------------------------------------------
138. SAT Approval
--------------------------------------------------

Customer

Commissioning

Engineering

--------------------------------------------------

Required before production.

--------------------------------------------------
139. Release Criteria
--------------------------------------------------

Implementation

Reviewed

Tested

Approved

Documented

--------------------------------------------------
140. End Of Acceptance Tests
--------------------------------------------------

FB_Blower approved
for production implementation.

--------------------------------------------------
141. Delta PLC Implementation
--------------------------------------------------

Target Platform

Delta DVP-SV3

--------------------------------------------------
142. Drive Family
--------------------------------------------------

Primary

Delta MS300

--------------------------------------------------

Future

C2000

CP2000

MH300

--------------------------------------------------
143. PLC Scan Rules
--------------------------------------------------

Execute once

per PLC scan.

--------------------------------------------------

No blocking code.

--------------------------------------------------
144. Retentive Registers
--------------------------------------------------

Store

Parameters

Statistics

Maintenance

Health

--------------------------------------------------

Runtime variables

non-retentive.

--------------------------------------------------
145. Register Allocation
--------------------------------------------------

Reserved

Runtime

Parameters

Statistics

Diagnostics

Engineering

--------------------------------------------------

Detailed mapping

defined separately.

--------------------------------------------------
146. Communication Mapping
--------------------------------------------------

Read

Status Word

Frequency

Current

Fault Code

--------------------------------------------------

Write

Run

Stop

Frequency Reference

Reset

--------------------------------------------------
147. Performance Requirements
--------------------------------------------------

Maximum Scan Impact

1 ms

--------------------------------------------------

Communication Timeout

Configurable

--------------------------------------------------

Recovery Time

<10 Seconds

--------------------------------------------------
148. Software Portability
--------------------------------------------------

Architecture independent of

PLC

HMI

Windows

Mobile

Communication Layer

--------------------------------------------------

Portable by design.

--------------------------------------------------
149. Revision History
--------------------------------------------------

Version 1.0

Initial Design

--------------------------------------------------

Version 2.0

Complete Software Architecture

--------------------------------------------------
150. End Of FB_Blower Design Specification
--------------------------------------------------

This document defines
the complete engineering specification
for FB_Blower.

Implementation shall comply
with this specification.

Status

Engineering Complete

Ready For Implementation

--------------------------------------------------

END OF DOCUMENT