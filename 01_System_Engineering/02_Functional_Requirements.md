# NVM AquaFeed Platform
## Functional Requirements Specification

Document ID : AQ-SRS-002

Version : 0.1

Status : Draft

---

# 1. Introduction

This document defines every functional requirement of the AquaFeed Platform.

All software components including

• AquaCore PLC

• AquaFeed Manager

• Mobile Applications

must comply with these requirements.

Each requirement has a unique identifier.

Future revisions shall never modify existing requirement IDs.

---

# 2. General Requirements

FR-0001

The system shall operate with a single Delta PLC.

FR-0002

The system shall support future PLC replacement with minimal software modification.

FR-0003

The PLC shall operate independently from the PC application.

FR-0004

Loss of Windows communication shall never stop feeding.

FR-0005

Every feeding line shall operate independently.

FR-0006

Failure of one feeding line shall not affect other lines.

FR-0007

All operational parameters shall be stored in retentive memory.

FR-0008

Every parameter modification shall be recorded.

FR-0009

Every alarm shall be time stamped.

FR-0010

The software shall be modular.

---

# 3. User Requirements

FR-0101

Operator shall be able to start feeding manually.

FR-0102

Operator shall be able to stop feeding at any time.

FR-0103

Operator shall be able to pause feeding.

FR-0104

Operator shall be able to resume feeding.

FR-0105

Operator shall be able to edit missions before execution.

FR-0106

Operator shall be able to reorder queued missions.

FR-0107

Operator shall be able to delete queued missions.

FR-0108

Operator shall see feeding progress.

FR-0109

Operator shall see remaining feed amount.

FR-0110

Operator shall see estimated completion time.

---

# 4. Selector Requirements

FR-0201

The selector shall support automatic positioning.

FR-0202

The selector shall support manual positioning.

FR-0203

The selector shall support service positioning.

FR-0204

The selector shall use analog feedback.

FR-0205

The selector shall support position calibration.

FR-0206

Position tolerance shall be configurable.

FR-0207

Move timeout shall be configurable.

FR-0208

Reverse direction shall be configurable.

FR-0209

Position settle time shall be configurable.

FR-0210

The selector shall generate Ready status.

FR-0211

The selector shall generate Busy status.

FR-0212

The selector shall generate Alarm status.

FR-0213

The selector shall store move statistics.

FR-0214

The selector shall store runtime.

FR-0215

The selector shall detect analog signal failure.

---

# 5. Blower Requirements

FR-0301

The blower shall be VFD controlled.

FR-0302

Minimum frequency shall be configurable.

FR-0303

Maximum frequency shall be configurable.

FR-0304

Service shall define frequency limits.

FR-0305

Operator shall not exceed service limits.

FR-0306

PreRun time shall be configurable.

FR-0307

PostRun time shall be configurable.

FR-0308

Blower Ready signal shall be generated.

FR-0309

Blower runtime shall be recorded.

FR-0310

Blower maintenance hours shall be recorded.

FR-0311

Blower drive faults shall be monitored.

FR-0312

Blower communication failures shall generate alarms.

---

# 6. Dosing Requirements

FR-0401

Feed amount shall be calculated using Kg Per Revolution.

FR-0402

One inductive sensor pulse shall represent one gearbox revolution.

FR-0403

Kg Per Revolution shall be configurable.

FR-0404

Feed rate shall be configurable.

FR-0405

Calibration shall be service protected.

FR-0406

Runtime shall be recorded.

FR-0407

Total feed delivered shall be recorded.

FR-0408

Pulse sensor failures shall generate alarms.

---

# 7. Mission Requirements

FR-0501

The system shall support mission queues.

FR-0502

Mission queue capacity shall be configurable.

FR-0503

Mission queue capacity shall be machine dependent.

FR-0504

Mission execution order shall be editable.

FR-0505

Mission shall support pause.

FR-0506

Mission shall support resume.

FR-0507

Mission shall support cancel.

FR-0508

Mission history shall never be deleted automatically.

FR-0509

Mission completion shall generate historical records.

FR-0510

Mission shall update Smart Farm statistics.

---

# 8. Smart Farm Requirements

FR-0601

Each cage shall have a unique identifier.

FR-0602

Each cage shall have a user editable name.

FR-0603

Cages shall support relocation between feeding lines.

FR-0604

Fish lots shall remain associated with cages.

FR-0605

Feed history shall remain associated with fish lots.

FR-0606

Average fish weight shall be recorded.

FR-0607

Mortality shall be recorded.

FR-0608

Biomass shall be calculated.

FR-0609

FCR shall be calculated.

FR-0610

Harvest estimation shall be calculated.

---

# 9. Service Requirements

FR-0701

Service mode shall require authentication.

FR-0702

Service mode shall support IO monitoring.

FR-0703

Service mode shall support IO forcing.

FR-0704

Service mode shall support calibration.

FR-0705

Service mode shall support diagnostics.

FR-0706

Service mode shall support communication monitoring.

FR-0707

Service mode shall support parameter backup.

FR-0708

Service mode shall support parameter restore.

FR-0709

Service mode shall support simulation.

FR-0710

Service actions shall be logged.

---

# 10. Alarm Requirements

FR-0801

Every alarm shall have a unique code.

FR-0802

Every alarm shall have severity.

FR-0803

Every alarm shall have timestamp.

FR-0804

Every alarm shall support acknowledgement.

FR-0805

Every alarm shall support history.

FR-0806

Alarm reset shall not automatically restart feeding.

---

# 11. Communication Requirements

FR-0901

PLC shall communicate with PC using Modbus TCP.

FR-0902

PLC shall communicate with drives using Modbus RTU.

FR-0903

Communication failures shall be detected.

FR-0904

Heartbeat shall be implemented.

FR-0905

Communication statistics shall be available.

---

# 12. Health Monitor Requirements

FR-1001

System runtime shall be monitored.

FR-1002

PLC scan time shall be monitored.

FR-1003

Drive communication status shall be monitored.

FR-1004

Restart count shall be monitored.

FR-1005

Health information shall be available in service mode.

---

# END OF DOCUMENT