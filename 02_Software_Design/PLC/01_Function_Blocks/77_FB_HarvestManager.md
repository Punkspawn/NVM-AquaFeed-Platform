001. Document Header

Document Name

FB_HarvestManager

Document ID

AQ-FB-077

Version

2.0

Status

Software Design

Runtime

AquaCore

Related Documents

57_FB_LineManager

58_FB_Selector

59_FB_Blower

60_FB_Dosing

61_FB_AlarmManager

62_FB_RecoveryManager

63_FB_HealthMonitor

64_FB_DataLogger

65_FB_DatabaseSync

66_FB_ReportManager

67_FB_BackupManager

68_FB_UserManager

69_FB_Scheduler

70_FB_RecipeManager

71_FB_FeedProgramManager

72_FB_BiomassManager

73_FB_CageManager

74_FB_GrowthManager

75_FB_FCRManager

76_FB_MortalityManager

85_Software_Architecture

1. Purpose

FB_HarvestManager

is responsible for

Harvest Planning

Harvest Readiness

Production Optimization

Harvest Scheduling

Yield Estimation

inside

the AquaFeed Platform.

Harvest calculations

shall never interrupt

real-time feeding.

2. Responsibilities

Harvest Planning

Readiness Evaluation

Yield Estimation

Revenue Prediction

Harvest Scheduling

Harvest Optimization

Historical Tracking

3. Scope

Current System

Single PLC

Single Farm

Single Harvest Database

Future

Multiple PLC

Multiple Farms

Cloud Harvest Database

Fleet Synchronization

Architecture unchanged.

4. Managed Objects

Harvest Records

Harvest Plans

Harvest Schedules

Harvest Reports

Revenue Forecasts

Historical Records

5. Harvest Record Types

Manual Record

Automatic Record

Scheduled Record

Planned Record

Historical Record

Correction Record

Record types

configurable.

6. Inputs

Growth Manager

Biomass Manager

FCR Manager

Mortality Manager

Scheduler Requests

Engineering Changes

7. Outputs

Harvest Readiness

Estimated Yield

Estimated Revenue

Harvest Status

Harvest Health

8. Internal Variables

Harvest Score

Estimated Biomass

Estimated Revenue

Harvest Date

Profit Index

Health Score

9. Parameters

Target Weight

Harvest Tolerance

Minimum Profit

Harvest Interval

Automatic Planning Enable

Engineering configurable.

10. Engineering Philosophy

FB_HarvestManager

never performs

motor control

or

feeding control.

It only

calculates,

analyzes,

plans,

stores,

and distributes

harvest information.

11. Harvest Rules

Every Harvest Record

shall contain

Record ID

Cage ID

Species

Estimated Biomass

Target Weight

Mandatory fields only.

12. Harvest Lifecycle

Create Plan

↓

Validate

↓

Calculate

↓

Optimize

↓

Store

↓

Archive

Every stage verified.

13. Ownership

Engineering

owns

Harvest Models.

Operator

owns

Harvest Plans.

FB_HarvestManager

owns

Validation

Calculation

Optimization

History.

14. Record Priority

Emergency

↓

Validated

↓

Planned

↓

Draft

↓

Archived

Priority configurable.

15. Data Integrity

Every Harvest Record

contains

Timestamp

CRC

Record Identifier

Calculation Version

Integrity verified.

16. Timestamp Policy

Store

Creation Time

Planning Time

Optimization Time

Approval Time

Archive Time

Immutable.

17. Record Identification

Format

HAR-XXXXXX

Example

HAR-000001

HAR-015248

HAR-998742

Unique IDs required.

18. Storage Locations

Runtime Data

RAM

Harvest Database

SQL

Harvest Archive

Long-Term Storage

Cloud Repository

Future Support.

19. Processing Queue

Harvest requests

processed according to

Priority

↓

Validation Status

↓

Request Order

Deterministic execution.

20. End Of Introduction

FB_HarvestManager

shall become

the central authority

for

harvest planning,

production optimization,

yield estimation,

and harvest scheduling

inside

NVM AquaFeed Platform.

21. State Machine Overview

The Harvest Manager

shall operate

using

a deterministic

state machine.

Only one primary state

may execute

per PLC scan.

22. STATE_OFF

Purpose

Harvest Manager Disabled.

Actions

Maintain Configuration

Preserve Active Plans

Monitor Enable Signal

Exit

Enable = TRUE

↓

INITIALIZE

23. STATE_INITIALIZE

Purpose

Initialize

Harvest Manager.

Actions

Load Harvest Database

Load Harvest Plans

Load Revenue Models

Load Scheduling Profiles

Initialize Runtime Variables

Exit

Initialization Complete

↓

READY

24. STATE_READY

Purpose

Waiting

for

Harvest Request.

Actions

Monitor

Growth Updates

Biomass Updates

FCR Updates

Mortality Updates

Engineering Requests

Exit

New Request

↓

VALIDATE

25. STATE_VALIDATE

Purpose

Validate

Harvest Plan.

Verify

Cage ID

Species

Estimated Biomass

Target Weight

Planning Parameters

Validation Passed

↓

CALCULATE

Validation Failed

↓

FAULT

26. STATE_CALCULATE

Purpose

Calculate

Harvest Data.

Actions

Calculate Harvest Date

Calculate Harvest Biomass

Calculate Harvest Revenue

Calculate Harvest Readiness

Calculation Complete

↓

OPTIMIZE

27. STATE_OPTIMIZE

Purpose

Optimize

Harvest Plan.

Actions

Optimize Harvest Sequence

Optimize Revenue

Optimize Cage Utilization

Optimize Production Capacity

Optimization Complete

↓

STORE

28. STATE_STORE

Purpose

Store

Validated

Harvest Plan.

Storage Successful

↓

VERIFY

Storage Failed

↓

FAULT

29. STATE_VERIFY

Purpose

Verify

Stored Plan.

Actions

Check Database

Verify CRC

Verify Calculations

Confirm Storage

Verification Complete

↓

ACTIVE

Verification Failed

↓

FAULT

30. STATE_ACTIVE

Purpose

Maintain

Current Harvest Plan.

Actions

Monitor Readiness

Monitor Profitability

Monitor Capacity

Collect Statistics

New Request

↓

VALIDATE

31. STATE_FAULT

Purpose

Harvest Management Failure.

Actions

Generate Alarm

Store Diagnostics

Reject Invalid Data

Protect Last Valid Plan

Engineering Reset

required

for critical faults.

32. State Transition Rules

READY

↓

VALIDATE

New Harvest Request

----------------------------

VALIDATE

↓

CALCULATE

Validation Passed

----------------------------

CALCULATE

↓

OPTIMIZE

Calculation Complete

----------------------------

OPTIMIZE

↓

STORE

Optimization Complete

----------------------------

STORE

↓

VERIFY

Storage Successful

----------------------------

VERIFY

↓

ACTIVE

Verification Passed

33. Illegal Transitions

OFF

↓

ACTIVE

Not Allowed

----------------------------

READY

↓

STORE

Without Validation

Not Allowed

----------------------------

FAULT

↓

ACTIVE

Without Reset

Not Allowed

Undefined transitions

prohibited.

34. Validation Rules

Verify

Target Weight

Estimated Biomass

Growth Status

FCR Status

Mortality Status

Validation mandatory.

35. Calculation Validation

Verify

Harvest Date

Estimated Yield

Expected Revenue

Readiness Score

Profit Index

Calculation integrity

verified.

36. Runtime Behaviour

Every PLC Scan

Monitor Requests

↓

