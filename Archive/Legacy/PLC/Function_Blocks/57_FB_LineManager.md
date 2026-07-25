# Legacy PLC LineManager Specification

> **Status:** Legacy / Superseded  
> **Former path:** `02_Software_Design/PLC/01_Function_Blocks/57_FB_LineManager.md`  
> **Reason archived:** Realtime sequencing was mixed with queue, history, statistics, maintenance, and Smart Farm responsibilities.  
> **Replacement:** `02_Software_Design/PLC/01_Function_Blocks/FB_LineManager.md`

---

# FB_LineManager

Document ID : AQ-FB-057

Version : 2.1

Status : Draft

Author : NVM Engineering

Last Update : 2026-07-05

--------------------------------------------------
Related Documents
--------------------------------------------------

01_System_Engineering/14_Line_Manager_Specification.md

01_System_Engineering/15_State_Machine_Specification.md

01_System_Engineering/24_Feeding_Algorithm.md

01_System_Engineering/26_Recovery_System.md

--------------------------------------------------
Revision History
--------------------------------------------------

Version 2.0
Initial Software Design

Version 2.1
Runtime & Diagnostics Added

--------------------------------------------------
Table Of Contents
--------------------------------------------------

1. Purpose
--------------------------------------------------

FB_LineManager is responsible for controlling one complete feeding line.

Every feeding line has exactly one FB_LineManager instance.

Current Project

6 Feeding Lines

↓

6 Line Managers

The Line Manager coordinates every operation but never directly controls physical outputs.

Hardware is controlled by dedicated Function Blocks.

--------------------------------------------------
2. Responsibilities
--------------------------------------------------

Mission Execution

Mission Queue

Mission Validation

Selector Coordination

Blower Coordination

Dosing Coordination

Alarm Coordination

Recovery

History

Statistics

Maintenance Counters

Smart Farm Update

--------------------------------------------------
3. Controlled Function Blocks
--------------------------------------------------

FB_Selector

FB_Blower

FB_Dosing

FB_MissionManager

FB_AlarmManager

FB_Statistics

FB_HealthMonitor

--------------------------------------------------
4. Inputs
--------------------------------------------------

Enable

Emergency Stop

Service Mode

Mission Available

Mission Data

Selector Ready

Selector Alarm

Blower Ready

Blower Alarm

Dosing Ready

Dosing Alarm

--------------------------------------------------
5. Outputs
--------------------------------------------------

Current State

Current Mission

Mission Progress

Remaining Feed

Delivered Feed

Ready

Busy

Alarm

--------------------------------------------------
6. Internal Variables
--------------------------------------------------

MissionID

CurrentStep

CurrentFeed

RemainingFeed

DeliveredFeed

MissionTimer

PauseTimer

RetryCounter

RecoveryFlag

--------------------------------------------------
7. State Enumeration
--------------------------------------------------

STATE_OFF

STATE_INITIALIZE

STATE_READY

STATE_WAIT_MISSION

STATE_PREPARE

STATE_SELECTOR

STATE_BLOWER

STATE_PRERUN

STATE_DOSING

STATE_POSTRUN

STATE_COMPLETE

STATE_PAUSE

STATE_SERVICE

STATE_RECOVERY

STATE_ALARM

--------------------------------------------------
8. Scan Behaviour
--------------------------------------------------

Executed every PLC scan.

Maximum execution time

1 scan.

No blocking loops allowed.

No WAIT instructions allowed.

Timers shall be state based.

--------------------------------------------------
9. Mission Validation
--------------------------------------------------

Before mission starts

Verify

Mission Exists

Mission Enabled

Feed Exists

Cage Exists

Fish Lot Exists

Assigned Silo Exists

Selector Ready

Blower Ready

Dosing Ready

Communication Healthy

Emergency Stop OFF

If one validation fails

Mission shall not start.

--------------------------------------------------
10. Mission Lock
--------------------------------------------------

When mission starts

Mission becomes locked.

The following parameters cannot change

Target Feed

Feed Type

Fish Lot

Selector Eye

Assigned Silo

Mission Priority

Operator

Mission ID

--------------------------------------------------
11. Runtime Monitoring
--------------------------------------------------

During feeding

Update every scan

Mission Progress

Remaining Feed

Delivered Feed

Mission Time

Average Feed Rate

Average Blower Frequency

Average Dosing Frequency

--------------------------------------------------
12. Recovery Support
--------------------------------------------------

Continuously store

Mission State

Mission Progress

Current Step

Remaining Feed

Delivered Feed

Current Cage

Current Fish Lot

Current Silo

Current Selector Eye

--------------------------------------------------
13. History
--------------------------------------------------

Mission Start

Mission Finish

Mission Pause

Mission Resume

Mission Cancel

Mission Failure

Operator Actions

Service Actions

--------------------------------------------------
14. Smart Farm Interface
--------------------------------------------------

Mission Complete

↓

Update Feed History

↓

Update Cage

↓

Update Fish Lot

↓

Update Biomass

↓

Update FCR

↓

Update Growth

--------------------------------------------------
15. Statistics
--------------------------------------------------

Completed Missions

Cancelled Missions

Failed Missions

Paused Missions

Average Mission Duration

Total Feed Delivered

Total Runtime

Average Mission Efficiency

--------------------------------------------------
16. Future Expansion
--------------------------------------------------

Dual Selector

Dual Blower

Automatic Feed Switching

Automatic Silo Switching

AI Mission Optimization

Cloud Synchronization

--------------------------------------------------
17. Engineering Rules
--------------------------------------------------

No direct IO access.

No direct Modbus access.

Only FB interfaces shall be used.

Every transition shall be logged.

Every alarm shall be forwarded to Alarm Manager.

Every parameter shall be validated.

--------------------------------------------------
18. Function Block Interface
--------------------------------------------------

Function Block Name

FB_LineManager

--------------------------------------------------

Instance Count

Current Project

6

One instance shall exist for every feeding line.

--------------------------------------------------

Execution

Cyclic

Every PLC Scan

--------------------------------------------------

Execution Priority

High

--------------------------------------------------

Memory Type

Static Instance

--------------------------------------------------

Retentive Data

Mission Queue

Current Mission

Runtime Counters

Statistics

Maintenance Counters

Recovery Data

--------------------------------------------------
19. Function Block Inputs
--------------------------------------------------

Enable

BOOL

EmergencyStop

BOOL

AutoMode

BOOL

ManualMode

BOOL

ServiceMode

BOOL

MissionAvailable

BOOL

MissionData

STRUCT

SelectorStatus

STRUCT

BlowerStatus

STRUCT

DosingStatus

STRUCT

AlarmStatus

STRUCT

CommunicationStatus

STRUCT

--------------------------------------------------
20. Function Block Outputs
--------------------------------------------------

Ready

BOOL

Busy

BOOL

Alarm

BOOL

CurrentState

ENUM

MissionProgress

REAL

DeliveredFeed

REAL

RemainingFeed

REAL

EstimatedFinishTime

TIME

CurrentMission

STRUCT

--------------------------------------------------
21. Internal Structures
--------------------------------------------------

MissionInfo

MissionRuntime

FeedStatistics

RuntimeStatistics

MaintenanceStatistics

RecoveryInformation

QueueInformation

--------------------------------------------------
22. State Entry Actions
--------------------------------------------------

STATE_INITIALIZE

Reset temporary variables.

Load parameters.

Load calibration.

Read recovery information.

--------------------------------------------------

STATE_PREPARE

Validate mission.

Verify machines.

Check communication.

Reset mission timers.

--------------------------------------------------

STATE_SELECTOR

Send movement command.

Start timeout timer.

--------------------------------------------------

STATE_BLOWER

Start blower.

Reset blower timer.

--------------------------------------------------

STATE_PRERUN

Start prerun timer.

--------------------------------------------------

STATE_DOSING

Reset pulse counter.

Reset feed counter.

Start mission timer.

--------------------------------------------------

STATE_POSTRUN

Stop dosing.

Start blower postrun timer.

--------------------------------------------------

STATE_COMPLETE

Store history.

Update Smart Farm.

Update statistics.

Update maintenance.

--------------------------------------------------
23. State Exit Conditions
--------------------------------------------------

INITIALIZE

↓

READY

All parameters loaded.

--------------------------------------------------

READY

↓

WAIT_MISSION

Mission available.

--------------------------------------------------

WAIT_MISSION

↓

PREPARE

Mission selected.

--------------------------------------------------

PREPARE

↓

SELECTOR

Validation successful.

--------------------------------------------------

SELECTOR

↓

BLOWER

Selector Ready.

--------------------------------------------------

BLOWER

↓

PRERUN

Blower Ready.

--------------------------------------------------

PRERUN

↓

DOSING

Timer completed.

--------------------------------------------------

DOSING

↓

POSTRUN

Target feed reached.

--------------------------------------------------

POSTRUN

↓

COMPLETE

PostRun timer completed.

--------------------------------------------------

COMPLETE

↓

READY

History stored successfully.

--------------------------------------------------
24. Transition Table
--------------------------------------------------

Current State

READY

Event

Mission Selected

Next State

PREPARE

--------------------------------------------------

Current State

PREPARE

Event

Validation Failed

Next State

ALARM

--------------------------------------------------

Current State

SELECTOR

Event

Timeout

Next State

ALARM

--------------------------------------------------

Current State

DOSING

Event

Pause Command

Next State

PAUSE

--------------------------------------------------

Current State

PAUSE

Event

Resume

Next State

BLOWER

--------------------------------------------------

Current State

ANY

Event

Emergency Stop

Next State

ALARM

--------------------------------------------------
25. Scan Cycle Behaviour
--------------------------------------------------

Every scan

Read Inputs

↓

Read Child Function Blocks

↓

Execute Current State

↓

Calculate Outputs

↓

Update Statistics

↓

Update Recovery Memory

↓

Return

Execution shall never exceed one PLC scan.

--------------------------------------------------
26. Mission Queue Structure
--------------------------------------------------

Each Line Manager owns one queue.

Queue Item

Mission ID

Fish Lot

Cage

Feed Type

Feed Amount

Feed Rate

Priority

Creation Time

Operator

Mission Status

--------------------------------------------------

Queue Capacity

Configurable

Default

50 Missions

