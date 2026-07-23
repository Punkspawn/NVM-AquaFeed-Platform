# NVM AquaFeed Platform
## UI / UX Design Specification

Document ID : AQ-UI-004

Version : 0.1

Status : Draft

--------------------------------------------------

# 1. Design Philosophy

The application is primarily designed for fish farm operators.

The operator should be able to start feeding within 30 seconds after opening the software.

The software shall never require unnecessary navigation.

Frequently used functions shall always be accessible.

Every screen shall clearly answer:

• What is happening?

• What should I do?

• Is there any problem?

--------------------------------------------------

# 2. User Roles

Operator

Supervisor

Service Engineer

Administrator

Each role has different permissions.

--------------------------------------------------

# 3. Main Navigation

Dashboard

↓

Mission Planner

↓

Live Feeding

↓

Farm Management

↓

Feed Management

↓

Maintenance

↓

Reports

↓

Service

↓

Settings

--------------------------------------------------

# 4. Dashboard

Purpose

Provide complete farm overview.

Dashboard shall display

Current Date

Current Time

Logged User

PLC Connection

Database Connection

Generator Status

Weather (Future)

Number of Active Lines

Number of Active Missions

Current Feed Consumption

Today's Feed Consumption

Today's Mortality

Today's FCR

--------------------------------------------------

# 5. Feeding Line Cards

Each line shall be displayed as a large card.

Example

---------------------------------------

LINE 1

READY

Selector

Eye 8

Blower

38.0 Hz

Current Mission

Cage A-12

Remaining

152 kg

Progress

42 %

---------------------------------------

Operator can click any card.

--------------------------------------------------

# 6. Live Feeding Screen

Shows every active feeding line.

Each line displays

Current Cage

Current Feed

Current Silo

Current Eye

Current Feed Rate

Target Feed

Delivered Feed

Remaining Feed

Estimated Finish Time

Current Blower Frequency

Current Dosing Speed

Current State

--------------------------------------------------

# 7. Mission Planner

Mission Planner shall support queue based operation.

Operator can

Create Mission

Edit Mission

Delete Mission

Duplicate Mission

Reorder Mission

Pause Queue

Resume Queue

Start Queue

Stop Queue

--------------------------------------------------

# 8. Drag & Drop

Mission queue shall support Drag & Drop.

Operator changes mission order using mouse.

--------------------------------------------------

# 9. Cage Screen

Each cage has its own page.

Displayed information

Photo

Cage Name

Current Line

Current Eye

Current Fish Lot

Current Feed

Current Average Weight

Current Biomass

Current Fish Count

Today's Feed

Total Feed

Mortality

FCR

Growth Graph

Feed History

Mission History

--------------------------------------------------

# 10. Fish Lot Screen

Each fish lot has independent history.

Displayed

Arrival Date

Supplier

Species

Average Weight

Current Weight

Stock Count

Mortality

Biomass

Feed Consumption

Feed Conversion Ratio

Expected Harvest

Historical Graphs

--------------------------------------------------

# 11. Feed Management

Operator can manage

Feed Types

Feed Lots

Feed Suppliers

Feed Density

Kg Per Revolution

Feed Diameter

Feed Stock

--------------------------------------------------

# 12. Silo Screen

Displays

Current Feed

Current Weight

Remaining Capacity

Estimated Empty Time

Connected Line

Connected Selector Eye

--------------------------------------------------

# 13. Smart Farm Dashboard

Displays

Farm Biomass

Average FCR

Average Weight

Daily Growth

Weekly Growth

Feed Consumption

Mortality

Feed Cost

Estimated Harvest Date

--------------------------------------------------

# 14. Alarm Center

Displays

Active Alarms

Alarm History

Alarm Statistics

Acknowledged Alarms

Critical Alarms

Alarm Filters

--------------------------------------------------

# 15. Maintenance Center

Displays

Upcoming Maintenance

Expired Maintenance

Machine Runtime

Maintenance History

Maintenance Notes

Maintenance Checklist

--------------------------------------------------

# 16. Service Screen

Protected by password.

Contains

IO Monitor

IO Force

Analog Values

Digital Inputs

Digital Outputs

Modbus Monitor

Drive Status

Calibration

Backup

Restore

Parameter Editor

Flight Recorder

Health Monitor

--------------------------------------------------

# 17. Parameter Screen

Parameters grouped by machine.

Selector

Blower

Dosing

Mission

Communication

System

Every parameter contains

Description

Current Value

Minimum

Maximum

Unit

Default Value

Last Modified

Modified By

--------------------------------------------------

# 18. Explain Mode

Instead of displaying only errors

Software explains problems.

Example

Cannot Start Feeding

Reason

Selector is not ready.

Expected Position

Eye 8

Current Position

Eye 6

--------------------------------------------------

Another example

Mission Paused

Reason

Pulse sensor fault detected.

--------------------------------------------------

# 19. Color Philosophy

Green

Ready

Blue

Running

Yellow

Warning

Orange

Maintenance Required

Red

Alarm

Gray

Offline

--------------------------------------------------

# 20. Operator Philosophy

The operator should never search for information.

Important information shall always be visible.

Maximum mouse clicks to start feeding

3

Maximum clicks to stop feeding

1

--------------------------------------------------

# 21. Future Mobile Compatibility

Every screen shall be designed responsive.

Desktop

Tablet

Mobile

Future applications shall reuse the same backend.

--------------------------------------------------

# 22. UX Rules

Never open unnecessary dialog boxes.

Never ask unnecessary confirmations.

Always explain why an operation failed.

Always display progress.

Always display estimated completion time.

--------------------------------------------------

# 23. Product Motto

Simple for the operator.

Powerful for the engineer.

Reliable for production.

--------------------------------------------------

END OF DOCUMENT