Validate Data

↓

Calculate Harvest

↓

Optimize Plan

↓

Update Statistics

Harvest calculations

shall never block

feeding control.

37. Harvest Monitoring

Monitor

Harvest Readiness

Estimated Yield

Expected Revenue

Profitability

Harvest Health

Updated continuously.

38. Automatic Optimization

Trigger

Growth Update

↓

Biomass Update

↓

FCR Update

↓

Mortality Update

↓

Harvest Optimization

Optimization policy

configurable.

39. Harvest Health

Monitor

Calculation Integrity

Database Integrity

Optimization Accuracy

Validation Status

Synchronization Status

Generate

Harvest Health Score.

40. End Of State Machine

FB_HarvestManager

shall provide

Reliable

Deterministic

Validated

Traceable

Harvest management.

41. Harvest Processing Algorithm

Purpose

Receive

Validate

Calculate

Optimize

Store

harvest plans

deterministically.

Algorithm

Receive Harvest Request

↓

Validate Data

↓

Calculate Harvest Readiness

↓

Estimate Harvest Yield

↓

Estimate Revenue

↓

Optimize Harvest Window

↓

Store Plan

↓

Verify

↓

Update Statistics

42. Harvest Request Reception

Receive

Operator Request

Automatic Planning

Growth Update

Production Schedule

Engineering Request

Executed

per request.

43. Harvest Validation

Verify

Cage ID

Species

Current Biomass

Target Weight

Production Status

Invalid requests

rejected.

44. Harvest Record Identification

Assign

Record ID

Planning ID

Optimization ID

Timestamp

Identifiers

never reused.

45. Harvest Readiness Calculation

Calculate

Current Average Weight

↓

Target Weight

↓

Growth Progress

↓

Harvest Readiness Score

Displayed

0...100%.

46. Harvest Yield Calculation

Calculate

Current Biomass

-

Expected Mortality

↓

Expected Harvest Biomass

↓

Harvest Yield

Calculation verified.

47. Revenue Estimation

Calculate

Expected Harvest Biomass

×

Market Price

↓

Gross Revenue

↓

Production Cost

↓

Estimated Profit

Calculation verified.

48. Harvest Window Optimization

Calculate

Earliest Harvest Date

↓

Optimal Harvest Date

↓

Latest Harvest Date

↓

Profitability Window

↓

Recommended Date

Optimization verified.

49. Archive Processing

Store

Harvest History

↓

Revenue History

↓

Optimization History

↓

Archive

Archive immutable.

50. Record Retrieval

Search

Record ID

Cage ID

Species

Harvest Date

Planning Version

Indexed lookup.

51. Duplicate Plan Detection

Compare

Harvest Date

Cage ID

Target Weight

Planning Version

Duplicate plans

handled according to

engineering policy.

52. Profitability Verification

Verify

Revenue

Production Cost

Feed Cost

Net Profit

Profit Margin

Consistency required.

53. Automatic Planning

Determine

Growth Status

↓

Biomass Status

↓

FCR Status

↓

Mortality Status

↓

Harvest Readiness

↓

Generate Plan

Planning policy

configurable.

54. Consistency Verification

Verify

Harvest Plans

Growth Records

Biomass Records

FCR Records

Mortality Records

Consistency validation

mandatory.

55. Harvest Monitoring

Monitor

Harvest Readiness

Yield Forecast

Profit Forecast

Optimal Window

Harvest Health

Threshold alarms

supported.

56. Performance Measurement

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Verification Time

Statistics retained.

57. Harvest History

Store

Plan Created

Calculation Completed

Optimization Completed

Plan Verified

Plan Archived

History immutable.

58. Harvest Statistics

Update

Created Plans

Validated Plans

Optimized Plans

Executed Plans

Archived Plans

Retentive memory.

59. Runtime Monitoring

Monitor

Planning State

Optimization State

Validation State

Storage State

Health State

Updated

continuously.

60. End Of Harvest Algorithm

Harvest operations

shall remain

Reliable

Deterministic

Validated

Traceable

Scalable.

61. Harvest Alarm Management

Purpose

Detect

Report

Store

all harvest-related

alarms.

Harvest alarms

integrated with

FB_AlarmManager.

62. HAR001

Harvest Validation Failure

Cause

Missing Cage ID

Missing Biomass

Invalid Target Weight

Reaction

Reject Plan

Generate Alarm

63. HAR002

Harvest Readiness Below Target

Cause

Harvest Readiness

<

Configured Threshold

Reaction

Generate Warning

Notify Operator

64. HAR003

Target Weight Not Reached

Cause

Average Weight

<

Configured Target

Reaction

Generate Warning

Recommend Delayed Harvest

65. HAR004

Critical Profit Loss

Cause

Estimated Profit

<

Configured Minimum

Reaction

Generate Critical Alarm

Notify Management

66. HAR005

Harvest Window Expired

Cause

Current Date

>

Latest Harvest Date

Reaction

Generate Warning

Require Engineering Review

67. HAR006

Production Capacity Exceeded

Cause

Planned Harvest

>

Available Capacity

Reaction

Generate Alarm

Reschedule Harvest

68. HAR007

Estimated Yield Deviation

Cause

Estimated Yield

Outside

Configured Tolerance

Reaction

Generate Alarm

Require Verification

69. HAR008

Database Synchronization Failure

Cause

SQL Offline

Communication Timeout

Write Failure

Reaction

Retry Synchronization

Generate Alarm

70. HAR009

Optimization Failure

Cause

Optimization Engine Error

Missing Parameters

Calculation Failure

Reaction

Abort Optimization

Generate Alarm

71. HAR010

Harvest Manager

Internal Fault

Cause

Unexpected Runtime Error

Memory Corruption

Internal Exception

Reaction

Safe State

Generate Critical Alarm

72. Alarm Reset Rules

Harvest alarms

may reset only after

Cause Removed

↓

Validation Passed

↓

Authorized Reset

Automatic reset

configurable.

73. Harvest Alarm History

Store

Alarm Code

Timestamp

Record ID

Severity

Engineer

Resolution

Permanent history.

74. Harvest Alarm Statistics

Store

Validation Failures

Optimization Failures

Critical Profit Events

Synchronization Failures

Capacity Violations

Retentive memory.

75. Alarm Escalation

Repeated Harvest Events

↓

Increase Severity

↓

Engineering Notification

↓

Management Notification

Escalation configurable.

76. Root Cause Correlation

Link

Growth Trend

↓

FCR Trend

↓

Mortality Trend

↓

Harvest Plan

↓

Production Schedule

Display

Probable Root Cause.

77. Operator Guidance

Display

Alarm Description

Possible Cause

Recommended Action

Expected Impact

Simple language required.

78. Engineering Guidance

Display

Harvest Status

Optimization Status

Yield Status

Profit Status

Database Status

Engineering only.

79. Harvest Health Score

Calculate

Harvest Reliability

using

Validation Success

Optimization Success

Synchronization Success

Integrity Score

Display

0...100%

80. End Of Harvest Alarm Section

Every harvest alarm

shall be

Detectable

Traceable

Recoverable

Documented

81. Communication Philosophy

Purpose

Provide deterministic

communication

between

FB_HarvestManager

and all software modules.

Every harvest plan

shall guarantee

Correct Synchronization

Reliable Storage

Traceability

Planning Consistency

82. Communication Interfaces

Receive

FB_LineManager

FB_Selector

FB_Blower

FB_Dosing

FB_AlarmManager

FB_RecoveryManager

FB_HealthMonitor

FB_DataLogger

FB_DatabaseSync