--------------------------------------------------
27. Recovery Memory
--------------------------------------------------

The following values shall always remain retentive.

Current State

Mission Queue

Mission Progress

Delivered Feed

Remaining Feed

Mission Timer

Current Cage

Current Fish Lot

Current Feed

Current Silo

Current Selector Eye

--------------------------------------------------

These values shall be updated continuously during operation.

--------------------------------------------------
28. Child Function Block Execution Order
--------------------------------------------------

1

FB_Selector

↓

2

FB_Blower

↓

3

FB_Dosing

↓

4

FB_AlarmManager

↓

5

FB_Statistics

↓

6

FB_HealthMonitor

--------------------------------------------------

Execution order shall remain constant.

--------------------------------------------------
29. Fault Strategy
--------------------------------------------------

Selector Alarm

↓

Mission Pause

--------------------------------------------------

Blower Alarm

↓

Mission Pause

--------------------------------------------------

Dosing Alarm

↓

Mission Pause

--------------------------------------------------

Communication Failure

↓

Mission Pause

--------------------------------------------------

Emergency Stop

↓

Mission Abort

--------------------------------------------------

Operator shall decide

Resume

or

Cancel

--------------------------------------------------
30. Performance Targets
--------------------------------------------------

Mission Validation

<100 ms

--------------------------------------------------

State Transition

1 PLC Scan

--------------------------------------------------

Mission Recovery

<10 seconds

--------------------------------------------------

Queue Update

<50 ms

--------------------------------------------------

Statistics Update

<100 ms

--------------------------------------------------

History Save

<500 ms

--------------------------------------------------
31. Mission Lifecycle
--------------------------------------------------

Every mission shall follow exactly one lifecycle.

Mission Created

↓

Mission Waiting

↓

Mission Validated

↓

Mission Locked

↓

Mission Executing

↓

Mission Completed

or

Mission Paused

or

Mission Cancelled

or

Mission Failed

Every transition shall be recorded.

--------------------------------------------------
32. Mission States
--------------------------------------------------

CREATED

Mission created by operator.

--------------------------------------------------

WAITING

Mission waiting inside queue.

--------------------------------------------------

VALIDATING

System checks every prerequisite.

--------------------------------------------------

READY

Mission ready for execution.

--------------------------------------------------

RUNNING

Mission currently executing.

--------------------------------------------------

PAUSED

Mission temporarily suspended.

--------------------------------------------------

COMPLETED

Target feed delivered successfully.

--------------------------------------------------

FAILED

Mission terminated because of an alarm.

--------------------------------------------------

CANCELLED

Mission cancelled by operator.

--------------------------------------------------
33. Mission Ownership
--------------------------------------------------

Every mission belongs to

One Farm

↓

One Barge

↓

One Feeding Line

↓

One Cage

↓

One Fish Lot

↓

One Feed Lot

Mission ownership shall never become ambiguous.

--------------------------------------------------
34. Mission Identification
--------------------------------------------------

MissionID

Globally Unique

Mission Number

Human Readable

Creation Time

Execution Time

Completion Time

Operator

Supervisor

--------------------------------------------------
35. Mission Validation Matrix
--------------------------------------------------

Validation Item

Mission Exists

PASS / FAIL

-------------------------

Feed Available

PASS / FAIL

-------------------------

Fish Lot Exists

PASS / FAIL

-------------------------

Cage Exists

PASS / FAIL

-------------------------

Selector Ready

PASS / FAIL

-------------------------

Blower Ready

PASS / FAIL

-------------------------

Dosing Ready

PASS / FAIL

-------------------------

Communication Healthy

PASS / FAIL

-------------------------

Emergency Stop

PASS / FAIL

Mission starts only if every item passes.

--------------------------------------------------
36. Queue Behaviour
--------------------------------------------------

Queue execution

FIFO

by default.

Operator may reorder queue.

Priority missions shall be executed before FIFO missions.

--------------------------------------------------
37. Queue Capacity
--------------------------------------------------

Default

50 Missions

Minimum

10

Maximum

500

Queue size configurable.

--------------------------------------------------
38. Queue Operations
--------------------------------------------------

Insert

Delete

Duplicate

Move Up

Move Down

Disable

Enable

Edit

Sort

Search

Filter

--------------------------------------------------
39. Mission Timeout
--------------------------------------------------

Each mission has maximum execution time.

Timeout configurable.

Default

120 minutes

If timeout occurs

↓

Mission Pause

↓

Alarm

↓

Operator Decision

--------------------------------------------------
40. Pause Strategy
--------------------------------------------------

Mission Pause shall preserve

Mission State

Mission Queue Position

Delivered Feed

Remaining Feed

Mission Timer

Feed Counter

Statistics

Recovery Data

--------------------------------------------------
41. Resume Strategy
--------------------------------------------------

Resume shall never continue blindly.

The following shall be verified again.

Selector

Blower

Dosing

Communication

Safety

If successful

↓

Continue Mission

--------------------------------------------------
42. Cancel Strategy
--------------------------------------------------

Cancel shall

Stop Dosing

↓

Execute Blower PostRun

↓

Save History

↓

Release Queue

↓

Return READY

--------------------------------------------------
43. Failure Strategy
--------------------------------------------------

Unexpected failure

↓

Mission Pause

↓

Store Recovery

↓

Generate Alarm

↓

Notify Operator

System shall never lose mission information.

--------------------------------------------------
44. Mission Completion
--------------------------------------------------

After successful completion

Update Feed History

↓

Update Fish Lot

↓

Update Cage Statistics

↓

Update Daily Feed

↓

Update Smart Farm

↓

Update Reports

↓

Update Maintenance

--------------------------------------------------
45. Mission Statistics
--------------------------------------------------

Store

Mission Duration

Feed Delivered

Average Feed Rate

Average Blower Frequency

Average Dosing Frequency

Number of Pauses

Number of Alarms

Operator

Mission Result

--------------------------------------------------
46. Engineering Notes
--------------------------------------------------

The Line Manager shall never directly operate hardware.

Every machine shall be controlled through its dedicated Function Block.

The Line Manager coordinates.

Child Function Blocks execute.

--------------------------------------------------
47. Sequence Diagram
--------------------------------------------------

Normal Mission Sequence

Operator

↓

Select Mission

↓

Press START

↓

FB_LineManager

↓

Mission Validation

↓

FB_Selector

↓

Move To Target Eye

↓

Selector Ready

↓

FB_Blower

↓

Start

↓

Target Frequency

↓

PreRun Timer

↓

FB_Dosing

↓

Reset Pulse Counter

↓

Start Feeding

↓

Calculate Delivered Feed

↓

Target Reached

↓

Stop Dosing

↓

PostRun

↓

Stop Blower

↓

Mission Complete

↓

Store History

↓

Update Smart Farm

↓

READY

--------------------------------------------------
48. Parallel Execution Strategy
--------------------------------------------------

Every feeding line shall execute independently.

Example

Line 1

Running

Line 2

Paused

Line 3

Waiting

Line 4

Service Mode

Line 5

Running

Line 6

Alarm

The execution state of one line shall never affect another line.

Only Emergency Stop affects the complete system.

--------------------------------------------------
49. Child Function Block Supervision
--------------------------------------------------

Every PLC scan the Line Manager shall supervise

FB_Selector

Ready

Busy

Alarm

State

----------------------------

FB_Blower

Ready

Busy

Alarm

State

----------------------------

FB_Dosing

Ready

Busy

Alarm

State

----------------------------

FB_HealthMonitor

Health Score

----------------------------

FB_AlarmManager

Active Alarm Count

--------------------------------------------------
50. Child Function Block Command Interface
--------------------------------------------------

Selector Commands

MoveToEye()

Stop()

Manual()

Service()

----------------------------

Blower Commands

Start()

Stop()

SetFrequency()

Manual()

----------------------------

Dosing Commands

Start()

Stop()

Pause()

Resume()

Calibration()

--------------------------------------------------
51. Scheduler Behaviour
--------------------------------------------------

Scheduler executes only when

Auto Mode = TRUE

AND

Mission Queue Not Empty

Manual Mode bypasses Scheduler.

Service Mode disables Scheduler.

--------------------------------------------------
52. Feed Calculation Supervision
--------------------------------------------------

Line Manager shall compare

Target Feed

Delivered Feed

Remaining Feed

Expected Feed Rate

Mission Time

If calculated values become inconsistent

↓

Pause Mission

↓

Generate Diagnostic Alarm

--------------------------------------------------
53. Automatic Retry Logic
--------------------------------------------------

Retry is permitted only for

Communication Timeout

Temporary Drive Communication Error

Retry Count

Configurable

Default

3

Retry shall never occur after

Emergency Stop

Critical Alarm

Calibration Error

--------------------------------------------------
54. Mission Integrity Check
--------------------------------------------------

Every scan verify

Mission ID

Feed Type

Fish Lot

Target Cage

Assigned Silo

Assigned Selector Eye

If unexpected modification detected

↓

Pause Mission

↓

Log Event

↓

Require Operator Confirmation

--------------------------------------------------
55. Runtime Data Refresh
--------------------------------------------------

Refresh Every PLC Scan

Mission Progress

Mission State

Delivered Feed

Remaining Feed

Mission Timer

Average Feed Rate

Current Blower Frequency

Current Dosing Frequency

Health Score

Alarm Count

--------------------------------------------------
56. Heartbeat Supervision
--------------------------------------------------

Every child Function Block shall generate

Heartbeat

TRUE

FALSE

TRUE

FALSE

Heartbeat Timeout

↓

Communication Alarm

↓

Pause Mission

--------------------------------------------------
57. Safety Philosophy
--------------------------------------------------

Safety has highest priority.

Production has second priority.

Performance has third priority.

The software shall always prefer

Safe Stop

instead of

Unknown Behaviour.

--------------------------------------------------
58. Mission Completion Verification
--------------------------------------------------

Before marking mission complete

Verify

Dosing Stopped

Blower Stopped

PostRun Finished

Feed Delivered Stored

History Saved

Statistics Updated

Smart Farm Updated

If one verification fails

Mission remains in COMPLETE_PENDING state.

--------------------------------------------------
59. Diagnostic Information
--------------------------------------------------

The following diagnostic values shall be available

