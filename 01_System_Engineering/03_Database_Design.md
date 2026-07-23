# NVM AquaFeed Platform
## Database Design Specification

Document ID : AQ-DB-003

Version : 0.1

Status : Draft

---

# 1. Purpose

This document defines the complete database structure of AquaFeed Manager.

The database shall support

• Machine Management

• Smart Farm

• Mission Planning

• Feeding History

• Maintenance

• Reports

• Alarm History

• Event History

• Future Cloud Synchronization

SQLite shall be used in the first version.

Future versions shall support PostgreSQL without structural changes.

---

# 2. Design Principles

The database shall follow the following rules.

• Every object has a unique ID.

• No duplicated information.

• Historical data shall never overwrite previous data.

• Physical machine configuration shall be separated from production data.

• Every change shall be traceable.

---

# 3. Main Entities

Farm

↓

Barge

↓

Feeding Line

↓

Selector

↓

Blower

↓

Dosing Unit

↓

Silo

↓

Feed

↓

Cage

↓

Fish Lot

↓

Mission

↓

Mission History

↓

Alarm

↓

Event

↓

Maintenance

↓

User

↓

Parameter

---

# 4. Farm Table

FarmID

Name

Country

City

Address

Latitude

Longitude

Owner

Phone

Email

Description

CreatedDate

ModifiedDate

---

# 5. Barge Table

BargeID

FarmID

Name

PLC Model

PLC Firmware

NumberOfLines

NumberOfSilos

InstallationDate

CommissionDate

Status

Notes

---

# 6. Feeding Line

LineID

BargeID

LineNumber

Name

Enabled

CurrentMissionID

CurrentCageID

CurrentSiloID

State

---

# 7. Selector

SelectorID

LineID

DriveAddress

EyeCount

CurrentEye

CalibrationVersion

ServiceDate

RuntimeHours

MoveCounter

---

# 8. Blower

BlowerID

LineID

DriveAddress

MotorPower

MaximumFrequency

MinimumFrequency

RuntimeHours

MaintenanceHours

StartCounter

LastService

---

# 9. Dosing Unit

DosingID

LineID

DriveAddress

MotorPower

KgPerRevolution

CalibrationDate

PulseCounter

RuntimeHours

MaintenanceHours

---

# 10. Silo

SiloID

BargeID

Name

FeedID

CurrentWeight

MaximumCapacity

FeedLevelAlarm

Active

Notes

---

# 11. Feed

FeedID

Manufacturer

ProductName

Diameter

Density

Protein

Fat

Energy

LotNumber

ProductionDate

ExpirationDate

---

# 12. Cage

CageID

FarmID

CurrentLine

CurrentEye

Name

Location

Depth

Diameter

Status

Notes

The cage location may change over time.

Historical movements shall be recorded.

---

# 13. Cage Movement History

MovementID

CageID

OldLine

OldEye

NewLine

NewEye

MovementDate

Operator

Reason

---

# 14. Fish Lot

LotID

CageID

Species

Supplier

ArrivalDate

InitialFishCount

CurrentFishCount

InitialAverageWeight

CurrentAverageWeight

Mortality

Biomass

Status

Notes

---

# 15. Feed History

FeedHistoryID

MissionID

LotID

FeedID

FeedAmount

FeedRate

StartTime

FinishTime

Operator

Duration

AverageBlowerFrequency

AverageDoseRate

---

# 16. Mission

MissionID

MissionQueue

LineID

CageID

FeedID

TargetKg

FeedRate

Priority

MissionStatus

CreatedDate

CreatedBy

---

# 17. Mission Status

Possible values

Waiting

Preparing

Running

Paused

Completed

Cancelled

Failed

---

# 18. Mission Event Log

MissionEventID

MissionID

DateTime

EventType

Description

User

---

# 19. Alarm

AlarmID

Machine

MachineID

AlarmCode

Severity

StartTime

EndTime

Acknowledged

ResetUser

Description

---

# 20. Event Log

EventID

DateTime

Category

Description

User

Machine

ReferenceID

---

# 21. Maintenance

MaintenanceID

MachineType

MachineID

MaintenanceType

PlannedDate

CompletedDate

RuntimeHours

ResponsiblePerson

Notes

---

# 22. Parameter

ParameterID

MachineType

MachineID

ParameterName

CurrentValue

MinimumValue

MaximumValue

EngineeringUnit

ModifiedDate

ModifiedBy

---

# 23. Users

UserID

Username

PasswordHash

Role

Language

Active

LastLogin

---

# 24. User Roles

Operator

Supervisor

Service

Administrator

---

# 25. Service Session

SessionID

Engineer

Machine

LoginTime

LogoutTime

OperationsPerformed

RemoteConnection

---

# 26. Backup

BackupID

BackupDate

SoftwareVersion

PLCVersion

DatabaseVersion

Operator

FileName

Checksum

---

# 27. Future Tables

CameraEvents

CloudSynchronization

FleetManagement

ERPIntegration

Weather

WaterQuality

AIAnalysis

PredictiveMaintenance

---

# 28. Database Rules

The database shall never delete production history.

Soft delete shall be preferred.

Every important record shall contain

CreatedDate

ModifiedDate

CreatedBy

ModifiedBy

---

# 29. Performance Requirements

The database shall support

100 Farms

500 Barges

5000 Cages

50000 Missions

100000 Feed Records

1000000 Event Records

without structural redesign.

---

# End of Document