FB_ReportManager

FB_BackupManager

FB_UserManager

FB_Scheduler

FB_RecipeManager

FB_FeedProgramManager

FB_BiomassManager

FB_GrowthManager

FB_FCRManager

FB_MortalityManager

FB_CageManager

Publish

Windows Software

SQL Database

Harvest Repository

Future Cloud Library

83. Harvest Request Reception

Receive

Operator Request

↓

Automatic Planning

↓

Growth Update

↓

Production Schedule

↓

Engineering Request

Reception verified.

84. Harvest Status Publication

Publish

Harvest Readiness

Estimated Yield

Estimated Revenue

Harvest Status

Harvest Health

Updated

continuously.

85. Communication Validation

Verify

Source Module

Timestamp

Record ID

Planning Version

Authorization Token

Invalid request

↓

Rejected.

86. Heartbeat Monitoring

Monitor

PLC

↓

Windows Software

↓

SQL Database

↓

Harvest Repository

↓

Cloud Library

Heartbeat Timeout

↓

Harvest Warning.

87. Harvest Synchronization

Synchronize

Harvest Database

↓

Growth Database

↓

Biomass Database

↓

FCR Database

↓

Mortality Database

↓

Engineering Database

Synchronization verified.

88. Automatic Cross Module Update

Validated Harvest Plan

↓

Update Scheduler

↓

Update ReportManager

↓

Update DataLogger

↓

Update Windows Software

↓

Notify AI Engine

Execution order

mandatory.

89. Harvest Confirmation

Target Modules

↓

Plan Stored

↓

Optimization Verified

↓

Synchronization Confirmed

Confirmation stored.

90. Harvest Cancellation

Every cancellation

shall receive

Confirmation

↓

Reason

↓

Audit Record

↓

Affected Modules

Cancellation retained.

91. Harvest Interface

Publish

Harvest Date

Estimated Biomass

Estimated Yield

Estimated Revenue

Readiness Score

Updated continuously.

92. Configuration Interface

Download

Harvest Parameters

Planning Rules

Optimization Limits

Alarm Limits

Calculation Parameters

Configuration validated.

93. Runtime Interface

Publish

Planning State

Optimization State

Storage State

Synchronization State

Health State

Real-time update.

94. Database Interface

Read

Harvest Records

Planning History

Revenue History

Historical Records

Configuration

Read-only access.

95. Cloud Interface

Reserved

Cloud Harvest Database

Fleet Harvest Planning

Central Analytics

AI Harvest Optimization

Future implementation.

96. Communication Security

Authentication required

for

Plan Creation

Parameter Modification

Optimization Rules

Database Synchronization

Every action logged.

97. Communication Performance

Measure

Validation Time

Calculation Time

Optimization Time

Synchronization Time

Database Response

Performance trend stored.

98. Cross Module Consistency

Verify

Harvest Plans

↓

Growth Records

↓

Biomass Records

↓

FCR Records

↓

Mortality Records

↓

Production Schedule

Consistency verified.

99. Planning Notification

Publish

Harvest Plan

↓

Production Planning

↓

Logistics Planning

↓

Processing Schedule

↓

Management Dashboard

Validated notifications

only.

100. End Of Communication Section

Harvest communication

shall remain

Reliable

Deterministic

Secure

Traceable

Scalable

101. Runtime Monitoring

Purpose

Continuously monitor

FB_HarvestManager

performance

and harvest planning integrity.

Monitoring executed

continuously.

102. Runtime Variables

Monitor

Planning State

Calculation State

Optimization State

Validation State

Harvest Health

Profitability Status

Updated continuously.

103. Active Harvest Monitor

Display

Harvest Readiness

Target Weight

Estimated Yield

Estimated Revenue

Optimal Harvest Date

Real-time update.

104. Validation Monitor

Display

Validation Queue

Validated Plans

Rejected Plans

Pending Plans

Validation Time

Updated continuously.

105. Harvest Readiness Monitor

Display

Current Weight

Target Weight

Growth Progress

Readiness Score

Remaining Days

Continuous monitoring.

106. Yield Forecast Monitor

Display

Estimated Biomass

Estimated Yield

Expected Harvest Weight

Expected Fish Count

Harvest Confidence

Engineering display.

107. Revenue Monitor

Display

Expected Revenue

Estimated Feed Cost

Estimated Operating Cost

Estimated Net Profit

Profit Margin

Updated continuously.

108. Performance Measurement

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Verification Time

Performance trend stored.

109. Communication Monitor

Display

PLC Connection

Windows Software

SQL Database

Harvest Repository

Cloud Library

Updated automatically.

110. Harvest History

Display

Created Plans

Validated Plans

Optimized Plans

Executed Plans

Archived Plans

Engineering only.

111. Prediction Monitor

Display

Estimated Harvest Date

Remaining Growth

Expected Biomass

Expected Revenue

Planning Confidence

Warning before limits.

112. Calculation Accuracy

Calculate

Successful Calculations

/

Calculation Requests

Displayed

as percentage.

113. Runtime Capacity

Monitor

RAM Usage

Calculation Buffer

Optimization Buffer

Database Capacity

History Buffer

Threshold alarms

supported.

114. Harvest Trend

Generate

Daily Trend

Weekly Trend

Monthly Trend

Seasonal Trend

Production Trend

Trend graphs supported.

115. Harvest Statistics

Display

Manual Plans

Automatic Plans

Optimized Plans

Executed Plans

Historical Plans

Updated automatically.

116. Availability Monitor

Calculate

Planning Availability

Database Availability

Synchronization Availability

Optimization Availability

Displayed

as KPI.

117. Runtime Snapshot

Store

Planning State

Optimization Status

Performance Status

Health Status

Timestamp

Automatic snapshots.

118. Runtime Dashboard

Display

Harvest Readiness

Estimated Yield

Estimated Revenue

Profit Index

Harvest Health

Refresh

Continuously.

119. Engineering Dashboard

Display

Harvest KPI

Yield KPI

Revenue KPI

Profit KPI

Reliability KPI

Engineering access only.

120. End Of Runtime Monitoring

FB_HarvestManager

shall continuously monitor

harvest planning,

yield estimation,

profitability,

and calculation integrity.

121. Service Mode Philosophy

Purpose

Provide engineering tools

for

Harvest Administration

Harvest Planning

Profit Analysis

Production Optimization

Capacity Planning

Service functions

shall never

modify

runtime feeding logic.

122. Access Levels

Operator

View Harvest Plans

View Readiness

----------------------------

Supervisor

Manage Harvest Plans

View History

----------------------------

Service

Diagnostics

Planning Analysis

Optimization Review

----------------------------

Engineering

Full Harvest Control

All actions

stored permanently.

123. Authentication

Required

Username

Password

Access Level

Timestamp

Future Support

LDAP

Single Sign-On

Two Factor Authentication

124. Harvest Dashboard

Display

Harvest Readiness

Estimated Yield

Estimated Revenue

Profit Index

Harvest Health

Refresh

Continuously.

125. Harvest Viewer

Display

Record ID

Cage ID

Species

Harvest Date

Planning Version

Advanced filtering

supported.

126. Planning Viewer

Display

Harvest Window

Priority

Expected Yield

Expected Revenue

Estimated Profit

Read Only.

127. Harvest Timeline

Display

Plan Created

↓

Validated

↓

Calculated

↓

Optimized

↓

Stored

↓

Executed

↓

Archived

Timeline generated

automatically.

128. Harvest History

Display

Created Plans

Validated Plans

Optimized Plans

Executed Plans