Current Scan

Current State

Previous State

Current Mission

Executed Mission Count

Average Scan Time

Maximum Scan Time

Current Queue Size

Retry Counter

Recovery Flag

Current Alarm

--------------------------------------------------
60. Software Metrics
--------------------------------------------------

Maximum State Transition Time

1 Scan

Maximum Queue Update

50 ms

Maximum History Save

500 ms

Maximum Recovery

10 Seconds

Mission Accuracy

± Configurable

System Availability Target

99.9%

--------------------------------------------------
61. Debug Variables
--------------------------------------------------

Visible in Service Mode

Current Step

Current Transition

Current Timer

Current Retry

Current Validation Result

Current Child Status

Current Queue Index

Current Mission GUID

Current Recovery State

--------------------------------------------------
62. Engineering Constraints
--------------------------------------------------

No recursive execution.

No infinite loops.

No blocking instructions.

No direct output access.

No duplicated state transitions.

No hidden timers.

Every transition documented.

Every alarm documented.

Every parameter validated.

--------------------------------------------------
63. Function Block Execution Model
--------------------------------------------------

FB_LineManager shall execute according to the following model.

Every PLC Scan

↓

Read Inputs

↓

Read Child Function Blocks

↓

Evaluate Current State

↓

Execute State Logic

↓

Evaluate State Transition

↓

Update Outputs

↓

Update Runtime Statistics

↓

Update Recovery Memory

↓

End Scan

No output shall be written before the current state evaluation has completed.

--------------------------------------------------
64. Input Processing
--------------------------------------------------

All inputs shall be copied to internal variables at the beginning of the scan.

Example

Input

EmergencyStop

↓

Internal

bEmergencyStop

The remaining execution shall use only internal variables.

This guarantees deterministic execution.

--------------------------------------------------
65. Output Processing
--------------------------------------------------

Outputs shall be written only once.

Output values shall first be calculated internally.

Example

bNextReady

↓

bNextBusy

↓

bNextAlarm

↓

Write Outputs

This prevents inconsistent output states.

--------------------------------------------------
66. Internal Update Order
--------------------------------------------------

Every scan

Update Timers

↓

Update Counters

↓

Update Child Status

↓

Execute Logic

↓

Update Outputs

↓

Store Runtime Data

--------------------------------------------------
67. State Persistence
--------------------------------------------------

The current state shall remain unchanged during the scan.

State changes become active only on the next scan.

Example

Current Scan

STATE_SELECTOR

↓

Transition Requested

STATE_BLOWER

↓

End Scan

↓

Next Scan

STATE_BLOWER

This prevents multiple transitions in a single PLC cycle.

--------------------------------------------------
68. One Transition Rule
--------------------------------------------------

Only one state transition is allowed per PLC scan.

Example

VALID

READY

↓

PREPARE

INVALID

READY

↓

PREPARE

↓

SELECTOR

↓

BLOWER

in the same scan.

--------------------------------------------------
69. State Change Logging
--------------------------------------------------

Every transition shall store

Previous State

Next State

Date

Time

Mission ID

Operator

Transition Reason

--------------------------------------------------
70. State Change Reasons
--------------------------------------------------

Possible reasons

Mission Started

Mission Completed

Pause Command

Resume Command

Timeout

Alarm

Emergency Stop

Recovery

Service Mode

Operator Command

--------------------------------------------------
71. Runtime Consistency Check
--------------------------------------------------

Every scan verify

Busy

Ready

Alarm

State

Mission Progress

Feed Counters

If inconsistent values detected

↓

Diagnostic Warning

--------------------------------------------------
72. Runtime Assertions
--------------------------------------------------

The following conditions shall never occur

Ready = TRUE

Busy = TRUE

Alarm = TRUE

at the same time.

--------------------------------------------------

MissionProgress

>

100 %

not allowed.

--------------------------------------------------

RemainingFeed

<

0

not allowed.

--------------------------------------------------

CurrentState

Undefined

not allowed.

--------------------------------------------------
73. Watchdog Behaviour
--------------------------------------------------

If execution exceeds watchdog time

↓

Abort Current Scan

↓

Generate Critical Alarm

↓

Store Diagnostic Information

↓

Wait Operator

--------------------------------------------------
74. Scan Safe Design
--------------------------------------------------

No dynamic memory allocation.

No recursive execution.

No endless loops.

No blocking delays.

No WAIT instruction.

No busy waiting.

--------------------------------------------------
75. Software Philosophy
--------------------------------------------------

Every PLC scan shall produce a deterministic result.

The same inputs shall always produce the same outputs.

Software behaviour shall never depend on execution timing.

--------------------------------------------------
76. Function Block Data Ownership
--------------------------------------------------

Every runtime variable shall have exactly one owner.

Only the owner Function Block may modify its data.

Other Function Blocks shall have read-only access.

Example

Mission Queue

Owner

FB_LineManager

-------------------------

Selector Position

Owner

FB_Selector

-------------------------

Delivered Feed

Owner

FB_Dosing

-------------------------

Alarm List

Owner

FB_AlarmManager

--------------------------------------------------

This rule prevents unexpected data corruption.

--------------------------------------------------
77. Data Exchange Policy
--------------------------------------------------

Function Blocks shall communicate only through

Inputs

Outputs

Structures

Interfaces

Global variables shall never be used for runtime logic.

Global variables are permitted only for

Configuration

Constants

System Information

--------------------------------------------------
78. Command Arbitration
--------------------------------------------------

Every command shall have exactly one active source.

Possible Sources

Operator

Mission Scheduler

Remote Service

Engineering Service

Recovery Manager

--------------------------------------------------

Priority

Emergency Stop

↓

Engineering Service

↓

Operator

↓

Recovery

↓

Mission Scheduler

--------------------------------------------------

Lower priority commands shall be ignored.

--------------------------------------------------
79. Resource Locking
--------------------------------------------------

During mission execution

Selector

Blower

Dosing Unit

Mission Queue Entry

shall become locked.

Locked resources cannot be modified.

Lock shall be released only after

Mission Complete

Mission Cancel

Mission Abort

--------------------------------------------------
80. Shared Resource Protection
--------------------------------------------------

One hardware device

shall never receive commands from two Function Blocks simultaneously.

Example

INVALID

FB_Service

↓

Start Blower

AND

FB_LineManager

↓

Stop Blower

same scan

--------------------------------------------------

The Command Manager resolves conflicts.

--------------------------------------------------
81. Communication Supervision
--------------------------------------------------

Communication shall be monitored continuously.

Monitored Items

PLC

VFD

Remote IO

Windows Software

Future Mobile Gateway

--------------------------------------------------

Communication Quality

Excellent

Good

Poor

Offline

--------------------------------------------------

Loss of communication shall generate

Warning

or

Alarm

depending on configuration.

--------------------------------------------------
82. Heartbeat Design
--------------------------------------------------

Every intelligent module shall generate heartbeat.

Heartbeat Period

Configurable

Default

1000 ms

--------------------------------------------------

Heartbeat Timeout

↓

Communication Alarm

↓

Event Log

↓

Health Score Update

--------------------------------------------------
83. Scan Time Monitoring
--------------------------------------------------

Every scan shall measure

Current Scan

Maximum Scan

Average Scan

Minimum Scan

--------------------------------------------------

Thresholds

Normal

Warning

Critical

--------------------------------------------------

Exceeding threshold shall generate diagnostics.

--------------------------------------------------
84. Memory Integrity Check
--------------------------------------------------

Critical retentive memory shall be verified.

Verification

Checksum

CRC

Version

--------------------------------------------------

Invalid data

↓

Load Safe Defaults

↓

Generate Alarm

↓

Require Operator Review

--------------------------------------------------
85. Safe Default Values
--------------------------------------------------

If configuration is missing

Software shall never guess.

Load predefined safe values.

Examples

Blower Frequency

Minimum Safe Frequency

-------------------------

Mission Queue

Empty

-------------------------

Feed Rate

Zero

-------------------------

Current Mission

None

--------------------------------------------------

Safe defaults shall be documented.

--------------------------------------------------
86. Software Self-Test
--------------------------------------------------

During startup

Run automatic self-test.

Verify

Parameters

Calibration

Communication

Function Block Initialization

Retentive Memory

--------------------------------------------------

If any test fails

↓

Prevent automatic operation.

--------------------------------------------------
87. Dependency Rules
--------------------------------------------------

FB_LineManager depends on

FB_Selector

FB_Blower

FB_Dosing

FB_AlarmManager

FB_Statistics

--------------------------------------------------

Child Function Blocks

shall never depend on

FB_LineManager.

--------------------------------------------------

Dependency direction

Top

↓

Bottom

Only.

--------------------------------------------------
88. Engineering Assertions
--------------------------------------------------

Assertions enabled

Service Mode

Engineering Mode

--------------------------------------------------

Examples

MissionID > 0

FeedAmount >= 0

CurrentState Valid

QueueIndex Valid

CurrentLine Valid

--------------------------------------------------

Assertion failure

↓

Diagnostic Event

--------------------------------------------------
89. Software Robustness
--------------------------------------------------

Unexpected values

shall never crash execution.

Software shall

Reject

Ignore

Recover

Log

according to configuration.

--------------------------------------------------

Undefined behaviour is prohibited.

--------------------------------------------------
90. Design Principle
--------------------------------------------------

Every engineering decision shall prioritize

Predictability

Maintainability

Safety

Traceability

Scalability

Performance

in that order.

--------------------------------------------------
91. Internal Data Structures
--------------------------------------------------

The following internal structures shall be defined.

ST_Mission

ST_LineRuntime

ST_LineStatistics

ST_LineRecovery

ST_LineParameters

ST_LineHealth

ST_Command

ST_RuntimeInfo

--------------------------------------------------
92. ST_Mission Structure
--------------------------------------------------

Fields

MissionID

MissionNumber

MissionState

MissionPriority

MissionStatus

OperatorID

CreationDate

StartDate

FinishDate

--------------------------------------------------

Production

FarmID

BargeID

LineID

CageID

FishLotID

FeedLotID

SiloID

SelectorEye

--------------------------------------------------

Feed

FeedType

FeedDiameter

TargetFeed

DeliveredFeed

RemainingFeed

FeedRate

--------------------------------------------------

Runtime

MissionTimer

PauseCounter

RetryCounter

AlarmCounter

--------------------------------------------------
93. ST_LineRuntime
--------------------------------------------------

Current State

Previous State

Next State

Current Mission

Current Step

Mission Progress

Current Feed Rate

Current Blower Frequency

Current Dosing Speed

Remaining Feed

Delivered Feed

Estimated Finish Time

--------------------------------------------------
94. ST_LineStatistics
--------------------------------------------------

Mission Count

Completed Missions

Cancelled Missions

Paused Missions

Alarm Count

Average Runtime

Average Feed Rate

Average Blower Frequency

Total Feed Delivered

Total Runtime

--------------------------------------------------
95. ST_LineRecovery
--------------------------------------------------

Recovery Enabled

Recovery Required

Recovery State

Saved Mission

Saved Step

Saved Feed

Saved Timer

Saved Queue Position

Last Shutdown Reason

--------------------------------------------------
96. ST_LineParameters
--------------------------------------------------

Maximum Queue Size

Maximum Feed Rate

Minimum Feed Rate

Maximum Retry

Mission Timeout

PreRun Time

PostRun Time

Communication Timeout

Health Warning Limit

Health Alarm Limit

--------------------------------------------------
97. ST_LineHealth
--------------------------------------------------

Health Score

Communication Quality

Alarm Level

Selector Status

Blower Status

Dosing Status

Runtime Status

Last Update Time

--------------------------------------------------
98. ST_Command
--------------------------------------------------

Source

Command

Priority

Timestamp

Operator

Approved

Executed

Execution Result

--------------------------------------------------
99. ST_RuntimeInfo
--------------------------------------------------

PLC Scan

Current Scan Time

Average Scan

Maximum Scan

Current Memory

CPU Load

Current Queue Size

Mission Index

Software Version

--------------------------------------------------
100. Structure Rules
--------------------------------------------------

Every structure shall contain

Version

Reserved Fields

Expansion Area

--------------------------------------------------

Structures shall remain backward compatible.

Fields shall never be removed.

Deprecated fields shall remain reserved.

--------------------------------------------------
101. Memory Alignment
--------------------------------------------------

Related parameters shall remain grouped.

Mission data

↓

Runtime data

↓

Statistics

↓

Recovery

↓

Reserved

Memory layout shall remain deterministic.

--------------------------------------------------
102. Structure Validation
--------------------------------------------------

Every structure shall support

Initialization

Validation

Reset

Backup

Restore

Version Check

--------------------------------------------------

Invalid structures shall never be used.

--------------------------------------------------
103. Function Block Timing Model
--------------------------------------------------

The Line Manager operates as a cyclic state machine.

Every execution shall complete within one PLC scan.

The following timing rules apply.

Read Inputs

↓

Process Commands

↓

Execute Current State

↓

Evaluate Transitions

↓

Update Child Commands

↓

Update Outputs

↓

Store Runtime Information

↓

End Scan

--------------------------------------------------
104. Internal Timer Management
--------------------------------------------------

Every timer shall belong to exactly one state.

Shared timers are prohibited.

Required Timers

Mission Timer

Validation Timer

Selector Timeout

Selector Settle

Blower Start

PreRun

Feed Delay

Mission Timeout

PostRun

Recovery Delay

Pause Delay

Resume Delay

Communication Timeout

--------------------------------------------------
105. Timer Rules
--------------------------------------------------

A timer may only

Start

Stop

Reset

inside its owning state.

No timer shall be manipulated from another state.

--------------------------------------------------
106. State Entry Template
--------------------------------------------------

Every state shall execute

Entry()

↓

Execute()

↓

Exit()

Example

STATE_PRERUN

Entry

Start PreRun Timer

Execute

Monitor Timer

Exit

Generate Blower Ready

--------------------------------------------------
107. State Exit Validation
--------------------------------------------------

A state shall never transition unless

All mandatory exit conditions are TRUE.

Example

STATE_SELECTOR

Exit Conditions

Selector Ready

No Alarm

Timeout FALSE

Communication Healthy

--------------------------------------------------
108. State Rollback Strategy
--------------------------------------------------

If a state cannot complete

↓

Remain in Current State

or

↓

Go to Alarm State

The software shall never skip a state.

--------------------------------------------------
109. Event Processing
--------------------------------------------------

Every PLC scan processes events.

Priority

Emergency Stop

Critical Alarm

Operator Command

Mission Scheduler

Statistics

Background Tasks

Only one event shall modify the Line Manager state per scan.

--------------------------------------------------
110. Background Tasks
--------------------------------------------------

The following tasks execute independently.

Statistics

Health Calculation

Maintenance Counters

History Buffer

Communication Statistics

Background tasks shall never delay mission execution.

--------------------------------------------------
111. Command Buffer
--------------------------------------------------

Incoming commands shall first enter a command buffer.

Structure

Command ID

Source

Priority

Timestamp

Processed

Result

The Line Manager shall process one command per scan.

--------------------------------------------------
112. Pending Operations
--------------------------------------------------

Long operations shall be split across multiple scans.

Examples

History Save

Database Synchronization

Large Queue Update

Backup Generation

Blocking execution is prohibited.

--------------------------------------------------
113. Queue Execution Model
--------------------------------------------------

Queue processing

Idle

↓

Next Mission

↓

Validation

↓

Execution

↓

Completion

↓

Next Mission

Queue pointer shall always be stored.

--------------------------------------------------
114. Mission Scheduler Interface
--------------------------------------------------

Scheduler provides

Mission ID

Priority

Queue Position

Mission Parameters

Requested Start

Requested Feed

The Line Manager returns

Accepted

Rejected

Busy

Completed

Failed

--------------------------------------------------
115. Runtime Buffer
--------------------------------------------------

Runtime information shall be buffered before storage.

Buffer contains

Mission Snapshot

Current State

Current Feed

Current Timer

Health

Current Alarm

Queue Position

--------------------------------------------------
116. Snapshot System
--------------------------------------------------

Every important event creates a snapshot.

Mission Start

Mission Pause

Mission Resume

Mission Complete

Mission Failure

Emergency Stop

Snapshots allow later diagnostics.

--------------------------------------------------
117. Runtime Consistency Rules
--------------------------------------------------

Mission Progress

0…100 %

Remaining Feed

>= 0

Delivered Feed

<= Target Feed

Mission Timer

>= 0

Queue Index

Valid

Current State

Defined

--------------------------------------------------
118. Safety Override
--------------------------------------------------

Safety Override is active only in

Engineering Service Mode.

Operator Mode

cannot bypass

Emergency Stop

Critical Alarm

Communication Failure

Calibration Errors

--------------------------------------------------
119. Fail Safe Behaviour
--------------------------------------------------

Unexpected software conditions

↓

Mission Pause

↓

Generate Diagnostic Alarm

↓

Store Snapshot

↓

Wait Operator Decision

The software shall always fail safely.

--------------------------------------------------
120. Design Principle
--------------------------------------------------

The Function Block shall behave like an industrial controller.

Never hurry.

Never guess.

Never assume.

Always validate.

Always log.

Always recover whenever possible.

--------------------------------------------------
121. Detailed State Definition
--------------------------------------------------

Every state shall contain

State ID

State Name

Purpose

Entry Conditions

Entry Actions

Runtime Actions

Exit Conditions

Exit Actions

Timeout

Alarm Actions

Recovery Strategy

--------------------------------------------------
122. STATE_READY
--------------------------------------------------

Purpose

System is ready to accept a new mission.

--------------------------------------------------

Entry Conditions

Initialization Complete

No Active Alarm

Communication Healthy

No Emergency Stop

--------------------------------------------------

Entry Actions

Reset temporary variables.

Clear command buffer.

Verify child Function Blocks.

--------------------------------------------------

Runtime Actions

Wait for mission.

Monitor commands.

Monitor communication.

Update diagnostics.

--------------------------------------------------

Exit Conditions

Mission Selected

--------------------------------------------------

Exit Actions

Load Mission

--------------------------------------------------

Timeout

None

--------------------------------------------------
123. STATE_PREPARE
--------------------------------------------------

Purpose

Validate the selected mission.

--------------------------------------------------

Validation

Mission Exists

Mission Enabled

Feed Available

Fish Lot Valid

Cage Valid

Silo Valid

Selector Ready

Blower Ready

Dosing Ready

--------------------------------------------------

Exit

Validation Successful

↓

STATE_SELECTOR

--------------------------------------------------

Failure

↓

STATE_ALARM

--------------------------------------------------
124. STATE_SELECTOR
--------------------------------------------------

Purpose

Move selector to target eye.

--------------------------------------------------

Entry

Calculate Target Position

Calculate Direction

Start Timeout Timer

--------------------------------------------------

Runtime

Monitor

Current Position

Target Position

Analog Signal

Timeout

--------------------------------------------------

Exit

Selector Ready

--------------------------------------------------

Failure

Timeout

↓

STATE_ALARM

--------------------------------------------------
125. STATE_BLOWER
--------------------------------------------------

Purpose

Prepare air transport.

--------------------------------------------------

Entry

Send RUN command.

--------------------------------------------------

Runtime

Monitor

Drive Ready

Actual Frequency

Communication

Fault

--------------------------------------------------

Exit

Target Frequency Reached

--------------------------------------------------
126. STATE_PRERUN
--------------------------------------------------

Purpose

Stabilize air flow.

--------------------------------------------------

Entry

Start PreRun Timer

--------------------------------------------------

Runtime

Monitor Timer

--------------------------------------------------

Exit

Timer Finished

↓

STATE_DOSING

--------------------------------------------------
127. STATE_DOSING
--------------------------------------------------

Purpose

Deliver feed.

--------------------------------------------------

Entry

Reset Pulse Counter

Reset Feed Counter

Start Mission Timer

--------------------------------------------------

Runtime

Read Pulse

↓

Calculate Feed

↓

Update Progress

↓

Update Statistics

↓

Update Runtime Buffer

--------------------------------------------------

Exit

Target Feed Reached

--------------------------------------------------
128. STATE_POSTRUN
--------------------------------------------------

Purpose

Clean transport pipe.

--------------------------------------------------

Entry

Stop Dosing

Start PostRun Timer