Archived Plans

Search supported.

129. Manual Harvest Management

Engineering may

Create Plan

Modify Plan

Duplicate Plan

Archive Plan

Every action logged.

130. Manual Verification

Engineering may

Verify

Harvest Plans

Yield Estimates

Revenue Estimates

Profit Estimates

Database Consistency

Verification logged.

131. Manual Recalculation

Engineering may

Recalculate

Harvest Readiness

Estimated Yield

Estimated Revenue

Profit Index

Harvest Window

Recalculation history

stored permanently.

132. Harvest Simulation

Engineering may simulate

Earlier Harvest

Delayed Harvest

Price Changes

Growth Changes

Mortality Impact

Simulation Mode

clearly indicated.

133. Performance Test

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Results archived.

134. Communication Test

Verify

Target Modules

SQL Database

Harvest Repository

Cloud Library

Communication report

generated.

135. Integrity Test

Verify

Harvest Database

Planning History

Revenue History

Archive Integrity

Calculation Parameters

Integrity report

generated.

136. Harvest Wizard

Step 1

Create Plan

↓

Step 2

Select Cage

↓

Step 3

Review Growth Data

↓

Step 4

Calculate Harvest Plan

↓

Step 5

Review Optimization

↓

Step 6

Approve

↓

Step 7

Store

Wizard guided.

137. Diagnostic Report

Generate

Harvest Report

Yield Report

Revenue Report

Profit Report

Optimization Report

Export

PDF

CSV

ZIP

138. Service Activity Log

Store

Engineer

Timestamp

Action

Previous State

New State

Reason

Permanent audit trail.

139. Engineering Dashboard

Display

Harvest KPI

Yield KPI

Revenue KPI

Capacity KPI

Reliability KPI

Engineering only.

140. End Of Service Section

FB_HarvestManager

shall provide

complete engineering

visibility,

harvest diagnostics,

planning optimization,

profit analysis,

and capacity management

without affecting

runtime operation.

141. Harvest Configuration Philosophy

Purpose

Provide flexible

Engineering Configuration

without software modification.

All harvest behaviour

shall be

parameter driven.

142. Harvest Definitions

Every Harvest Plan

shall contain

Record ID

Cage ID

Species

Target Weight

Target Harvest Date

Definition immutable

after validation.

143. Harvest Target Configuration

Engineering may configure

Target Weight

Harvest Tolerance

Minimum Yield

Minimum Revenue

Minimum Profit Margin

Changes

logged permanently.

144. Revenue Configuration

Configure

Market Price

Currency

Operating Cost

Processing Cost

Transportation Cost

Engineering configurable.

145. Yield Configuration

Configure

Target Biomass

Harvest Yield

Yield Tolerance

Correction Factor

Confidence Level

Calculation rules

parameter driven.

146. Capacity Configuration

Configure

Daily Harvest Capacity

Processing Capacity

Transport Capacity

Storage Capacity

Loading Capacity

Individually configurable.

147. Species Configuration

Configure

Species Name

Target Weight

Harvest Window

Growth Profile

Market Category

Selection profile

configurable.

148. Optimization Policies

Configure

Revenue Priority

Yield Priority

Capacity Priority

Delivery Priority

Profit Strategy

Engineering selectable.

149. Validation Policies

Policies

Engineering Review

Production Review

Harvest Approval

Revenue Approval

Emergency Override

Policy versioned.

150. Harvest Update Policy

Update allowed only after

Growth Validation

↓

Biomass Validation

↓

Planning Verification

↓

Storage Confirmation

Mandatory sequence.

151. Harvest Profiles

Profile includes

Species

Harvest Targets

Revenue Targets

Yield Targets

Capacity Rules

Reusable profiles

supported.

152. Language Support

Harvest Interface

supports

Turkish

English

Future languages

supported.

153. Production Categories

Nursery

Grow-Out

Broodstock

Harvest

Processing

Emergency

Configurable mapping.

154. Notification Policy

Notify

Operator

↓

Production Supervisor

↓

Engineering

↓

Management

↓

Customer System

Escalation configurable.

155. Automatic Planning Policy

Automatic planning

based on

Growth Status

↓

Harvest Readiness

↓

Capacity

↓

Profitability

↓

Production Schedule

Policy configurable.

156. Harvest Change Policy

Harvest modification

requires

Version Increment

↓

Validation

↓

Verification

↓

Storage

Change policy

configurable.

157. Future Integration

Reserved

Cloud Harvest Database

AI Harvest Planning

Fleet Harvest Coordination

Digital Twin

Future implementation.

158. Configuration Backup

Backup

Harvest Profiles

Revenue Parameters

Capacity Rules

Validation Rules

Calculation Parameters

Checksum verified.

159. Configuration Audit

Every modification

stores

Engineer

Timestamp

Previous Value

New Value

Reason

Permanent audit history.

160. End Of Configuration Section

Harvest configuration

shall remain

Flexible

Traceable

Version Controlled

Backward Compatible

161. Harvest Statistics Philosophy

Purpose

Collect meaningful

harvest statistics

for

Engineering

Production

Financial Analysis

Optimization

Statistics updated

automatically.

162. Overall Harvest Statistics

Store

Total Harvest Plans

Validated Plans

Optimized Plans

Executed Plans

Archived Plans

Retentive memory.

163. Daily Statistics

Store

Daily Harvest

Daily Harvest Biomass

Daily Revenue

Daily Profit

Daily Readiness

Reset

Every Day

00:00

164. Weekly Statistics

Store

Weekly Harvest

Weekly Biomass

Weekly Revenue

Weekly Profit

Weekly Capacity Usage

Archived automatically.

165. Monthly Statistics

Store

Monthly Harvest

Monthly Biomass

Monthly Revenue

Monthly Profit

Monthly Optimization Score

Permanent retention.

166. Lifetime Statistics

Store

Lifetime Harvest

Lifetime Biomass

Lifetime Revenue

Lifetime Profit

Lifetime Yield

Retentive memory.

167. Species Statistics

Separate statistics

for

Sea Bass

Sea Bream

Trout

Salmon

Custom Species

Displayed independently.

168. Yield Statistics

Store

Average Yield

Maximum Yield

Minimum Yield

Yield Deviation

Yield Accuracy

Trend retained.

169. Revenue Statistics

Store

Daily Revenue

Weekly Revenue

Monthly Revenue

Lifetime Revenue

Average Revenue

Updated automatically.

170. Profit Statistics

Calculate

Daily Profit

Weekly Profit

Monthly Profit

Lifetime Profit

Average Profit

Displayed

to engineering.

171. Harvest Readiness Statistics

Store

Average Readiness

Minimum Readiness

Maximum Readiness

Readiness Accuracy

Target Compliance

Engineering reports.

172. Availability Statistics

Calculate

Planning Availability

Database Availability

Synchronization Availability

Optimization Availability

Displayed as KPI.

173. Reliability Statistics

Calculate

MTBF

MTTR

Planning Reliability

Database Reliability

Synchronization Reliability

Updated automatically.

174. Performance Indicators

Calculate

Average Validation Time

Average Calculation Time

Average Optimization Time

Average Storage Time

Performance KPI.

175. Predictive Statistics

Estimate

Future Harvest

Expected Revenue

Expected Profit

Capacity Requirement

Production Forecast

Updated daily.

176. Trend Analysis

Analyze

Daily Trend

Weekly Trend

Monthly Trend

Seasonal Trend

Revenue Trend

Generate

Engineering Report.

177. Statistics Export

Supported Formats

CSV

Excel

PDF

JSON

SQL

Custom Date Range

supported.

178. Dashboard KPI

Display

Harvest Readiness

Expected Revenue

Expected Profit

Capacity Usage

Optimization Score

Real-time update.

179. Long-Term Trend Analysis

Compare

Current Month

↓

Previous Month

↓

Previous Year

Generate

Harvest Optimization Report.

180. End Of Statistics Section

Harvest statistics

shall support

Engineering Decisions

Production Planning

Financial Analysis

Continuous Improvement.

181. Factory Acceptance Test (FAT)

Purpose

Verify complete

FB_HarvestManager

functionality

before shipment.

Harvest management

shall be tested

without affecting

runtime feeding operation.

182. FAT-001

Startup Test

Expected

READY

Harvest Database Loaded

Planning Profiles Loaded

Revenue Parameters Loaded

183. FAT-002

Harvest Plan Creation Test

Create

New Harvest Plan

↓

Validate

↓

Calculate

Expected

Plan Created

Successfully.

184. FAT-003

Harvest Validation Test

Validate

Harvest Plan

↓

Growth Verification

↓

Biomass Verification

↓

Revenue Parameters

Expected

Validation

Successful.

185. FAT-004

Harvest Readiness Test

Calculate

Harvest Readiness

↓

Target Weight

↓

Harvest Score

Expected

Calculation

Successful.

186. FAT-005

Yield Estimation Test

Calculate

Harvest Biomass

↓

Harvest Yield

↓

Yield Accuracy

Expected

Calculation

Successful.

187. FAT-006

Revenue Estimation Test

Calculate

Harvest Biomass

↓

Market Price

↓

Estimated Revenue

↓

Estimated Profit

Expected

Calculation

Successful.

188. FAT-007

Optimization Test

Optimize

Harvest Window

↓

Harvest Priority

↓

Capacity Usage

Expected

Optimization

Successful.

189. FAT-008

Cross Module Update Test

Verify

GrowthManager

BiomassManager

FCRManager

MortalityManager

Scheduler

Expected

All Modules

Updated Successfully.

190. FAT-009

Profitability Test

Modify

Market Price

↓

Recalculate

Revenue

↓

Profit

Expected

Updated Values

Generated.

191. FAT-010

Database Failure Test

Disconnect

Harvest Database

↓

Store Plan

Expected

Storage Rejected

Alarm Generated.

192. FAT-011

Performance Test

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Expected

Engineering Limits Met.

193. FAT-012

Power Failure Test

Power Loss

↓

Restart

↓

Restore Harvest Plans

Expected

Plans Restored

Without Corruption.

194. FAT-013

Long Duration Test

Continuous Operation

72 Hours

Expected

Stable Database

Stable Calculations

No Memory Corruption.

195. FAT-014

Integrity Test

Verify

Harvest CRC

Database CRC

Planning Integrity

Expected

Integrity

Verified.

196. FAT-015

Archive Verification Test

Verify

Harvest History

Revenue History

Optimization History

Expected

Archive Integrity

Verified.

197. FAT Acceptance Criteria

Mandatory Tests

100%

Passed

No Critical Failure

No Undefined Behaviour.

198. FAT Documentation

Store

Engineer

Date

Software Version

PLC Version

HarvestManager Version

Results

Comments

Archive Permanently.

199. FAT Approval

Approved By

Engineering

Quality Control

Project Manager

Required

before shipment.

200. End Of FAT Section

FB_HarvestManager

successfully passes

Factory Acceptance Test

before field deployment.

201. Site Acceptance Test (SAT)

Purpose

Verify correct

FB_HarvestManager

operation

after installation

at customer site.

SAT required

before production.

202. SAT Prerequisites

PLC Operational

Windows Software Connected

SQL Database Connected

Harvest Database Verified

Planning Profiles Loaded

Revenue Parameters Loaded

All prerequisites mandatory.

203. SAT-001

Harvest Manager Startup Test

Power ON

↓

Initialization

↓

READY

Expected

Correct Startup

No Harvest Alarm.

204. SAT-002

Harvest Plan Test

Create

Validated Plan

↓

Calculate

↓

Store

Expected

Plan Stored

Successfully.

205. SAT-003

Automatic Planning Test

Growth Update

↓

Harvest Readiness

↓

Harvest Planning

↓

Optimization

Expected

Correct Plan

Automatically Generated.

206. SAT-004

Harvest Readiness Verification Test

Verify

Current Weight

↓

Target Weight

↓

Readiness Score

Expected

Correct Readiness

Calculated.

207. SAT-005

Revenue Verification Test

Verify

Harvest Biomass

↓

Market Price

↓

Revenue

↓

Profit

Expected

Correct Financial Values

Calculated.

208. SAT-006

Database Storage Test

Store

Harvest Plan

↓

Verify Database

Expected

Plan Stored

Audit Logged.

209. SAT-007

Database Failure Test

Disconnect

Harvest Database

↓

Store Plan

↓

Reconnect

Expected

Recovery Successful

No Data Loss.

210. SAT-008

Optimization Verification Test

Generate

Harvest Plan

↓

Optimize

↓

Validate

Expected

Optimal Plan

Stored.

211. SAT-009

Cross Module Synchronization Test

Verify

GrowthManager

↓

BiomassManager

↓

FCRManager

↓

MortalityManager

↓

Scheduler

Expected

Synchronization

Successful.

212. SAT-010

Archive Test

Archive

Harvest Plan

↓

Restore

Expected

Archive Integrity

Verified.

213. SAT-011

Operator Test

Operator

Reviews Harvest Plan

↓

Approves Plan

↓

Stores Plan

Expected

Successful Operation

Without Assistance.

214. SAT-012

Engineering Test

Engineering

Modifies Parameters

↓

Recalculates Plan

↓

Publishes Results

Expected

Audit Trail

Generated.

215. SAT-013

Performance Test

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Within

Engineering Limits.

216. SAT-014

Security Test

Unauthorized User

Attempts

Plan Modification

Revenue Parameters

Database Access

Expected

Access Denied

Audit Record.

217. SAT-015

Long Duration Test

Continuous Operation

72 Hours

Expected

Stable Harvest Database

Stable Calculations

No Memory Corruption.

218. SAT Acceptance Criteria

Mandatory Tests

100%

Passed

Customer Approval

Required.

219. SAT Documentation

Store

Customer

Engineer

Date

Software Version

PLC Version

HarvestManager Version

Results

Comments

Archive Permanently.

220. End Of SAT Section

FB_HarvestManager

approved

for production

after successful

Site Acceptance Test.

221. Commissioning Philosophy

Purpose

Provide a standardized

commissioning procedure

for

FB_HarvestManager.

Commissioning shall verify

Harvest Planning

Harvest Optimization

Revenue Calculation

Capacity Planning

Database Integrity

222. Pre-Commissioning Checklist

Verify

PLC Program

Windows Software

SQL Database

Harvest Database

Planning Profiles

Revenue Parameters

All items mandatory.

223. Harvest Verification

Verify

Manual Plans

Automatic Plans

Optimized Plans

Executed Plans

Historical Plans

Engineering approval

required.

224. Validation Verification

Verify

Cage ID

Species

Target Weight

Harvest Date

Planning Parameters

Validation integrity

verified.

225. Calculation Verification

Verify

Harvest Readiness Formula

Yield Formula

Revenue Formula

Profit Formula

Optimization Algorithm

Calculation integrity

validated.

226. Database Verification

Verify

Storage Timing

Write Confirmation

Read Consistency

Retry Logic

Synchronization

Database integrity

validated.