--------------------------------------------------

Runtime

Blower continues.

--------------------------------------------------

Exit

Timer Finished

↓

Stop Blower

--------------------------------------------------
129. STATE_COMPLETE
--------------------------------------------------

Purpose

Complete mission safely.

--------------------------------------------------

Actions

Save Mission

Save History

Update Statistics

Update Maintenance

Update Smart Farm

Release Resources

Unlock Queue

--------------------------------------------------

Exit

READY

--------------------------------------------------
130. STATE_PAUSE
--------------------------------------------------

Purpose

Suspend mission without data loss.

--------------------------------------------------

Store

Current State

Current Feed

Mission Timer

Feed Counter

Queue Position

--------------------------------------------------

Resume

↓

STATE_BLOWER

--------------------------------------------------
131. STATE_SERVICE
--------------------------------------------------

Purpose

Allow engineering intervention.

--------------------------------------------------

Allowed

Manual Commands

Calibration

Diagnostics

IO Test

Parameter Edit

--------------------------------------------------

Mission execution disabled.

--------------------------------------------------
132. STATE_ALARM
--------------------------------------------------

Purpose

Protect machine.

--------------------------------------------------

Actions

Stop Dosing

Stop Selector

Execute Blower Strategy

Store Alarm

Store Snapshot

Update Statistics

--------------------------------------------------

Operator Options

Reset

Resume

Cancel Mission

--------------------------------------------------
133. STATE_RECOVERY
--------------------------------------------------

Purpose

Recover after unexpected restart.

--------------------------------------------------

Load Recovery

↓

Verify Hardware

↓

Verify Communication

↓

Verify Mission

↓

Wait Operator

--------------------------------------------------

Operator

Resume

Cancel

--------------------------------------------------
134. State Priority Table
--------------------------------------------------

Highest

Emergency Stop

↓

Critical Alarm

↓

Recovery

↓

Service

↓

Mission Execution

↓

Statistics

↓

Background Tasks

--------------------------------------------------
135. Illegal Transitions
--------------------------------------------------

The following transitions are prohibited.

READY

↓

DOSING

--------------------------------------------------

INITIALIZE

↓

COMPLETE

--------------------------------------------------

ALARM

↓

DOSING

--------------------------------------------------

OFF

↓

POSTRUN

--------------------------------------------------

Undefined transitions

shall generate diagnostic events.

--------------------------------------------------
136. State Transition Delay
--------------------------------------------------

Every transition

takes effect

on next PLC scan.

Immediate multiple transitions

are prohibited.

--------------------------------------------------
137. State Trace Buffer
--------------------------------------------------

Store last

100

state transitions.

Each record contains

Old State

New State

Timestamp

Mission ID

Reason

Operator

--------------------------------------------------
138. Engineering Diagnostics
--------------------------------------------------

Display

Current State

Next State

Transition Reason

Active Timer

Current Mission

Queue Position

Health Score

Last Alarm

--------------------------------------------------
139. Performance Requirement
--------------------------------------------------

Maximum State Processing Time

100 µs

Maximum Transition Evaluation

50 µs

Maximum Diagnostic Update

200 µs

--------------------------------------------------
140. End of State Definition
--------------------------------------------------

The complete state machine shall be deterministic.

Every transition shall be documented.

Every transition shall be testable.

Every transition shall be recoverable.

--------------------------------------------------

--------------------------------------------------
141. Mission Execution Algorithm
--------------------------------------------------

Purpose

Execute every feeding mission safely,
predictably and repeatably.

The execution sequence shall never vary.

--------------------------------------------------
142. Algorithm Overview
--------------------------------------------------

Mission Selected

↓

Mission Validation

↓

Reserve Resources

↓

Move Selector

↓

Verify Selector

↓

Start Blower

↓

Verify Blower

↓

PreRun

↓

Feed Delay

↓

Start Dosing

↓

Feed Monitoring

↓

Verify Target

↓

Stop Dosing

↓

PostRun

↓

Stop Blower

↓

Store Results

↓

Release Resources

↓

Ready

--------------------------------------------------
143. Step 1
Mission Validation
--------------------------------------------------

Verify

Mission Exists

Mission Enabled

Feed Exists

Fish Lot Exists

Cage Exists

Silo Exists

Selector Ready

Blower Ready

Dosing Ready

Communication Healthy

No Emergency Stop

--------------------------------------------------

Failure

↓

Mission Rejected

--------------------------------------------------
144. Step 2
Reserve Resources
--------------------------------------------------

Reserve

Mission

Queue Entry

Selector

Blower

Dosing

Feed Lot

Silo

--------------------------------------------------

Reserved resources shall reject
external modification requests.

--------------------------------------------------
145. Step 3
Move Selector
--------------------------------------------------

Calculate

Target Eye

↓

Read Calibration

↓

Determine Direction

↓

Move

↓

Wait Position

↓

Verify

--------------------------------------------------

Maximum movement time

Configurable

--------------------------------------------------
146. Step 4
Verify Selector
--------------------------------------------------

Verify

Target Position

Tolerance

Stable Analog

No Alarm

--------------------------------------------------

Verification shall remain true
for the complete settle time.

--------------------------------------------------
147. Step 5
Start Blower
--------------------------------------------------

RUN Command

↓

Acceleration

↓

Target Frequency

↓

Ready

--------------------------------------------------

No dosing is allowed before

Blower Ready

--------------------------------------------------
148. Step 6
PreRun
--------------------------------------------------

Purpose

Stabilize airflow.

--------------------------------------------------

Start Timer

↓

Wait

↓

Continue

--------------------------------------------------

Timer configurable.

--------------------------------------------------
149. Step 7
Feed Delay
--------------------------------------------------

Optional.

Purpose

Allow feed to stabilize
before pulse counting.

--------------------------------------------------

Delay configurable.

--------------------------------------------------
150. Step 8
Start Dosing
--------------------------------------------------

Reset

Pulse Counter

Feed Counter

Mission Timer

↓

Start Dosing

--------------------------------------------------

Mission officially starts here.

--------------------------------------------------
151. Step 9
Feed Monitoring
--------------------------------------------------

Every PLC Scan

Read Pulse

↓

Calculate Feed

↓

Update Progress

↓

Update Remaining Feed

↓

Update Statistics

↓

Update Runtime Buffer

--------------------------------------------------
152. Feed Accuracy Verification
--------------------------------------------------

Continuously compare

Calculated Feed

Delivered Feed

Expected Feed

--------------------------------------------------

Difference

>

Tolerance

↓

Warning

--------------------------------------------------

Difference

>>

Tolerance

↓

Pause Mission

--------------------------------------------------
153. Feed Rate Monitoring
--------------------------------------------------

Calculate

Instant Feed Rate

Average Feed Rate

Maximum Feed Rate

Minimum Feed Rate

--------------------------------------------------

Unexpected deviation

↓

Diagnostic Event

--------------------------------------------------
154. Blower Monitoring
--------------------------------------------------

Monitor

Drive Ready

Drive Fault

Frequency

Current

Communication

--------------------------------------------------

Critical Fault

↓

Pause Mission

--------------------------------------------------
155. Selector Monitoring
--------------------------------------------------

Selector shall remain locked.

Unexpected movement

↓

Immediate Alarm

↓

Pause Mission

--------------------------------------------------
156. Dosing Monitoring
--------------------------------------------------

Monitor

Pulse Signal

Motor Status

Feed Counter

Calibration

--------------------------------------------------

Missing Pulse

↓

Alarm

--------------------------------------------------
157. Communication Monitoring
--------------------------------------------------

Monitor

PLC

VFD

Windows

Remote IO

--------------------------------------------------

Loss of communication

↓

Communication Alarm

↓

Pause Mission

--------------------------------------------------
158. Mission Completion Check
--------------------------------------------------

Mission completes only when

Delivered Feed

>=

Target Feed

AND

No Critical Alarm

--------------------------------------------------

Otherwise

Continue Monitoring

--------------------------------------------------
159. Stop Dosing
--------------------------------------------------

Stop Command

↓

Verify Motor Stop

↓

Store Feed Counter

--------------------------------------------------

Failure

↓

Alarm

--------------------------------------------------
160. Continue To PostRun
--------------------------------------------------

After successful dosing stop

↓

Start PostRun

↓

Continue Mission Completion Sequence

--------------------------------------------------

--------------------------------------------------
161. PostRun Algorithm
--------------------------------------------------

Purpose

Completely clear the feed transport pipe.

--------------------------------------------------

Sequence

Stop Dosing

↓

Verify Dosing Stopped

↓

Start PostRun Timer

↓

Keep Blower Running

↓

Timer Finished

↓

Stop Blower

↓

Mission Complete

--------------------------------------------------

PostRun Time

Configurable

Minimum

5 seconds

Maximum

300 seconds

--------------------------------------------------
162. Resource Release
--------------------------------------------------

After successful mission completion

Release

Mission Lock

Queue Lock

Selector Lock

Blower Lock

Dosing Lock

Feed Lot Lock

Silo Lock

--------------------------------------------------

Resources shall be released only once.

--------------------------------------------------
163. Mission History Generation
--------------------------------------------------

Create Mission Record

Mission ID

Mission Number

Farm

Barge

Line

Cage

Fish Lot

Feed Lot

Operator

--------------------------------------------------

Runtime Information

Mission Duration

Feed Delivered

Average Feed Rate

Average Blower Frequency

Average Dosing Speed

Pause Count

Alarm Count

--------------------------------------------------
164. Smart Farm Update Sequence
--------------------------------------------------

Mission Complete

↓

Update Cage Feed

↓

Update Fish Lot Feed

↓

Update Feed Lot Usage

↓

Update Daily Feed

↓

Update Biomass

↓

Update FCR

↓

Update Growth History

↓

Update Reports

--------------------------------------------------
165. Maintenance Counter Update
--------------------------------------------------

Update

Selector Cycles

Blower Runtime

Dosing Runtime

Mission Counter

Feed Counter

--------------------------------------------------

Maintenance values shall be retentive.

--------------------------------------------------
166. Alarm Handling Sequence
--------------------------------------------------

Alarm Detected

↓

Classify Alarm

↓

Store Alarm

↓

Update Alarm History

↓

Notify Line Manager