227. Planning Verification

Verify

Planning Rules

Priority Rules

Capacity Rules

Optimization Rules

Compatibility

Version management

validated.

228. Performance Verification

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Database Response

Engineering limits

verified.

229. Database Integrity Verification

Verify

Harvest Database

Revenue Database

Planning History

Archive Database

Configuration Database

Database integrity

validated.

230. Recovery Verification

Verify

Planning Failure

↓

Database Recovery

↓

Synchronization Recovery

↓

Normal Operation

Recovery verified.

231. Backup Verification

Verify

Harvest Plans

Revenue History

Optimization History

Configuration

Archive

Backup integrity

verified.

232. Communication Verification

Verify

PLC

Windows Client

SQL Database

Harvest Repository

Cloud Library

Communication report

generated.

233. Long Duration Test

Continuous Harvest Planning

72 Hours

Expected

Stable Database

Stable Calculations

Stable Optimization

234. Engineering Checklist

Verify

Calculation Logic

Optimization Logic

Planning Logic

Revenue Logic

Performance

Statistics

Checklist completed.

235. Diagnostic Verification

Verify

Harvest Report

Revenue Report

Optimization Report

Capacity Report

Health Report

Export successful.

236. Commissioning Report

Store

Engineer

Customer

Software Version

PLC Version

HarvestManager Version

Results

Comments

Export

PDF

237. Commissioning Approval

Approved By

Engineering

Commissioning Engineer

Customer

Digital approval

supported.

238. Production Release

Production allowed only after

Commissioning Approved

↓

SAT Approved

↓

Customer Acceptance

System Status

Production Ready

239. Release Verification

Verify

Planning Stable

↓

Database Stable

↓

Optimization Stable

↓

Synchronization Stable

Release authorized.

240. End Of Commissioning Section

FB_HarvestManager

shall enter production

only after successful

Verification

Commissioning

Customer Approval

241. Debug Philosophy

Purpose

Provide complete engineering visibility

into

Harvest Planning

Yield Estimation

Revenue Calculation

Production Optimization

Diagnostics

Debug functions

shall never modify

runtime production data.

242. Debug Levels

Level 1

Operator

----------------------------

Level 2

Supervisor

----------------------------

Level 3

Service

----------------------------

Level 4

Engineering

Access controlled.

243. Live Harvest Dashboard

Display

Harvest Readiness

Estimated Yield

Estimated Revenue

Estimated Profit

Harvest Health

Refresh

Continuously.

244. Capacity Monitor

Display

Daily Capacity

Used Capacity

Remaining Capacity

Planned Capacity

Utilization

Real-time update.

245. Validation Monitor

Display

Current Validation

Validation Progress

Validation Result

Elapsed Time

Plan ID

Engineering display.

246. Optimization Monitor

Display

Optimization Status

Optimization Score

Planning Priority

Capacity Allocation

Planning Trend

Updated continuously.

247. Runtime Monitor

Display

Planning Runtime

Calculation Runtime

Database Runtime

Synchronization Runtime

Communication Runtime

Engineering only.

248. Performance Monitor

Display

Planning Speed

Calculation Speed

Optimization Speed

Synchronization Speed

Database Response

Performance graph supported.

249. Harvest Inspector

Display

Plan ID

Cage ID

Harvest Date

Estimated Biomass

Estimated Revenue

Read Only.

250. Configuration Inspector

Display

Planning Rules

Revenue Parameters

Capacity Parameters

Calculation Version

Configuration Revision

Engineering analysis.

251. Event Timeline

Display

Plan Created

↓

Validated

↓

Calculated

↓

Optimized

↓

Stored

↓

Executed

↓

Archived

Timeline generated

automatically.

252. Runtime Variables

Display

Plan Counter

Calculation Counter

Optimization Counter

Validation Counter

Failure Counter

Archive Counter

Engineering access only.

253. Harvest Viewer

Display

Manual Plans

Automatic Plans

Optimized Plans

Historical Plans

Executed Plans

Advanced search

supported.

254. Event Viewer

Display

Plan Created

Calculation Completed

Optimization Completed

Revenue Updated

Configuration Changed

Plan Archived

Filter supported.

255. Diagnostic Console

Display

Internal Structures

Timers

Counters

Flags

Planning State Machine

Engineering only.

256. Debug Export

Export

Harvest Logs

Revenue Reports

Optimization Reports

Capacity Reports

Diagnostic Reports

Formats

CSV

PDF

ZIP

257. Remote Diagnostics

Future Support

Remote Harvest Planning

Remote Diagnostics

Remote Configuration Review

Remote Planning Analysis

Remote Configuration

disabled by default.

258. Debug Security

Every engineering action

requires

Authentication

Authorization

Audit Logging

Permanent audit trail.

259. Diagnostic Report

Generate

Harvest Status

Optimization Status

Revenue Analysis

Capacity Utilization

Harvest Health

Configuration Integrity

Automatic report generation.

260. End Of Debug Section

FB_HarvestManager

shall provide

complete engineering

diagnostics

without affecting

runtime harvest

or feeding operation.

261. Failure Mode and Effects Analysis (FMEA)

Purpose

Identify

Analyze

Prevent

Mitigate

all possible

harvest management failures.

Every failure

shall define

Cause

Effect

Detection

Recovery

262. Failure Categories

Harvest Planning

Yield Estimation

Revenue Calculation

Optimization

Capacity

Database

Communication

Software

Each failure

assigned

one primary category.

263. FMEA-001

Failure

Harvest Validation Failure

Cause

Missing Cage ID

Invalid Biomass

Invalid Target Weight

Effect

Plan Rejected

Recovery

Correct Data

Revalidate

Generate Alarm

264. FMEA-002

Failure

Harvest Readiness Calculation Failure

Cause

Missing Growth Data

Invalid Biomass

Calculation Error

Effect

Incorrect Readiness Score

Recovery

Reload Parameters

Recalculate

265. FMEA-003

Failure

Yield Estimation Failure

Cause

Growth Model Error

Invalid Biomass

Calculation Error

Effect

Incorrect Yield Prediction

Recovery

Reload Growth Data

Recalculate

266. FMEA-004

Failure

Revenue Calculation Failure

Cause

Invalid Market Price

Missing Cost Parameters

Calculation Error

Effect

Incorrect Revenue Estimate

Recovery

Reload Parameters

Recalculate

267. FMEA-005

Failure

Optimization Failure

Cause

Missing Capacity Data

Optimization Logic Error

Configuration Error

Effect

Suboptimal Harvest Plan

Recovery

Reload Configuration

Verify Parameters

268. FMEA-006

Failure

Communication Failure

Cause

Database Offline

Repository Offline

Network Error

Effect

Synchronization Lost

Recovery

Retry Communication

Generate Alarm

269. FMEA-007

Failure

Harvest Database Corruption

Cause

Storage Failure

Unexpected Shutdown

Database Corruption

Effect

Database Unavailable

Recovery

Restore Backup

Verify Database

270. FMEA-008

Failure

Cross Module Synchronization Failure

Cause

GrowthManager Offline

BiomassManager Offline

Scheduler Offline

Effect

Planning Data

Outdated

Recovery

Automatic Resynchronization

Generate Warning

271. FMEA-009

Failure

Capacity Planning Failure

Cause

Invalid Capacity

Configuration Error

Planning Conflict

Effect

Harvest Delay

Recovery

Recalculate Capacity

Generate Alarm

272. FMEA-010

Failure

Harvest Manager Internal Fault

Cause

Unexpected Runtime Error

Memory Corruption

Internal Exception