↓

Determine Severity

↓

Continue

or

Pause

or

Abort Mission

--------------------------------------------------
167. Warning Handling
--------------------------------------------------

Warnings shall not stop production.

Examples

Low Feed Level

Maintenance Due

Communication Delay

Health Score Low

--------------------------------------------------

Warnings shall remain visible until acknowledged.

--------------------------------------------------
168. Critical Alarm Handling
--------------------------------------------------

Critical Alarm

↓

Immediately Stop Dosing

↓

Protect Equipment

↓

Store Snapshot

↓

Store Runtime

↓

Generate Event

↓

Wait Operator

--------------------------------------------------
169. Mission Abort Sequence
--------------------------------------------------

Mission Abort

↓

Stop Dosing

↓

Stop Selector

↓

Execute Blower Strategy

↓

Store Recovery

↓

Store History

↓

Unlock Resources

↓

READY

--------------------------------------------------
170. Operator Commands
--------------------------------------------------

Available Commands

Start

Pause

Resume

Cancel

Skip Mission

Repeat Mission

Move Queue Up

Move Queue Down

Enable Mission

Disable Mission

--------------------------------------------------

Commands shall be validated before execution.

--------------------------------------------------
171. Manual Mode Behaviour
--------------------------------------------------

Scheduler Disabled

↓

Operator Controls Mission

↓

Mission History Still Recorded

↓

Statistics Still Updated

--------------------------------------------------

Manual Mode shall never disable safety.

--------------------------------------------------
172. Automatic Mode Behaviour
--------------------------------------------------

Scheduler Enabled

↓

Automatic Queue Execution

↓

Automatic Mission Loading

↓

Automatic Mission Completion

↓

Wait Next Mission

--------------------------------------------------

Operator may interrupt at any time.

--------------------------------------------------
173. Service Mode Behaviour
--------------------------------------------------

Mission Execution Disabled

↓

Engineering Commands Enabled

↓

Calibration Enabled

↓

IO Test Enabled

↓

Parameter Edit Enabled

--------------------------------------------------

Every service operation shall be logged.

--------------------------------------------------
174. Recovery Behaviour
--------------------------------------------------

Unexpected Restart

↓

Load Recovery Data

↓

Verify Hardware

↓

Verify Parameters

↓

Verify Mission

↓

Operator Decision

Resume

or

Cancel

--------------------------------------------------

Automatic feeding restart prohibited.

--------------------------------------------------
175. Queue Completion Behaviour
--------------------------------------------------

Queue Empty

↓

Store Queue Statistics

↓

Update Dashboard

↓

System READY

↓

Await New Mission

--------------------------------------------------

Queue completion shall generate an informational event.

--------------------------------------------------
176. Idle Behaviour
--------------------------------------------------

While Idle

Monitor Communication

Monitor Alarms

Monitor Maintenance

Monitor Commands

Update Health Score

Update Runtime Statistics

--------------------------------------------------

No machine movement allowed.

--------------------------------------------------
177. Health Score Contribution
--------------------------------------------------

Selector Health

20%

Blower Health

20%

Dosing Health

20%

Communication

20%

Software Diagnostics

20%

--------------------------------------------------

Overall Health Score

0...100%

--------------------------------------------------
178. Health Actions
--------------------------------------------------

100-90

Excellent

--------------------------------------------------

89-75

Normal

--------------------------------------------------

74-60

Attention

--------------------------------------------------

59-40

Maintenance Recommended

--------------------------------------------------

39-0

Critical

--------------------------------------------------

Thresholds configurable.

--------------------------------------------------
179. Background Statistics
--------------------------------------------------

Update

Hourly Feed

Daily Feed

Weekly Feed

Monthly Feed

Mission Average

Feed Average

Alarm Statistics

Runtime Statistics

--------------------------------------------------

Statistics shall never interrupt mission execution.

--------------------------------------------------
180. End Of Mission Algorithm
--------------------------------------------------

Mission execution finishes only after

History Saved

Statistics Updated

Maintenance Updated

Smart Farm Updated

Resources Released

Queue Updated

System Ready

--------------------------------------------------

Only then may the next mission begin.

--------------------------------------------------

--------------------------------------------------
181. Line Manager Pseudocode
--------------------------------------------------

MAIN LOOP

ReadInputs()

↓

ReadCommands()

↓

ReadChildFunctionBlocks()

↓

EvaluateCurrentState()

↓

ExecuteState()

↓

EvaluateTransitions()

↓

UpdateOutputs()

↓

UpdateStatistics()

↓

UpdateRecovery()

↓

EndScan()

--------------------------------------------------
182. MAIN LOOP Rules
--------------------------------------------------

The Main Loop shall execute once per PLC scan.

Execution order shall never change.

Nested execution is prohibited.

Recursive calls are prohibited.

--------------------------------------------------
183. ExecuteState()
--------------------------------------------------

CASE CurrentState OF

OFF

INITIALIZE

READY

WAIT_MISSION

PREPARE

SELECTOR

BLOWER

PRERUN

DOSING

POSTRUN

COMPLETE

PAUSE

SERVICE

RECOVERY

ALARM

END_CASE

--------------------------------------------------
184. STATE_READY()
--------------------------------------------------

Monitor

Commands

↓

Mission Queue

↓

Communication

↓

Health

↓

Alarms

IF MissionAvailable

↓

Transition

STATE_PREPARE

--------------------------------------------------
185. STATE_PREPARE()
--------------------------------------------------

Validation()

IF Validation = TRUE

↓

STATE_SELECTOR

ELSE

↓

STATE_ALARM

--------------------------------------------------
186. STATE_SELECTOR()
--------------------------------------------------

Command

FB_Selector.Move(TargetEye)

↓

IF Selector.Ready

↓

STATE_BLOWER

--------------------------------------------------

IF Selector.Alarm

↓

STATE_ALARM

--------------------------------------------------
187. STATE_BLOWER()
--------------------------------------------------

Command

FB_Blower.Start()

↓

IF Blower.Ready

↓

STATE_PRERUN

--------------------------------------------------

IF Blower.Alarm

↓

STATE_ALARM

--------------------------------------------------
188. STATE_PRERUN()
--------------------------------------------------

Run Timer

↓

IF TimerFinished

↓

STATE_DOSING

--------------------------------------------------
189. STATE_DOSING()
--------------------------------------------------

FB_Dosing.Start()

↓

Loop Every Scan

↓

Read Feed Counter

↓

Calculate Delivered Feed

↓

Update Progress

↓

IF Delivered >= Target

↓

STATE_POSTRUN

--------------------------------------------------

Alarm

↓

STATE_PAUSE

--------------------------------------------------
190. STATE_POSTRUN()
--------------------------------------------------

FB_Dosing.Stop()

↓

Run Blower

↓

PostRun Timer

↓

Stop Blower

↓

STATE_COMPLETE

--------------------------------------------------
191. STATE_COMPLETE()
--------------------------------------------------

History.Save()

↓

Statistics.Update()

↓

SmartFarm.Update()

↓

Maintenance.Update()

↓

Queue.Release()

↓

STATE_READY

--------------------------------------------------
192. STATE_PAUSE()
--------------------------------------------------

Pause Runtime

↓

Save Snapshot

↓

Operator Decision

Resume

↓

STATE_BLOWER

Cancel

↓

STATE_COMPLETE

--------------------------------------------------
193. STATE_SERVICE()
--------------------------------------------------

Mission Disabled

↓

Engineering Access

↓

Calibration

↓

Diagnostics

↓

IO Test

--------------------------------------------------

Return

↓

STATE_READY

--------------------------------------------------
194. STATE_RECOVERY()
--------------------------------------------------

Load Snapshot

↓

Validate

↓

Operator Decision

Resume

↓

STATE_BLOWER

Cancel

↓

STATE_COMPLETE

--------------------------------------------------
195. STATE_ALARM()
--------------------------------------------------

Protect Equipment

↓

Store Alarm

↓

Store Snapshot

↓

Notify Operator

↓

Wait Reset

--------------------------------------------------

Reset

↓

STATE_READY

--------------------------------------------------
196. Transition Function
--------------------------------------------------

Transition()

shall

Store PreviousState

↓

Store NextState

↓

Store Timestamp

↓

Store Transition Reason

↓

Update CurrentState

--------------------------------------------------
197. Command Processing
--------------------------------------------------

Read Command Buffer

↓

Highest Priority Command

↓

Validate

↓

Execute

↓

Log Result

↓

Remove Command

--------------------------------------------------
198. Statistics Update
--------------------------------------------------

Update

Mission Runtime

↓

Feed Delivered

↓

Feed Rate

↓

Average Feed Rate

↓

Machine Runtime

↓

Health Score

--------------------------------------------------
199. Recovery Update
--------------------------------------------------

Every Scan

Store

Current State

Mission Progress

Delivered Feed

Remaining Feed

Current Queue Position

Current Mission

Active Timers

--------------------------------------------------
200. End Of Pseudocode Section
--------------------------------------------------

The pseudocode shall remain implementation independent.

No PLC-specific syntax shall be used.

The pseudocode defines software behaviour only.

--------------------------------------------------

--------------------------------------------------
201. Structured Text Skeleton
--------------------------------------------------

FUNCTION_BLOCK FB_LineManager

VAR_INPUT

END_VAR

VAR_OUTPUT

END_VAR

VAR_IN_OUT

END_VAR

VAR

END_VAR

--------------------------------------------------

Execution

Read Inputs

↓

Process Commands

↓

Execute State Machine

↓

Update Child FB

↓

Update Outputs

↓

Store Runtime

--------------------------------------------------

END_FUNCTION_BLOCK

--------------------------------------------------
202. Internal Execution Regions
--------------------------------------------------

The Function Block shall be divided into logical regions.

Region 1

Input Processing

----------------------------

Region 2

Command Processing

----------------------------

Region 3

State Machine

----------------------------

Region 4

Mission Logic

----------------------------

Region 5

Diagnostics

----------------------------

Region 6

Statistics

----------------------------

Region 7

Recovery

----------------------------

Region 8

Output Processing

--------------------------------------------------

Each region shall have independent documentation.

--------------------------------------------------
203. Input Region
--------------------------------------------------

Responsibilities

Read external inputs.

Validate input values.

Copy inputs into internal variables.

Reject invalid values.

--------------------------------------------------

No calculations allowed.

--------------------------------------------------
204. Command Region
--------------------------------------------------

Responsibilities

Read command buffer.

Determine command priority.

Validate command.

Execute command.

Generate command result.

--------------------------------------------------

Commands shall be processed one at a time.

--------------------------------------------------
205. State Machine Region
--------------------------------------------------

Responsibilities

Execute current state.

Evaluate transitions.

Update next state.

Generate transition log.

--------------------------------------------------

State logic shall never modify hardware directly.

--------------------------------------------------
206. Mission Region
--------------------------------------------------

Responsibilities

Mission validation.

Mission execution.

Mission completion.

Mission cancellation.

Mission recovery.

Queue handling.

--------------------------------------------------

Mission Region owns

Mission Structure.

--------------------------------------------------
207. Child Function Block Region
--------------------------------------------------

Execute

FB_Selector

↓

FB_Blower

↓

FB_Dosing

--------------------------------------------------

Read

Ready

Busy

Alarm

Current State

Health

--------------------------------------------------

Generate

Child Summary

--------------------------------------------------
208. Diagnostics Region
--------------------------------------------------

Monitor

Execution Time

Scan Count

Current State

Mission Status

Command Buffer

Communication

Health Score

--------------------------------------------------

Generate

Diagnostic Snapshot

--------------------------------------------------
209. Statistics Region
--------------------------------------------------

Update

Mission Count

Mission Runtime

Feed Delivered

Feed Rate

Average Runtime

Average Feed

Alarm Statistics

Maintenance Counters

--------------------------------------------------

Statistics shall be buffered.

--------------------------------------------------
210. Recovery Region
--------------------------------------------------

Update

Mission Snapshot

Queue Position

Current State

Timers

Counters

Feed Information

--------------------------------------------------

Recovery shall execute every scan.

--------------------------------------------------
211. Output Region
--------------------------------------------------

Calculate

Ready

Busy

Alarm

Mission Progress

Feed Remaining

Estimated Finish

--------------------------------------------------

Outputs shall be written once per scan.

--------------------------------------------------
212. Function Block Call Order
--------------------------------------------------

FB_SystemManager

↓

FB_CommandManager

↓

FB_LineManager

↓

FB_Selector

↓

FB_Blower

↓

FB_Dosing

↓

FB_AlarmManager

↓

FB_Statistics

↓

FB_HealthMonitor

--------------------------------------------------

Execution order shall remain fixed.

--------------------------------------------------
213. Function Block Return Values
--------------------------------------------------

Every Function Block returns

Ready

Busy

Alarm

State

Health

ErrorCode

--------------------------------------------------

Optional

Warning

Progress

--------------------------------------------------
214. Coding Philosophy
--------------------------------------------------

Readable code.

Predictable execution.

No duplicated logic.

No hidden calculations.

Every calculation documented.

Every transition documented.

--------------------------------------------------
215. Variable Naming Rules
--------------------------------------------------

Boolean

b

Example

bMissionReady

----------------------------

Integer

i

Example

iMissionIndex

----------------------------

Real

r

Example

rFeedRate

----------------------------

Timer

t

Example

tPreRun

----------------------------

Counter

cnt

Example

cntMission

----------------------------

Structure

st

Example

stMission

--------------------------------------------------
216. Comment Standard
--------------------------------------------------

Every region

Purpose

--------------------------------------------------

Every state

Description

--------------------------------------------------

Every calculation

Engineering explanation

--------------------------------------------------

Every alarm

Reason

Operator action

--------------------------------------------------
217. Error Code Convention
--------------------------------------------------

0000

No Error

----------------------------

1000 Series

Mission

----------------------------

2000 Series

Selector

----------------------------

3000 Series

Blower

----------------------------

4000 Series

Dosing

----------------------------

5000 Series

Communication

----------------------------

6000 Series

Recovery

----------------------------

7000 Series

Software

--------------------------------------------------
218. Build Requirements
--------------------------------------------------

Compilation

No warnings.

No duplicate symbols.

No undefined variables.

No unreachable states.

--------------------------------------------------

Every build shall generate

Version

Build Date

Revision

--------------------------------------------------
219. Review Checklist
--------------------------------------------------

Verify

State Machine

Mission Logic

Alarm Logic

Recovery

Statistics

Performance

Documentation

--------------------------------------------------

Every review shall be recorded.

--------------------------------------------------
220. End Of Software Skeleton
--------------------------------------------------

The Function Block architecture is now completely defined.

Implementation shall follow this document without deviation unless approved by engineering.

--------------------------------------------------

--------------------------------------------------
221. Failure Mode and Effects Analysis (FMEA)
--------------------------------------------------

Purpose

Identify possible software failures.

Define preventive actions.

Reduce unexpected behaviour.

--------------------------------------------------
222. Failure Classification
--------------------------------------------------

Category A

Information

No production impact.

----------------------------

Category B

Warning

Production continues.

Operator attention required.

----------------------------

Category C

Alarm

Mission paused.

Operator intervention required.

----------------------------

Category D

Critical

Immediate machine protection.

Mission aborted.

--------------------------------------------------
223. Failure Source Matrix
--------------------------------------------------

Software

Communication

PLC

Drive

Sensor

Operator

Configuration

Power Loss

--------------------------------------------------

Every failure shall belong to exactly one source.

--------------------------------------------------
224. Selector Failure Modes
--------------------------------------------------

Failure

Timeout

Effect

Mission Pause

Recovery

Retry

----------------------------

Failure

Calibration Missing

Effect

Mission Blocked

Recovery

Calibration Required

----------------------------

Failure

Unexpected Position

Effect

Critical Alarm

Recovery

Operator Inspection

--------------------------------------------------
225. Blower Failure Modes
--------------------------------------------------

Failure

Drive Fault

↓

Pause Mission

----------------------------

Failure

Frequency Loss

↓

Pause Mission

----------------------------

Failure

Communication Lost

↓

Pause Mission

----------------------------

Failure

Over Current

↓

Critical Alarm

--------------------------------------------------
226. Dosing Failure Modes
--------------------------------------------------

Pulse Missing

↓

Alarm

----------------------------

Feed Counter Error

↓

Pause Mission

----------------------------

Calibration Error

↓

Mission Blocked

----------------------------

Motor Fault

↓

Critical Alarm

--------------------------------------------------
227. Communication Failure Modes
--------------------------------------------------

PLC Communication Lost

↓

Mission Pause

----------------------------

Drive Offline

↓

Pause Mission

----------------------------

Remote IO Lost

↓

Alarm

----------------------------

Windows Connection Lost

↓

Continue Feeding

↓

Store Offline Events

--------------------------------------------------
228. Mission Failure Modes
--------------------------------------------------

Mission Validation Failed

↓

Reject Mission

----------------------------

Mission Timeout

↓

Pause Mission

----------------------------

Mission Corruption

↓

Abort Mission

↓

Generate Diagnostic Snapshot

--------------------------------------------------
229. Power Failure Behaviour
--------------------------------------------------

Power Loss

↓

Store Recovery Information

↓

Retentive Memory

↓

Shutdown

----------------------------

Power Restore

↓

Recovery Mode

↓

Operator Decision

--------------------------------------------------
230. Recovery Priority
--------------------------------------------------

Highest

Emergency Stop

↓

Critical Alarm

↓

Power Recovery

↓

Communication Recovery

↓

Mission Recovery

↓

Statistics Recovery

--------------------------------------------------
231. Software Exception Rules
--------------------------------------------------

Unexpected Values

↓

Ignore

or

Replace

or

Alarm

Never continue using invalid data.

--------------------------------------------------
232. Invalid Parameter Behaviour
--------------------------------------------------

Parameter Out Of Range

↓

Reject

↓

Restore Previous Value

↓

Generate Warning

--------------------------------------------------
233. Data Corruption
--------------------------------------------------

Checksum Failed

↓

Load Backup

↓

Generate Alarm

↓

Require Engineering Review

--------------------------------------------------
234. Queue Corruption
--------------------------------------------------

Invalid Queue

↓

Stop Scheduler

↓

Preserve Missions

↓

Diagnostic Event

↓

Manual Recovery

--------------------------------------------------
235. Snapshot Recovery
--------------------------------------------------

Load Snapshot

↓

Verify

↓

Restore

↓

Continue

--------------------------------------------------

Incomplete snapshot

↓

Reject Recovery

--------------------------------------------------
236. Recovery Validation
--------------------------------------------------

Before Resume

Verify

Mission

Feed

Silo

Selector

Blower

Dosing

Communication

Safety

--------------------------------------------------

If validation fails

↓

Remain Paused

--------------------------------------------------
237. Alarm Escalation
--------------------------------------------------

Information

↓

Warning

↓

Alarm

↓

Critical

--------------------------------------------------

Escalation shall never skip levels unless safety requires it.

--------------------------------------------------
238. Automatic Recovery Policy
--------------------------------------------------

Automatic Recovery allowed

Communication Glitch

Temporary Drive Timeout

Heartbeat Timeout

--------------------------------------------------

Automatic Recovery prohibited

Emergency Stop

Calibration Error

Motor Protection

Power Recovery

--------------------------------------------------
239. Engineering Diagnostics
--------------------------------------------------

Store

Failure Source

Failure Time

Current State

Mission

Operator

Recovery Action

Result

--------------------------------------------------
240. End Of FMEA Section
--------------------------------------------------

Every identified failure shall have

Cause

Effect

Detection

Recovery

Operator Guidance

Engineering Guidance

--------------------------------------------------

--------------------------------------------------
241. Factory Acceptance Test (FAT)
--------------------------------------------------

Purpose

Verify complete software functionality
before shipment.

--------------------------------------------------

Factory tests shall be performed without fish.

Simulation Mode shall be enabled.

--------------------------------------------------
242. FAT Test Groups
--------------------------------------------------

Group 1

PLC Startup

----------------------------

Group 2

Mission Execution

----------------------------

Group 3

Selector

----------------------------

Group 4

Blower

----------------------------

Group 5

Dosing

----------------------------

Group 6

Alarm

----------------------------

Group 7

Recovery

----------------------------

Group 8

Statistics