Effect

Harvest Planning Stops

Recovery

Safe State

Diagnostic Snapshot

Critical Alarm

273. Risk Evaluation

Every failure

evaluated using

Severity

Occurrence

Detection

Calculate

Risk Priority Number

(RPN)

Engineering review

mandatory.

274. Preventive Actions

Possible Actions

Planning Validation

Calculation Verification

Optimization Verification

Database Monitoring

Consistency Testing

Tracked permanently.

275. Corrective Actions

Store

Failure

Root Cause

Solution

Engineer

Verification

Completion Date

Audit trail required.

276. Lessons Learned

Engineering may attach

Comments

Recommendations

Improvement Ideas

Production Notes

Linked to failure record.

277. Failure Statistics

Calculate

Failure Frequency

Planning Success

Optimization Success

Synchronization Success

Displayed monthly.

278. Continuous Improvement

Repeated failures

shall trigger

Engineering Review

Software Update

Procedure Revision

Actions documented.

279. FMEA Approval

Approved By

Engineering

Quality

Project Manager

Mandatory before release.

280. End Of FMEA Section

FB_HarvestManager

shall detect,

analyze,

prevent,

and recover

from all identified

harvest management failures.

281. Structured Text Architecture

Purpose

Define the internal

software architecture

of

FB_HarvestManager.

Implementation shall remain

Deterministic

Modular

Maintainable

Scalable

282. Function Block Structure

FUNCTION_BLOCK

FB_HarvestManager

Regions

Initialization

↓

Plan Reception

↓

Validation

↓

Harvest Processing

↓

Optimization

↓

Revenue Analysis

↓

Database Manager

↓

Statistics

↓

Diagnostics

↓

Output Processing

283. Initialization Region

Executed

Once

after startup.

Responsibilities

Load Harvest Database

Load Planning Profiles

Load Revenue Parameters

Load Capacity Rules

Initialize Runtime Variables

Retentive data

preserved.

284. Plan Reception Region

Collect

Operator Requests

Automatic Plans

Scheduler Requests

Production Requests

Engineering Requests

Copy into

internal structures.

No calculations

performed here.

285. Validation Region

Verify

Cage ID

Species

Target Weight

Estimated Biomass

Planning Integrity

Invalid plans

discarded.

286. Harvest Processing Region

Manage

Harvest Plans

↓

Readiness Calculation

↓

Yield Estimation

↓

Harvest Scheduling

↓

Priority Assignment

Harvest integrity

maintained.

287. Optimization Region

Manage

Harvest Sequence

↓

Capacity Optimization

↓

Revenue Optimization

↓

Resource Allocation

↓

Schedule Optimization

Optimization integrity

maintained.

288. Revenue Analysis Region

Calculate

Estimated Revenue

↓

Operating Cost

↓

Processing Cost

↓

Estimated Profit

↓

Profit Margin

Calculation integrity

maintained.

289. Database Manager Region

Store

Validated Plans

↓

Optimization History

↓

Revenue History

↓

Execution History

↓

Receive Confirmation

Database synchronization

verified.

290. Statistics Region

Update

Harvest Statistics

Revenue Statistics

Capacity Statistics

Planning Statistics

Buffered before storage.

291. Diagnostics Region

Update

Harvest Health

Database Health

Planning Health

Configuration Health

Communication Health

Executed every cycle.

292. Cross Module Update Region

Notify

GrowthManager

↓

BiomassManager

↓

Scheduler

↓

ReportManager

↓

DataLogger

↓

AI Engine

Execution verified.

293. Output Processing Region

Generate

Harvest Readiness

Estimated Yield

Estimated Revenue

Estimated Profit

Health Status

Outputs updated

once per PLC cycle.

294. Internal Structures

ST_HarvestRuntime

ST_HarvestDatabase

ST_HarvestConfiguration

ST_HarvestStatistics

ST_HarvestDiagnostics

ST_HarvestOptimization

Defined separately.

295. Internal Timers

Validation Timer

Calculation Timer

Optimization Timer

Storage Timer

Synchronization Timer

Health Timer

One owner

per timer.

296. Internal Counters

Plan Counter

Calculation Counter

Optimization Counter

Validation Counter

Failure Counter

Archive Counter

Retentive

where required.

297. Implementation Constraints

No Dynamic Memory

No Recursion

No Blocking Loops

No Undefined State

No Hidden Transition

Fully deterministic.

298. Harvest Constraints

Harvest calculations

shall be

Validated

Version Controlled

Traceable

Audit Logged

Consistent

Execution order

shall remain

deterministic.

299. Processing Constraints

Every plan

shall always be

Validated

↓

Calculated

↓

Optimized

↓

Verified

↓

Stored

↓

Archived

Processing order

mandatory.

300. End Of Structured Text Architecture

The internal architecture

shall ensure

Predictable Execution

Reliable Harvest Management

Easy Maintenance

Deterministic Behaviour

301. Coding Standards

Purpose

Ensure

Readable

Maintainable

Deterministic

Reliable

Harvest Management Software.

Implementation shall comply

with

AQ-SWR-085

Coding Standard.

302. Variable Naming

Boolean

b

Example

bHarvestReady

----------------------------

Integer

i

Example

iHarvestCounter

----------------------------

Unsigned Integer

ui

Example

uiHarvestPlanID

----------------------------

Real

r

Example

rEstimatedRevenue

----------------------------

Timer

t

Example

tOptimizationTimer

----------------------------

Structure

st

Example

stHarvestRuntime

Naming convention mandatory.

303. Function Naming

Functions

shall begin with

Fn_

Examples

FnValidateHarvest()

FnCalculateHarvest()

FnOptimizeHarvest()

FnCalculateRevenue()

FnArchiveHarvest()

304. Method Responsibilities

Each method

shall perform

exactly

one responsibility.

Examples

Validate

Calculate

Optimize

Store

Archive

Mixed responsibilities

prohibited.

305. Comment Standard

Every Function

shall contain

Purpose

Inputs

Outputs

Engineering Notes

Comments explain

WHY

not

WHAT.

306. Constants

Magic Numbers

prohibited.

Examples

MAX_HARVEST_PLANS

MAX_HARVEST_WINDOWS

DEFAULT_TARGET_WEIGHT

DEFAULT_PROFIT_MARGIN

Constants defined centrally.

307. Parameter Validation

Every parameter

validated during

Initialization.

Invalid Parameter

↓

Reject

↓

Harvest Alarm

↓

Load Safe Default

308. Error Handling

Unexpected Error

↓

Safe State

↓

Diagnostic Snapshot

↓

Harvest Alarm

↓

Audit Log

Undefined execution

prohibited.

309. Memory Rules

Static Memory Only

No Dynamic Allocation

No Recursive Structures

No Circular References

Memory ownership defined.

310. Execution Rules

One Execution Cycle

↓

Receive Plan

↓

Validate

↓

Calculate

↓

Optimize

↓

Store

↓

Publish Status

Execution order fixed.

311. Harvest Rules

Every Plan

shall contain

Plan ID

Cage ID

Harvest Date

Estimated Biomass

Timestamp

Mandatory fields only.

312. Version Rules

Every Planning Profile

shall contain

Version Number

Optimization Revision

Approval Status

Compatibility

Profile Revision

Mandatory fields only.

313. Logging Rules

Every significant action

logged.

Plan Created

Calculation Completed

Optimization Completed

Plan Stored

Plan Archived

314. Statistics Rules

Statistics updated

only after

successful

validation

or optimization.

Failed operations

stored separately.

315. Health Rules

Harvest Health