--------------------------------------------------
243. FAT-001
PLC Startup
--------------------------------------------------

Expected

No alarms

All parameters loaded

Recovery memory valid

Communication established

Health Score normal

--------------------------------------------------
244. FAT-002
Mission Validation
--------------------------------------------------

Create valid mission.

↓

Mission accepted.

--------------------------------------------------

Create invalid mission.

↓

Mission rejected.

--------------------------------------------------
245. FAT-003
Selector Movement
--------------------------------------------------

Move

Eye 1

↓

Eye 6

↓

Eye 12

↓

Eye 3

--------------------------------------------------

Expected

Correct position.

No timeout.

--------------------------------------------------
246. FAT-004
Blower Test
--------------------------------------------------

Start blower.

↓

Target frequency reached.

↓

PreRun completed.

↓

Stop blower.

--------------------------------------------------

Expected

No alarm.

--------------------------------------------------
247. FAT-005
Dosing Test
--------------------------------------------------

Start dosing.

↓

Generate pulses.

↓

Target reached.

↓

Stop.

--------------------------------------------------

Expected

Calculated feed equals expected feed
within configured tolerance.

--------------------------------------------------
248. FAT-006
Mission Completion
--------------------------------------------------

Mission

↓

Selector

↓

Blower

↓

Dosing

↓

PostRun

↓

History

↓

Statistics

↓

READY

--------------------------------------------------

Every step verified.

--------------------------------------------------
249. FAT-007
Pause / Resume
--------------------------------------------------

Mission Running

↓

Pause

↓

Resume

↓

Mission Complete

--------------------------------------------------

Feed quantity shall remain correct.

--------------------------------------------------
250. FAT-008
Cancel Mission
--------------------------------------------------

Mission Running

↓

Cancel

↓

Safe Stop

↓

History Saved

↓

Queue Updated

--------------------------------------------------

Resources released.

--------------------------------------------------
251. FAT-009
Emergency Stop
--------------------------------------------------

Mission Running

↓

Emergency Stop

↓

Immediate Safe Stop

↓

Snapshot Saved

↓

Recovery Possible

--------------------------------------------------
252. FAT-010
Power Failure
--------------------------------------------------

Mission Running

↓

Power Loss

↓

PLC Restart

↓

Recovery Screen

↓

Resume

or

Cancel

--------------------------------------------------

No mission data lost.

--------------------------------------------------
253. FAT-011
Communication Failure
--------------------------------------------------

Disconnect

Drive

↓

Alarm

↓

Mission Pause

↓

Reconnect

↓

Resume

--------------------------------------------------

No unexpected state transition.

--------------------------------------------------
254. FAT-012
Service Mode
--------------------------------------------------

Enable

Service Mode

↓

IO Test

↓

Calibration

↓

Diagnostics

↓

Disable

--------------------------------------------------

Mission execution prohibited.

--------------------------------------------------
255. FAT-013
Statistics Verification
--------------------------------------------------

Verify

Mission Count

Feed Delivered

Average Feed Rate

Runtime

Alarm Count

Maintenance Counters

--------------------------------------------------

Values shall match runtime.

--------------------------------------------------
256. FAT-014
Health Monitor
--------------------------------------------------

Generate

Communication Delay

↓

Health decreases.

↓

Restore

↓

Health increases.

--------------------------------------------------

Health Score shall update correctly.

--------------------------------------------------
257. FAT-015
Queue Test
--------------------------------------------------

Queue

20 Missions

↓

Execute

↓

Complete

--------------------------------------------------

Queue integrity preserved.

--------------------------------------------------
258. FAT Acceptance Criteria
--------------------------------------------------

Software passes FAT only if

100%

mandatory tests pass.

No critical defects.

No data corruption.

No undefined behaviour.

--------------------------------------------------
259. FAT Documentation
--------------------------------------------------

Record

Test ID

Operator

Engineer

Date

Firmware Version

Software Version

Result

Notes

--------------------------------------------------

Every FAT shall be archived.

--------------------------------------------------
260. End Of FAT Section
--------------------------------------------------

Factory Acceptance Test completed.

Software approved for Site Acceptance Test.

--------------------------------------------------

--------------------------------------------------
271. Commissioning Procedure
--------------------------------------------------

Purpose

Standardize the commissioning process.

Reduce startup time.

Prevent engineering mistakes.

--------------------------------------------------
272. Mechanical Inspection
--------------------------------------------------

Verify

Selector Mounting

Blower Mounting

Dosing Mounting

Gearboxes

Belts

Bearings

Couplings

Fasteners

Safety Covers

--------------------------------------------------

Mechanical inspection required before power-up.

--------------------------------------------------
273. Electrical Inspection
--------------------------------------------------

Verify

Main Supply

Grounding

Motor Rotation

Protection Devices

Emergency Stop Circuit

PLC Wiring

Communication Wiring

Analog Signals

Digital Inputs

Digital Outputs

--------------------------------------------------

Electrical inspection documented.

--------------------------------------------------
274. Communication Inspection
--------------------------------------------------

Verify

PLC

↓

VFD

↓

Remote IO

↓

HMI

↓

Windows Software

--------------------------------------------------

Every device shall respond correctly.

--------------------------------------------------
275. Parameter Loading
--------------------------------------------------

Load

Machine Parameters

Calibration Data

Communication Settings

Mission Parameters

Alarm Limits

Maintenance Settings

--------------------------------------------------

Verify every imported value.

--------------------------------------------------
276. Selector Commissioning
--------------------------------------------------

Home Position

↓

Calibrate Eye Positions

↓

Verify Every Eye

↓

Verify Analog Values

↓

Store Calibration

--------------------------------------------------

Every selector position shall be verified twice.

--------------------------------------------------
277. Blower Commissioning
--------------------------------------------------

Verify

Motor Rotation

Acceleration

Deceleration

Minimum Frequency

Maximum Frequency

Current

Vibration

Noise

--------------------------------------------------

Record commissioning values.

--------------------------------------------------
278. Dosing Commissioning
--------------------------------------------------

Verify

Motor Rotation

Pulse Sensor

Calibration

Feed Accuracy

Kg Per Revolution

--------------------------------------------------

Repeat calibration until
target accuracy is achieved.

--------------------------------------------------
279. Complete System Dry Test
--------------------------------------------------

Execute

Complete Mission

without feed.

Verify

Mission Flow

State Machine

Alarms

Recovery

Statistics

--------------------------------------------------
280. First Feed Test
--------------------------------------------------

Feed

Small Quantity

↓

Measure Actual Feed

↓

Compare

Expected Feed

--------------------------------------------------

Difference shall remain
within configured tolerance.

--------------------------------------------------
281. Long Duration Test
--------------------------------------------------

Run

Continuous Missions

Minimum

8 Hours

--------------------------------------------------

Verify

Stability

Memory

Communication

Statistics

Recovery

--------------------------------------------------
282. Alarm Verification
--------------------------------------------------

Trigger

Selector Alarm

Blower Alarm

Dosing Alarm

Communication Alarm

Emergency Stop

--------------------------------------------------

Expected response documented.

--------------------------------------------------
283. Recovery Verification
--------------------------------------------------

Simulate

Power Loss

↓

Restart

↓

Recovery Screen

↓

Resume

--------------------------------------------------

Verify mission integrity.

--------------------------------------------------
284. Commissioning Report
--------------------------------------------------

Store

Machine Information

Customer

Engineer

Software Version

PLC Version

Drive Version

Calibration Values

Notes

--------------------------------------------------

Report exported as PDF.

--------------------------------------------------
285. Commissioning Approval
--------------------------------------------------

Approval required from

Customer

Commissioning Engineer

Project Manager

--------------------------------------------------

Commissioning complete.

--------------------------------------------------

--------------------------------------------------
301. Software Performance Verification
--------------------------------------------------

Purpose

Verify that software performance
meets engineering targets.

--------------------------------------------------

Measurements

PLC Scan Time

Mission Response Time

Selector Position Time

Blower Startup Time

Mission Completion Time

Recovery Time

--------------------------------------------------

Every measurement shall be recorded.

--------------------------------------------------
302. Performance Limits
--------------------------------------------------

Maximum PLC Scan

20 ms

----------------------------

Average PLC Scan

5 ms

----------------------------

Maximum Mission Validation

100 ms

----------------------------

Maximum Queue Update

50 ms

----------------------------

Maximum State Transition

1 PLC Scan

--------------------------------------------------

Limits configurable by engineering.

--------------------------------------------------
303. Memory Verification
--------------------------------------------------

Monitor

Total Memory

Free Memory

Retentive Memory

Runtime Memory

Reserved Memory

--------------------------------------------------

Memory fragmentation shall not occur.

--------------------------------------------------
304. CPU Utilization
--------------------------------------------------

Monitor

Current CPU Load

Average CPU Load

Maximum CPU Load

--------------------------------------------------

Warning

80 %

Critical

95 %

--------------------------------------------------
305. Communication Performance
--------------------------------------------------

Measure

Modbus Response

Retry Count

Timeout Count

Packet Loss

--------------------------------------------------

Communication Quality

Excellent

Good

Warning

Critical

--------------------------------------------------
306. Mission Performance
--------------------------------------------------

Measure

Mission Preparation

Selector Position

Blower Start

PreRun

Feed Time

PostRun

Mission Save

--------------------------------------------------

Every mission shall generate
performance statistics.

--------------------------------------------------
307. Queue Performance
--------------------------------------------------

Measure

Insert Time

Delete Time

Sort Time

Mission Selection

Queue Restore

--------------------------------------------------

Performance independent
of queue size.

--------------------------------------------------
308. Recovery Performance
--------------------------------------------------

Measure

PLC Restart

Recovery Load

Validation

Resume Time

--------------------------------------------------

Target

Complete recovery

under

30 seconds.

--------------------------------------------------
309. Software Benchmark
--------------------------------------------------

Test

100 Missions

↓

500 Missions

↓

1000 Missions

↓

5000 Missions

--------------------------------------------------

Software behaviour
shall remain deterministic.

--------------------------------------------------
310. Performance Report
--------------------------------------------------

Generate

Daily

Weekly

Monthly

Engineering Reports

--------------------------------------------------

Reports shall include trends.

--------------------------------------------------

End Of Section