updated

periodically.

Health calculation

shall not delay

runtime calculations.

316. Safety Rules

Validated Plans

always have

highest priority.

Emergency Harvest

overrides

standard planning.

317. Performance Rules

Harvest operations

shall complete

within configured

performance limits.

Performance monitored

continuously.

318. Code Review Checklist

Verify

Naming

Documentation

Calculation Logic

Optimization Logic

Database Logic

Performance

Security

Peer Review mandatory.

319. Documentation Rules

Every software revision

shall update

Revision History

Test Results

Engineering Notes

Release Notes

Undocumented changes

prohibited.

320. End Of Coding Standards

The coding standard

ensures

consistent,

maintainable,

predictable,

high-quality

Harvest Management software.

321. Delta PLC Implementation

Target PLC

Delta DVP-SV3

Programming Language

IEC 61131-3

Structured Text

Execution

Cyclic Scan

322. PLC Memory Layout

Retentive Area

Harvest Plans

Planning Statistics

Revenue Statistics

Optimization Profiles

Configuration Parameters

Non-Retentive Area

Runtime Variables

Calculation Buffers

Optimization Buffers

Temporary Structures

323. Register Philosophy

Every Register

shall contain

Default Value

Minimum

Maximum

Description

Engineering Unit

Register overlap

strictly prohibited.

324. Startup Behaviour

Power ON

↓

Load Harvest Database

↓

Load Planning Profiles

↓

Load Revenue Parameters

↓

Load Active Plans

↓

Initialize Runtime

↓

READY

Initialization order fixed.

325. Shutdown Behaviour

Before Shutdown

Store

Current Harvest State

↓

Planning Statistics

↓

Revenue Statistics

↓

Runtime State

↓

Power Down

Unexpected shutdown

handled identically.

326. Restart Behaviour

After Restart

↓

Restore Harvest Plans

↓

Verify Integrity

↓

Restore Runtime State

↓

Resume Planning

Automatic recovery

supported.

327. Scan Time Budget

Validation

20%

Calculation

30%

Optimization

20%

Storage

15%

Diagnostics

15%

Engineering Target

Maximum

20 ms

328. Communication Mapping

PLC

↓

Windows Software

↓

SQL Database

↓

Harvest Repository

↓

Future Cloud Library

Detailed mapping

maintained separately.

329. PLC Watchdog

Monitor

Execution Time

Watchdog Timeout

↓

Harvest Alarm

↓

Freeze Planning

↓

Diagnostic Snapshot

Watchdog enabled

permanently.

330. Expansion Strategy

Architecture supports

Multiple PLC

Multiple Farms

Cloud Harvest Database

Fleet Harvest Planning

AI Harvest Optimization

No redesign required.

331. Software Portability

Software independent of

Specific HMI

Specific Database

Specific SCADA

Specific Cloud Platform

Hardware abstraction

preferred.

332. Version Identification

Every Build

contains

Software Version

Build Number

Compilation Date

PLC Model

Project Name

Displayed

on Engineering Screen.

333. Build Verification

Verify

Compilation

Warnings

Undefined Variables

Duplicate Symbols

Zero warnings preferred.

334. Parameter Compatibility

Older Parameter Files

shall remain

compatible.

Automatic migration

supported.

335. Software Upgrade

Upgrade Procedure

Backup

↓

Install

↓

Restore Parameters

↓

Restore Harvest Plans

↓

Verify

↓

Restart

Rollback supported.

336. Backup Philosophy

Backup includes

Harvest Database

Planning Statistics

Revenue History

Optimization Profiles

Configuration

Backup checksum

mandatory.

337. Restore Philosophy

Restore

↓

CRC Check

↓

Compatibility Check

↓

Integrity Check

↓

Activate

Invalid restore

rejected.

338. Engineering Restrictions

Engineering functions

shall never modify

validated harvest plans

during

critical production periods.

Changes applied

only after

safe update window.

339. Release Checklist

Verify

Compilation

Calculation Logic

Optimization Logic

Database Logic

Performance

Documentation

Release approval

required.

340. End Of Delta PLC Section

FB_HarvestManager

implemented according to

Delta DVP-SV3

engineering principles.

341. Final Engineering Validation

Purpose

Verify the complete

FB_HarvestManager

before software release.

All engineering requirements

shall be validated.

342. Validation Checklist

Verify

Harvest Planning

↓

Harvest Readiness

↓

Yield Estimation

↓

Revenue Calculation

↓

Profit Calculation

↓

Optimization

↓

Database Synchronization

↓

Statistics

↓

Diagnostics

↓

Performance

Every item mandatory.

343. Software Audit

Audit

Coding Standard

Naming Convention

Documentation

Calculation Logic

Optimization Logic

Database Logic

Security

Audit Report required.

344. Runtime Verification

Verify

CPU Load

Memory Usage

Harvest Database

Planning Database

Calculation Performance

Optimization Performance

Values within engineering limits.

345. Harvest Verification

Verify

Harvest Readiness

Yield Accuracy

Revenue Accuracy

Profit Accuracy

Planning Consistency

Reliable harvest management

shall always be maintained.

346. Calculation Verification

Verify

Plan Received

↓

Validated

↓

Calculated

↓

Optimized

↓

Stored

↓

Confirmed

↓

Archived

No calculation loss

permitted.

347. Database Verification

Verify

Plan Transfer

Storage Time

Database Confirmation

Synchronization Status

Rollback Behaviour

100% storage integrity required.

348. Performance Verification

Measure

Validation Time

Calculation Time

Optimization Time

Storage Time

Database Response Time

Performance report generated.

349. Long Duration Verification

Continuous Operation

Minimum

72 Hours

Expected

Stable Harvest Database

Stable Optimization

No Memory Corruption

No Performance Degradation

350. Software Robustness

Verify

Validation Failure

Calculation Failure

Optimization Failure

Database Failure

Unexpected Restart

Communication Failure

Software enters

Safe State

when required.

351. Final Engineering Review

Participants

Software Engineer

Automation Engineer

Commissioning Engineer

Project Manager

Quality Engineer

Production Manager

Meeting minutes archived.

352. Customer Demonstration

Demonstrate

Harvest Dashboard

Harvest Planning

Yield Analysis

Revenue Analysis

Optimization Reports

Harvest History

Customer approval recorded.

353. Documentation Package

Package Includes

Software Design

Operator Manual

Service Manual

Harvest Management Guide

Administration Guide

Commissioning Guide

Revision History

Delivered with release.

354. Configuration Package

Package Includes

Harvest Database

Planning Profiles

Revenue Parameters

Optimization Parameters

Configuration Files

Engineering Settings

Version controlled.

355. Archive Policy

Archive

Source Code

Compiled Software

Harvest Database

Planning History

Documentation

Test Reports

Permanent retention.

356. Release Identification

Every Release contains

Major Version

Minor Version

Revision

Build Number

Release Date

Unique identification required.

357. Product Identification

Product

NVM AquaFeed Platform

Module

FB_HarvestManager

Document ID

AQ-FB-077

358. Approval Signatures

Engineering

↓

Quality Assurance

↓

Project Manager

↓

Customer

Digital signatures supported.

359. Release Status

Status

Engineering Complete

↓

Implementation Ready

↓

Factory Approved

↓

Site Approved

↓

Production Approved

Status permanently tracked.

360. End Of FB_HarvestManager Design Specification

This document defines

the complete engineering specification

for

FB_HarvestManager.

Implementation shall comply

with this specification.

Status

Engineering Complete

Ready For Implementation

END OF DOCUMENT